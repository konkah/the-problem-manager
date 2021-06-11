from django.shortcuts import render
from .models import Dates
from rest_framework import viewsets, permissions
from tpm_api.serializers import DatesSerializer


class DatesViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Dates.objects.all().order_by('-start')
    serializer_class = DatesSerializer
    permission_classes = [permissions.AllowAny]
