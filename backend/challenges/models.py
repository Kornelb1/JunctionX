from django.db import models


class Post(models.Model):
    challenge = models.ForeignKey(
        "Challenge", null=False, blank=False, on_delete=models.CASCADE
    )
    photo = models.FileField()
    title = models.CharField(max_length=127)
    owner = models.ForeignKey(
        "users.User", null=False, blank=False, related_name="posts", on_delete=models.CASCADE
    )
    liked_by = models.ManyToManyField("users.User", blank=True, related_name="likes")

    datetime = models.DateTimeField(auto_now_add=True)

    verified = models.BooleanField(default=False)


class Sponsor(models.Model):
    name = models.CharField(max_length=63)
    logo = models.FileField()

    def __str__(self):
        return f"{self.name}"


class Challenge(models.Model):
    title = models.CharField(null=False, blank=False, max_length=255)
    short_description = models.TextField(null=False, blank=False, max_length=280)
    reward = models.CharField(null=True, blank=True, max_length=280)
    proof = models.CharField(null=True, blank=True, max_length=280)
    long_description = models.TextField(null=False, blank=False)

    photo = models.FileField()
    start_date = models.DateTimeField(null=True, blank=True)
    end_date = models.DateTimeField(null=True, blank=True)

    sponsor = models.ForeignKey(
        "Sponsor", null=True, blank=True, on_delete=models.SET_NULL
    )
    owner = models.ForeignKey(
        "users.User", null=False, blank=False, on_delete=models.CASCADE
    )

    emissions = models.FloatField(
        default=0.0, help_text="Amount in kilograms of CO2 saved"
    )  # kilo ton / kilograms - steps
    water = models.FloatField(
        default=0.0, help_text="Amount in litres of water saved"
    )  # litres
    energy = models.FloatField(
        default=0.0, help_text="Amount in watts of energy saved"
    )  # watts
    plastic = models.FloatField(
        default=0.0, help_text="Amount in bottles of plastic saved"
    )  # bottles
    trees = models.FloatField(default=0.0, help_text="Number of trees planted")  # trees

    def __str__(self):
        return f"{self.title}"


class Participant(models.Model):
    user = models.ForeignKey(
        "users.User", null=False, blank=False, on_delete=models.CASCADE
    )
    challenge = models.ForeignKey(
        "Challenge", null=False, blank=False, related_name="participants", on_delete=models.CASCADE
    )
