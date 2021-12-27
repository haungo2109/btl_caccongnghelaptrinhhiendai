# Generated by Django 3.2.5 on 2021-12-20 02:02

from django.conf import settings
import django.contrib.auth.models
import django.contrib.auth.validators
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone
import social_network.ultis


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
                ('phone', models.CharField(max_length=11, null=True, unique=True)),
                ('avatar', models.ImageField(default=None, null=True, upload_to=social_network.ultis.user_directory_path)),
                ('address', models.CharField(max_length=255, null=True)),
                ('birthday', models.DateField(null=True)),
                ('push_token', models.CharField(default='none', max_length=60, null=True)),
                ('rating', models.IntegerField(null=True)),
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
                ('title', models.CharField(default='Auction', max_length=225)),
                ('active', models.BooleanField(default=True)),
                ('count_comment', models.IntegerField(default=0)),
                ('base_price', models.FloatField(default=0)),
                ('condition', models.TextField(blank=True, default='No condition', null=True)),
                ('deadline', models.DateTimeField()),
                ('date_success', models.DateTimeField(null=True)),
                ('accept_price', models.FloatField(default=0, null=True)),
                ('status_auction', models.CharField(choices=[('succ', 'Sản phẩm đã được giao dịch thành công'), ('fail', 'Dấu giá sản phẩm đã bị hủy'), ('being auctioned', 'Sản phẩm đang được đấu giá'), ('in process', 'Sản phẩm trang trong quá trình chuyển giao khách hàng')], default='being auctioned', max_length=20)),
                ('rating', models.IntegerField(null=True)),
                ('buyer', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='auction_bought', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at'],
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='CategoryAuction',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
            ],
        ),
        migrations.CreateModel(
            name='Feedback',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.TextField(blank=True, null=True)),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='HashTagPost',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='PaymentMethod',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=20)),
            ],
        ),
        migrations.CreateModel(
            name='Post',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('count_comment', models.IntegerField(default=0)),
                ('active', models.BooleanField(default=True)),
                ('hashtag', models.ManyToManyField(blank=True, related_name='hashtag_posts', to='social_network.HashTagPost')),
                ('like', models.ManyToManyField(blank=True, related_name='post_liked', to=settings.AUTH_USER_MODEL)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='posts', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['-count_comment'],
            },
        ),
        migrations.CreateModel(
            name='ReportType',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='PostReport',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('post', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='post_reports', to='social_network.post')),
                ('type', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='post_types', to='social_network.reporttype')),
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
                ('image', models.ImageField(default=None, null=True, upload_to='static/post_images/%Y/%m')),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='post_images', to='social_network.post')),
            ],
        ),
        migrations.CreateModel(
            name='PostComment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('post', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='post_comments', to='social_network.post')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at'],
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='AuctionReport',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('auction', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='auction_reports', to='social_network.auction')),
                ('type', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='auction_types', to='social_network.reporttype')),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at'],
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='AuctionImage',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('image', models.ImageField(default=None, null=True, upload_to='static/auction_images/%Y/%m')),
                ('auction', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='auction_images', to='social_network.auction')),
            ],
        ),
        migrations.CreateModel(
            name='AuctionComment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(blank=True, null=True)),
                ('create_at', models.DateTimeField(auto_now_add=True, null=True)),
                ('price', models.FloatField()),
                ('status_transaction', models.CharField(choices=[('succ', 'Giao dịch thành công'), ('fail', 'Giao dịch đã bị hủy'), ('in process', 'Hai bên đag giao dịch'), ('none', 'Chưa giao dịch')], default='none', max_length=25)),
                ('auction', models.ForeignKey(default='anonymous', on_delete=django.db.models.deletion.CASCADE, related_name='auction_comments', to='social_network.auction')),
                ('user', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ['create_at', 'price'],
            },
        ),
        migrations.AddField(
            model_name='auction',
            name='category',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='auctions', to='social_network.categoryauction'),
        ),
        migrations.AddField(
            model_name='auction',
            name='like',
            field=models.ManyToManyField(blank=True, related_name='auction_liked', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='auction',
            name='payment_method',
            field=models.ForeignKey(default=2, null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='aution_pay_method', to='social_network.paymentmethod'),
        ),
        migrations.AddField(
            model_name='auction',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='auctions', to=settings.AUTH_USER_MODEL),
        ),
    ]