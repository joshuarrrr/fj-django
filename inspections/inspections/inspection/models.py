# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

from inspections.restaurant.models import Restaurant


# Create your models here.
class Inspection(models.Model):
    """
    Defines a single inspection
    From the data source.
        u'type',
        u'inspection_id',
        u'risk_category',

        u'inspection_url',

        u'inspection_date',

        u'critical',
        u'noncritical',
        u'critical_corrected_on_site',
        u'noncritical_corrected_on_site',

        u'restaurant',
    """

    inspection_type = models.CharField(max_length=255)
    inspection_id = models.CharField(max_length=255)
    risk_category = models.CharField(max_length=255)
    time_in = models.DateTimeField(null=True)
    time_out = models.DateTimeField(null=True)
    inspection_url = models.TextField()
    critical = models.IntegerField(default=0)
    noncritical = models.IntegerField(default=0)
    critical_corrected_on_site = models.IntegerField(default=0)
    noncritical_corrected_on_site = models.IntegerField(default=0)
    restaurant = models.ForeignKey(Restaurant, null=True, blank=True)

    def __unicode__(self):
        return 'Inspection #%s: %s' % (self.inspection_id, self.restaurant.title)


class Observation(models.Model):
    """
    Defines a single inspection observation.
    From the data source.
        u'correction'
        u'observation'
        u'dcmr'
    """

    correction = models.TextField()
    observation = models.TextField()
    dcmr = models.TextField()
    inspection = models.ForeignKey(Inspection, null=True, blank=True)

    def __unicode__(self):
        return 'Observation %s: %s' % (self.dcmr, self.inspection.inspection_id)
