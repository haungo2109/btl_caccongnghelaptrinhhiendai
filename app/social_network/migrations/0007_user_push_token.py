# Generated by Django 3.2.5 on 2021-09-18 10:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('social_network', '0006_auction_payment_method'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='push_token',
            field=models.CharField(default='none', max_length=60, null=True),
        ),
    ]
