from django.db import models


class Captions(models.Model):
    file = models.FileField()
    text = models.CharField(blank=True, max_length=280)
