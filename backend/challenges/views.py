from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from .models import Challenge, Post, Participant
from .serializers import ChallengeSerializer, PostSerializer


class ChallengeViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Challenge.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = ChallengeSerializer


class ChallengeFeedViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = PostSerializer

    def get_queryset(self):
        qs = self.queryset
        print("ah")
        # All posts for all my challenges
        only_my_challenges = self.request.query_params.get("my_challenges", None)
        if only_my_challenges:
            me = self.request.user
            # Filter by challenges which I am a participant
            my_challenges = Participant.objects.filter(user=me).values_list("challenge", flat=True)

            # Filter posts by those challenges
            qs = qs.filter(challenge__in=my_challenges)
            return qs
        print("Huh")
        # All posts for challenge
        challenge = self.request.query_params.get("challenge", None)
        if challenge:
            print(qs)
            qs = qs.filter(challenge__pk=challenge.pk)
            print(qs)
        return qs
