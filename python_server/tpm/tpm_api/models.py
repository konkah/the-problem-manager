from django.db import models
import datetime

class Dates(models.Model):
    start = models.DateField('Data Início')
    end = models.DateField('Data Fim')

    def __str__(self):
        return self.start+" até "+self.end