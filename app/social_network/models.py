from django.db import models

class User(models.Model):
    username = models.CharField(max_length=20, unique=True)
    password = models.CharField(max_length=255)
    name = models.CharField(max_length=100)
    phone = models.CharField(max_length=11, unique=True)
    email = models.CharField(max_length=255)
    avatar = models.CharField(max_length=255)
    location = models.CharField(max_length=255)

    def __str__(self):
        return self.name


class BaseInfo(models.Model):
    content = models.CharField(max_length=20, unique=True)
    createAt = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.content


class Report(BaseInfo):
    type = models.CharField(max_length=255)


class Comment(BaseInfo):
    vote = models.IntegerField()


class CommentAuction(Comment):
    point = models.IntegerField()
    price = models.FloatField()


class Post(BaseInfo):
    vote = models.IntegerField()
    image = models.CharField(max_length=255)


class Auction(Post):
    basePrice = models.FloatField()
    condition = models.CharField(max_length=1000)
    deadline = models.DateField()
    acceptPrice = models.FloatField()