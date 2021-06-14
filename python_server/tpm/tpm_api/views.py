from django.shortcuts import render
from .models import Period
from rest_framework import viewsets, permissions
from tpm_api.serializers import PeriodSerializer


class PeriodViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = Period.objects.all().order_by('-start')
    serializer_class = PeriodSerializer
    permission_classes = [permissions.AllowAny]
