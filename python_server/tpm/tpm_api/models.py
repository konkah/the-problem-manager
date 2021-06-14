from django.db import models

class Period(models.Model):
    start = models.DateField('Data Início')
    end = models.DateField('Data Fim')

    def __str__(self):
        return self.start+" até "+self.end