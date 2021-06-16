from .models import Period, Registration
from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
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

    @action(detail=False, methods=['get'])
    def test(self, request):
        return Response({})

    def create(self, request):
        serializer = RegistrationSerializer(data=request.data)

        if serializer.is_valid():
            return Response(serializer.save_with_parent())
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get_permissions(self):
        if self.action == 'create':
            permission_classes = [permissions.AllowAny]
        else:
            permission_classes = [permissions.IsAdminUser]

        return [permission() for permission in permission_classes]