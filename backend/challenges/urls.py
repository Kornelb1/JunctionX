from django.urls import path, include
from rest_framework.routers import SimpleRouter

from . import views

router = SimpleRouter()
router.register(r"challenges", views.ChallengeViewSet, basename="challenges")
router.register(r"feeds", views.ChallengeFeedViewSet, basename="feeds")


urlpatterns = [
    path("", include(router.urls)),
]
