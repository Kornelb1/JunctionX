# Generated by Django 4.1.2 on 2023-04-04 13:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("challenges", "0002_alter_challenge_sponsor"),
    ]

    operations = [
        migrations.AlterField(
            model_name="challenge",
            name="end_date",
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name="challenge",
            name="start_date",
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
