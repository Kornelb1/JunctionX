# Generated by Django 4.1.2 on 2023-04-05 05:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('challenges', '0008_remove_post_likes_post_liked_by_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='post',
            name='verified',
            field=models.BooleanField(default=False),
        ),
    ]
