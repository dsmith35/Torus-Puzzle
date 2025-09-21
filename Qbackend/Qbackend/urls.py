# Qbackend/urls.py
from django.contrib import admin
from django.urls import include, path, re_path
from rest_framework import routers
from users import views
from django.views.generic import TemplateView

router = routers.DefaultRouter()
router.register(r'scores', views.ScoresView, 'scores')

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/users/', include('users.urls')),
    path('api/', include(router.urls)),
    path('vs_bot/', include('vs_bot.urls')),

    # Catch-all for React frontend
    re_path(r'^.*$', TemplateView.as_view(template_name='index.html'), name='index'),
]
