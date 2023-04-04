from rest_framework import serializers

from .models import Challenge, Post


class ChallengeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Challenge
        fields = [
            "id",
            "title",
            "description",
            "start_date",
            "end_date",
            "sponsor",
            "owner",
            "photo",
        ]


class PostSerializer(serializers.ModelSerializer):
    # Profile Pic
    # Name
    profile_picture = serializers.FileField(source="owner.profile_picture")
    name = serializers.CharField(source="owner.first_name")

    class Meta:
        model = Post
        fields = [
            "challenge",
            "photo",
            "title",
            "owner",
            "profile_picture",
            "name",
            "likes",
            "datetime",
        ]
