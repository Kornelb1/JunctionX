from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from .models import Challenge, Post, Participant
from .serializers import (
    ChallengeSerializer,
    PostSerializer,
    ParticipantSerializer,
)


class ChallengeViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Challenge.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = ChallengeSerializer


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = PostSerializer
    search_fields = ['title']

    def get_queryset(self):
        qs = self.queryset
        print(self.request)
        # All posts for all my challenges
        only_my_challenges = self.request.query_params.get("my_challenges", None)
        if only_my_challenges:
            me = self.request.user
            # Filter by challenges which I am a participant
            my_challenges = Participant.objects.filter(user=me).values_list("challenge", flat=True)

            # Filter posts by those challenges
            qs = qs.filter(challenge__in=my_challenges)
            return qs

        # All posts for challenge
        challenge = self.request.query_params.get("challenge", None)
        if challenge:
            qs = qs.filter(challenge__pk=challenge)
        return qs


class ParticipantViewSet(viewsets.ModelViewSet):
    queryset = Participant.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = ParticipantSerializer
