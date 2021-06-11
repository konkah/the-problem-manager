from .models import Dates
from rest_framework import serializers


class DatesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dates
        fields = "__all__"