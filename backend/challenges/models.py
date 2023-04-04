from django.db import models


class Post(models.Model):
    challenge = models.ForeignKey("Challenge", null=False, blank=False, on_delete=models.CASCADE)
    photo = models.FileField()
    title = models.CharField(max_length=127)
    owner = models.ForeignKey("users.User", null=False, blank=False, on_delete=models.CASCADE)
    likes = models.PositiveIntegerField(default=0)

    datetime = models.DateTimeField(auto_now_add=True)


class Sponsor(models.Model):
    name = models.CharField(max_length=63)
    logo = models.FileField()

    def __str__(self):
        return f"{self.name}"


class Challenge(models.Model):
    title = models.CharField(null=False, blank=False, max_length=255)
    description = models.TextField(null=False, blank=False)

    photo = models.FileField()
    start_date = models.DateTimeField(null=True, blank=True)
    end_date = models.DateTimeField(null=True, blank=True)

    sponsor = models.ForeignKey(
        "Sponsor", null=True, blank=True, on_delete=models.SET_NULL
    )
    owner = models.ForeignKey(
        "users.User", null=False, blank=False, on_delete=models.CASCADE
    )

    def __str__(self):
        return f"{self.title}"


class Participant(models.Model):
    user = models.ForeignKey("users.User", null=False, blank=False, on_delete=models.CASCADE)
    challenge = models.ForeignKey("Challenge", null=False, blank=False, on_delete=models.CASCADE)
