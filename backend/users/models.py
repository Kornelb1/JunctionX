from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager
from django.contrib.auth.models import PermissionsMixin
from django.db import models

from typing import Optional


class UserManager(BaseUserManager):
    """
    Custom user model manager where email is the unique identifier
    for authentication instead of usernames.
    """

    def create_user(
        self,
        email: str,
        *args,
        password: Optional[str] = None,
        **kwargs,
    ) -> "User":
        """Create and save a User with the given email and password,
        also sets their groups, and enrolls the user to a school.

        Args:
            email: Required username associated field.
            school: School that the user belongs to.
            TODO: profile_picture: The user's profile picture.
            groups: The groups that the student belongs to.
            password: The user's password.

        Returns:
            A new user object.
        """
        if not email:
            raise ValueError("The email must be set.")

        email = self.normalize_email(email)
        user = super().create(email=email, *args, **kwargs)

        # TODO: Profile Picture
        # if profile_picture is None:
        #     raise ValueError(
        #         "Cannot set a profile picture for a new user without a school"
        #     )

        if password is not None:
            user.set_password(password)
        user.save()

        return user

    def create_superuser(self, email, password, **extra_fields):
        """
        Create and save a SuperUser with the given email and password.
        """
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)
        extra_fields.setdefault("is_active", True)

        if extra_fields.get("is_staff") is not True:
            raise ValueError("Superuser must have is_staff=True.")
        if extra_fields.get("is_superuser") is not True:
            raise ValueError("Superuser must have is_superuser=True.")
        return self.create_user(email=email, password=password, **extra_fields)


class User(AbstractBaseUser, PermissionsMixin):
    """
    Custom user model to add verification field and assign the email as the username field.
    """

    email = models.EmailField(max_length=255, unique=True)
    username = models.CharField(max_length=255, unique=True, null=True, blank=True)
    first_name = models.CharField(max_length=255, null=True, blank=True)
    last_name = models.CharField(max_length=255, null=True, blank=True)

    profile_picture = models.FileField(null=True, blank=True)
    friends = models.ManyToManyField("User", blank=True)

    # Permissions field.
    is_verified = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_superuser = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    objects = UserManager()
    USERNAME_FIELD = "email"

    def __str__(self):
        return f"{self.last_name}, {self.first_name} - {self.email}"


class Profile(models.Model):
    pass


class Stats(models.Model):
    emissions = models.FloatField(default=0.0, help_text="Amount in kilograms of CO2 saved") # kilo ton / kilograms - steps
    water = models.FloatField(default=0.0, help_text="Amount in litres of water saved") # litres
    energy = models.FloatField(default=0.0, help_text="Amount in watts of energy saved") # watts
    plastic = models.FloatField(default=0.0, help_text="Amount in bottles of plastic saved") # bottles
    trees = models.FloatField(default=0.0, help_text="Number of trees planted") # trees


class FriendRequest(models.Model):
    from_user = models.ForeignKey("User", related_name="from_user", on_delete=models.CASCADE)
    to_user = models.ForeignKey("User", related_name="to_user", on_delete=models.CASCADE)
