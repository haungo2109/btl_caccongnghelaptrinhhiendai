# Generated by Django 3.2.5 on 2021-09-17 13:09

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('social_network', '0003_rename_payment_methods_auction_payment_method'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='auction',
            name='payment_method',
        ),
    ]