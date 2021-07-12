from .models import Period, Registration
from rest_framework import serializers
from django.contrib.auth.models import User


class PeriodSerializer(serializers.ModelSerializer):
    class Meta:
        model = Period
        fields = "__all__"

class RegistrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Registration
        fields = ["name", "personName", "samePerson", "email", "password"]
        depth = 1

    email = serializers.CharField(write_only=True)
    password = serializers.CharField(write_only=True, style={'input_type': 'password'})

    def save_with_parent(self):
        data = self.validated_data

        user = User.objects.create_user(
            data['email'],
            data['email'],
            data['password'],
        )
        user.save()

        registration = Registration(
            name=data['name'],
            personName=data['personName'],
            samePerson=data['samePerson'],
            user=user
        )

        registration.save()

        return registration.id