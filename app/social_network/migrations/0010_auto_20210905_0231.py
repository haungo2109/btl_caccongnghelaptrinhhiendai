# Generated by Django 3.2.5 on 2021-09-05 02:31

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('social_network', '0009_auction_date_success'),
    ]

    operations = [
        migrations.CreateModel(
            name='RepostType',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
            ],
        ),
        migrations.AlterField(
            model_name='auctionreport',
            name='content',
            field=models.CharField(max_length=300, null=True),
        ),
        migrations.AlterField(
            model_name='postreport',
            name='content',
            field=models.CharField(max_length=300, null=True),
        ),
        migrations.AlterField(
            model_name='auctionreport',
            name='type',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='auction_types', to='social_network.reposttype'),
        ),
        migrations.AlterField(
            model_name='postreport',
            name='type',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='post_types', to='social_network.reposttype'),
        ),
    ]