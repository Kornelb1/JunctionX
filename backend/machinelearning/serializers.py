from rest_framework import serializers
from .models import Captions


class CaptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Captions
        fields = [
            "file",
            "text",
        ]
