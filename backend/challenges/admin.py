from django.contrib import admin

from .models import Challenge, Sponsor, Post, Participant


@admin.register(Challenge)
class ChallengeAdmin(admin.ModelAdmin):
    list_display = (
        "title",
        "owner",
        "sponsor",
        "start_date",
        "end_date",
    )
    list_display_links = ("title",)
    fields = (
        "title",
        "short_description",
        "proof",
        "reward",
        "long_description",
        "photo",
        "owner",
        "sponsor",
        "start_date",
        "end_date",
        "emissions",
        "water",
        "energy",
        "plastic",
        "trees",
    )
    search_fields = ("title",)


@admin.register(Sponsor)
class SponsorAdmin(admin.ModelAdmin):
    list_display = ("name",)
    list_display_links = ("name",)
    fields = (
        "name",
        "logo",
    )
    search_fields = ("name",)


@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ("title", "challenge", "owner", "datetime")
    list_display_links = ("title",)
    fields = (
        "challenge",
        "photo",
        "title",
        "owner",
        "liked_by",
        "datetime",
    )
    readonly_fields = ["datetime"]
    search_fields = ("name",)


@admin.register(Participant)
class ParticipantAdmin(admin.ModelAdmin):
    list_display = ("user", "challenge")
    list_display_links = ("user",)
    fields = (
        "user",
        "challenge",
    )
    search_fields = ("user", "challenge")
