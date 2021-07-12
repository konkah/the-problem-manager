from django.db import models
from django.contrib.auth.models import User

class Registration(models.Model):
    name = models.CharField('Nome', max_length=255)
    personName = models.CharField('Outra pessoa', max_length=255, null=True, blank=True)
    samePerson = models.BooleanField('Mesma pessoa')
    user = models.ForeignKey(User, on_delete=models.PROTECT)

    def __str__(self):
        if self.samePerson:
            person = "si"
        else:
            person = self.personName
        return "{} cuidando de {}".format(self.name, person)

class Period(models.Model):
    start = models.DateField('Data Início')
    end = models.DateField('Data Fim')
    registration = models.ForeignKey(Registration, on_delete=models.CASCADE)

    def __str__(self):
        return "{} até {}".format(self.start, self.end)