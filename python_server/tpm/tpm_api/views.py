from django.shortcuts import render
from .models import Period, Registration
from rest_framework import viewsets, permissions
from tpm_api.serializers import PeriodSerializer, RegistrationSerializer


class PeriodViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Period.objects.all().order_by('-start')
    serializer_class = PeriodSerializer
    permission_classes = [permissions.AllowAny]

class RegistrationViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Registration.objects.all()
    serializer_class = RegistrationSerializer
    permission_classes = [permissions.AllowAny]