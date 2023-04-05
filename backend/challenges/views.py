from django.db.models.aggregates import Sum, Count
from rest_framework import viewsets, filters, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action
from rest_framework.response import Response

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
    filter_backends = [filters.SearchFilter]
    search_fields = ["title"]

    def get_queryset(self):
        qs = self.queryset
        only_my_challenges = self.request.query_params.get("my_challenges", None)
        if only_my_challenges:
            me = self.request.user
            # Filter by challenges which I am a participant
            my_challenges = Participant.objects.filter(user=me).values_list(
                "challenge", flat=True
            )

            # Filter posts by those challenges
            qs = qs.filter(pk__in=my_challenges)
            return qs

        only_popular = self.request.query_params.get("popular", None)
        if only_popular:
            # Order posts by number of participants
            # Participant.objects.filter(challenge=obj.pk).count()
            qs = qs.annotate(num_participants=Count('participants'))
            qs = qs.order_by("-num_participants")[:6]
            return qs

        return super().get_queryset()

    @action(methods=["GET"], detail=False, url_path="my-stats")
    def my_stats(self, request):
        my_completed_challenges = Post.objects.filter(owner__pk=request.user.pk).filter(verified=True).values_list("challenge")
        values = Challenge.objects.filter(pk__in=my_completed_challenges).values(
            "emissions", "water", "energy", "plastic", "trees"
        ).annotate(
            total_emissions=Sum('emissions')
        ).annotate(
            total_water=Sum('water')
        ).annotate(
            total_energy=Sum('energy')
        ).annotate(
            total_plastic=Sum('plastic')
        ).annotate(
            total_trees=Sum('trees')
        ).values("total_emissions", "total_water", "total_energy", "total_plastic", "total_trees")
        return Response(values, status=status.HTTP_200_OK)

    @action(methods=["GET"], detail=False, url_path="stats")
    def others_stats(self, request):
        user_id = request.query_params.get("user_id")
        completed_challenges = Post.objects.filter(owner__pk=user_id).filter(verified=True).values_list("challenge")
        print(completed_challenges)
        values = Challenge.objects.filter(pk__in=completed_challenges).values(
            "emissions", "water", "energy", "plastic", "trees"
        ).annotate(
            total_emissions=Sum('emissions')
        ).annotate(
            total_water=Sum('water')
        ).annotate(
            total_energy=Sum('energy')
        ).annotate(
            total_plastic=Sum('plastic')
        ).annotate(
            total_trees=Sum('trees')
        ).values("total_emissions", "total_water", "total_energy", "total_plastic", "total_trees")
        return Response(values, status=status.HTTP_200_OK)


class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = PostSerializer

    def get_queryset(self):
        qs = self.queryset
        # All posts for all my challenges
        only_my_challenges = self.request.query_params.get("my_challenges", None)
        if only_my_challenges:
            me = self.request.user
            # Filter by challenges which I am a participant
            my_challenges = Participant.objects.filter(user=me).values_list(
                "challenge", flat=True
            )

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
