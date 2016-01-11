from django.db import models

from django.core.validators import MinValueValidator, MaxValueValidator

# 0111 added   by Sam Kuo
class House(models.Model):
    GroupID = models.CharField(max_length=10)
    Name = models.CharField(max_length=10)

class Nodes(models.Model):
    ID = models.IntegerField(blank=True, null=True,
    						 validators=[MinValueValidator(0),
    							 		 MaxValueValidator(100)])
    Address = models.IntegerField()
    Type = models.CharField(max_length = 2)
    Appliances = models.CharField(max_length = 100)
    # on_delete 指的是外鍵關聯對象刪除後的行為, related_name為反向查詢的名稱
    Group = models.ForeignKey(House, related_name='nodes',
    								 on_delete=models.SET_NULL,
    								 blank=True, null=True)
    Added = models.DateTimeField(auto_now_add=True)
    Updated = DateField(auto_now = True)

class NodeState(models.Model):
	NodeID = models.ForeignKey(Nodes, related_name='states',
    								  on_delete=models.CASCADE)
	State = models.CharField(max_length = 100)
	Added = models.DateTimeField(auto_now_add=True)

class CurrentState(models.Model):
	NodeID = models.ForeignKey(Nodes, related_name='current_states',
    								  on_delete=models.CASCADE)
	State = models.IntegerField(validators=[MinValueValidator(0),
    							 		    MaxValueValidator(2000)])
	Added = models.DateTimeField(auto_now_add=True)

class IRcommend(models.Model):
	NodeID = models.ForeignKey(Nodes, related_name='IRcom',
    								  on_delete=models.CASCADE)
	Commend = models.CharField(max_length = 100)
	RawCode = models.CharField(max_length = 255)

    