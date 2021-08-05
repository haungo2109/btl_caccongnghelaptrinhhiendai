# Generated by Django 3.2.5 on 2021-08-05 03:46

from django.conf import settings
import django.contrib.auth.models
import django.contrib.auth.validators
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('auth', '0012_alter_user_first_name_max_length'),
    ]

    operations = [
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('is_superuser', models.BooleanField(default=False, help_text='Designates that this user has all permissions without explicitly assigning them.', verbose_name='superuser status')),
                ('username', models.CharField(error_messages={'unique': 'A user with that username already exists.'}, help_text='Required. 150 characters or fewer. Letters, digits and @/./+/-/_ only.', max_length=150, unique=True, validators=[django.contrib.auth.validators.UnicodeUsernameValidator()], verbose_name='username')),
                ('first_name', models.CharField(blank=True, max_length=150, verbose_name='first name')),
                ('last_name', models.CharField(blank=True, max_length=150, verbose_name='last name')),
                ('email', models.EmailField(blank=True, max_length=254, verbose_name='email address')),
                ('is_staff', models.BooleanField(default=False, help_text='Designates whether the user can log into this admin site.', verbose_name='staff status')),
                ('is_active', models.BooleanField(default=True, help_text='Designates whether this user should be treated as active. Unselect this instead of deleting accounts.', verbose_name='active')),
                ('date_joined', models.DateTimeField(default=django.utils.timezone.now, verbose_name='date joined')),
                ('phone', models.CharField(max_length=11, unique=True)),
                ('avatar', models.ImageField(default=None, upload_to='upload/%Y/%m')),
                ('address', models.CharField(max_length=255)),
                ('birthday', models.DateField()),
                ('groups', models.ManyToManyField(blank=True, help_text='The groups this user belongs to. A user will get all permissions granted to each of their groups.', related_name='user_set', related_query_name='user', to='auth.Group', verbose_name='groups')),
                ('user_permissions', models.ManyToManyField(blank=True, help_text='Specific permissions for this user.', related_name='user_set', related_query_name='user', to='auth.Permission', verbose_name='user permissions')),
            ],
            options={
                'verbose_name': 'user',
                'verbose_name_plural': 'users',
                'abstract': False,
            },
            managers=[
                ('objects', django.contrib.auth.models.UserManager()),
            ],
        ),
        migrations.CreateModel(
            name='Auction',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('vote', models.IntegerField(default=0)),
                ('image', models.CharField(max_length=255)),
                ('base_price', models.FloatField(default=0)),
                ('condition', models.CharField(default=None, max_length=1000)),
                ('deadline', models.DateTimeField()),
                ('accept_price', models.FloatField(null=True)),
                ('status_auction', models.CharField(choices=[('succ', 'Sản phẩm đã được giao dịch thành công'), ('fail', 'Dấu giá sản phẩm đã bị hủy'), ('being auctioned', 'Sản phẩm đang được đấu giá'), ('in process', 'Sản phẩm trang trong quá trinfg chuyển giao đấu giá')], default='in process', max_length=20)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='auctions', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at'],
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Post',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('vote', models.IntegerField(default=0)),
                ('image', models.CharField(max_length=255)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='posts', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at'],
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='Report',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('type', models.CharField(max_length=255)),
                ('post', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='reposts', to='social_network.post')),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at'],
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='PostImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.CharField(max_length=100)),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='post_images', to='social_network.post')),
            ],
        ),
        migrations.CreateModel(
            name='CommentPost',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('vote', models.IntegerField(default=0)),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='post_comments', to='social_network.post')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at'],
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='CommentAuction',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('price', models.FloatField()),
                ('status_transaction', models.CharField(choices=[('succ', 'Giao dịch thành công'), ('fail', 'Giao dịch đã bị hủy'), ('in process', 'Hai bên đag giao dịch'), ('none', 'Chưa giao dịch')], default='none', max_length=11)),
                ('auction', models.ForeignKey(default='anonymous', on_delete=django.db.models.deletion.CASCADE, related_name='auction_comments', to='social_network.auction')),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at', 'price'],
            },
        ),
        migrations.CreateModel(
            name='AuctionImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.CharField(max_length=100)),
                ('auction', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='auction_images', to='social_network.auction')),
            ],
        ),
    ]
