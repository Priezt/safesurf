#!/usr/bin/env python
# -*- coding: utf-8 -*-

from django.conf.urls import include, url
from django.views.generic.base import RedirectView
from . import views

urlpatterns = [
    url(r'^jump/', views.jump_to_guacamole),
    url(r'^.*', views.open_url),
]
