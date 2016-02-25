# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from django.views.generic import TemplateView
from django.views import defaults as default_views


urlpatterns = [
    # url(r'^$', TemplateView.as_view(template_name='pages/home.html'), name="home"),
    url(r'^$', TemplateView.as_view(template_name='pages/index.html'), name="index"),
    url(r'roomLiving.html', TemplateView.as_view(template_name='pages/roomLiving.html'), name="roomLiving"),
    url(r'roomEnvironment.html', TemplateView.as_view(template_name='pages/roomEnvironment.html'), name="roomEnvironment"),
    url(r'roomSchedule.html', TemplateView.as_view(template_name='pages/roomSchedule.html'), name="roomSchedule"),
    url(r'roomCurrentStat.html', TemplateView.as_view(template_name='pages/roomCurrentStat.html'), name="roomCurrentStat"),
    url(r'roomMainRoom.html', TemplateView.as_view(template_name='pages/roomMainRoom.html'), name="roomMainRoom"),
    url(r'^about/$', TemplateView.as_view(template_name='pages/about.html'), name="about"),


    # Django Admin, use {% url 'admin:index' %}
    url(settings.ADMIN_URL, include(admin.site.urls)),

    # User management
    url(r'^users/', include("SmartHome.users.urls", namespace="users")),
    url(r'^accounts/', include('allauth.urls')),

    # Your stuff: custom urls includes go here
    url(r'^api/', include('SmartHome.api.urls')),


] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

if settings.DEBUG:
    # This allows the error pages to be debugged during development, just visit
    # these url in browser to see how these error pages look like.
    urlpatterns += [
        url(r'^400/$', default_views.bad_request, kwargs={'exception': Exception("Bad Request!")}),
        url(r'^403/$', default_views.permission_denied, kwargs={'exception': Exception("Permissin Denied")}),
        url(r'^404/$', default_views.page_not_found, kwargs={'exception': Exception("Page not Found")}),
        url(r'^500/$', default_views.server_error),
    ]
