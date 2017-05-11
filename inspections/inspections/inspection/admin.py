# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin

from inspections.inspection.models import Inspection
from inspections.inspection.models import Observation


# Register your models here.
admin.site.register(Inspection)
admin.site.register(Observation)
