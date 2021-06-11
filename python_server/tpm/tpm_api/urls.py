from django.urls import include, path
from rest_framework import routers
from tpm_api import views

router = routers.DefaultRouter()
router.register(r'dates', views.DatesViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', include(router.urls)),
]