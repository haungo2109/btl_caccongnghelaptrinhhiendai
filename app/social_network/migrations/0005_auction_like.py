# Generated by Django 3.2.5 on 2021-09-02 03:32

from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('social_network', '0004_post_like'),
    ]

    operations = [
        migrations.AddField(
            model_name='auction',
            name='like',
            field=models.ManyToManyField(blank=True, related_name='auction_liked', to=settings.AUTH_USER_MODEL),
        ),
    ]
