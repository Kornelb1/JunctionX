from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from .models import Challenge
from .serializers import ChallengeSerializer


class ChallengeViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Challenge.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = ChallengeSerializer
