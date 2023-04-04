from django.contrib import admin

from .models import Challenge, Sponsor


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
        "description",
        "photo",
        "owner",
        "sponsor",
        "start_date",
        "end_date",
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
