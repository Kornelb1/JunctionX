from django.conf import settings
from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from transformers import (
    VisionEncoderDecoderModel,
    ViTImageProcessor,
    AutoTokenizer,
)
import torch
from PIL import Image

from .models import Captions
from .serializers import CaptionSerializer

# ViT Captioning attributes
model = VisionEncoderDecoderModel.from_pretrained(
    "nlpconnect/vit-gpt2-image-captioning"
)
feature_extractor = ViTImageProcessor.from_pretrained(
    "nlpconnect/vit-gpt2-image-captioning"
)
tokenizer = AutoTokenizer.from_pretrained("nlpconnect/vit-gpt2-image-captioning")
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)
max_length = 16
num_beams = 4
gen_kwargs = {"max_length": max_length, "num_beams": num_beams}


def predict_step(image_paths):
    images = []
    for image_path in image_paths:
        i_image = Image.open(image_path)
        if i_image.mode != "RGB":
            i_image = i_image.convert(mode="RGB")

        images.append(i_image)

    pixel_values = feature_extractor(images=images, return_tensors="pt").pixel_values
    pixel_values = pixel_values.to(device)

    output_ids = model.generate(pixel_values, **gen_kwargs)

    preds = tokenizer.batch_decode(output_ids, skip_special_tokens=True)
    preds = [pred.strip() for pred in preds]
    return preds


class ComputerVisionViewSet(viewsets.ModelViewSet):
    queryset = Captions.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = CaptionSerializer

    @action(methods=["POST"], detail=False, url_path="predict_caption")
    def predict_caption(self, request, **kwargs):
        image_path = self.request.query_param.get('image_path', None)
        word = self.request.query_param.get('word', None)
        if not image_path:
            return Response("Please set image path as a valid post image (media/{image_name})")
        file = settings.MEDIA_ROOT + image_path
        verified = False
        caption, created = Captions.objects.get_or_create(file=file)
        if created:
            # Single prediction is incredible inefficient, but this is for demo only.
            new = predict_step(
                [file]
                # ["data/WIN_20230404_22_25_13_Pro.jpg"]
            )[0]
            if word in new:
                verified = True
            caption.text = new
            caption.save()
            return Response({"caption": f"{new}", "word_to_detect": word, "verified": verified}, status=status.HTTP_201_CREATED)
        else:
            if word in caption.text:
                verified = True
            return Response({"caption": f"{caption.text}", "word_to_detect": word, "verified": verified}, status=status.HTTP_200_OK)
