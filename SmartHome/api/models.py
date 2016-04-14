from django.db import models

from django.core.validators import MinValueValidator, MaxValueValidator

import datetime


# 0111 added   by Sam Kuo
class House(models.Model):
    GroupID = models.CharField(max_length=10)
    Name = models.CharField(max_length=10)

    def __str__(self): # 改變print(object)的呈現方式，Debug方便
        return self.Name


class Nodes(models.Model):
    ID = models.IntegerField(validators=[MinValueValidator(0),
                                         MaxValueValidator(100)])
    Address = models.CharField(max_length = 100)
    Type = models.CharField(max_length = 2, blank=True, null=True)
    Appliances = models.CharField(max_length = 100, blank=True, null=True)
    # on_delete 指的是外鍵關聯對象刪除後的行為, related_name為反向查詢的名稱
    Group = models.ForeignKey(House, related_name='nodes',
                                     on_delete=models.SET_NULL,
                                     blank=True, null=True)
    Added = models.DateTimeField(default=datetime.datetime.now)
    Updated = models.DateTimeField(default=datetime.datetime.now)

    def __str__(self):
        return str(self.ID)


class NodeState(models.Model):
    NodeID = models.ForeignKey(Nodes, related_name='states',
                                      on_delete=models.CASCADE)
    State = models.CharField(max_length = 100)
    Added = models.DateTimeField(default=datetime.datetime.now)
    
    def __str__(self):
        return str(self.NodeID)+'-'+str(self.State)


class CurrentState(models.Model):
    NodeID = models.ForeignKey(Nodes, related_name='current_states',
                                      on_delete=models.CASCADE)
    State = models.IntegerField(validators=[MinValueValidator(0),
                                            MaxValueValidator(2000)])
    Added = models.DateTimeField(default=datetime.datetime.now)

    def __str__(self):
        return str(self.NodeID)+'-'+str(self.State)


class IRcommend(models.Model):
    NodeID = models.ForeignKey(Nodes, related_name='IRcom',
                                      on_delete=models.CASCADE)
    Commend = models.CharField(max_length = 100)
    RawCode = models.CharField(max_length = 1000)

    def __str__(self):
        return str(self.NodeID)+'-'+str(self.Commend)


class TaskSchedule(models.Model):
    NodeID = models.ForeignKey(Nodes, related_name='Tasks',
                                      on_delete=models.CASCADE)
    triggerTime = models.DateTimeField()
    Commend = models.CharField(max_length = 100)
    completed = models.BooleanField()
    queued = models.BooleanField()

    def __str__(self):
        return str(self.NodeID)



    