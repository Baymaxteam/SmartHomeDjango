# use for our data representations
# You can also use primary key and various other relationships, 
# but hyperlinking is good RESTful design.

#from django.contrib.auth.models import User, Group
from .models import House, Nodes, NodeState, CurrentState, IRcommend, TaskSchedule
from rest_framework import serializers
import pytz, datetime
# 
# import datetime

class HouseSerializer(serializers.ModelSerializer):
	GroupID = serializers.CharField(max_length=10)
	Name = serializers.CharField(max_length=10)
	nodes = serializers.SerializerMethodField('node_list')
	
	class Meta:
		model = House
		fields = ('GroupID', 'Name', 'nodes') # fields 回傳group耗電量

	def create(self, validated_data):
		return House.objects.create(**validated_data)

	def update(self, instance, validated_data):
		instance.GroupID = validated_data.get('GroupID', instance.GroupID)
		instance.Name = validated_data.get('Name', instance.Name)
		instance.save()
		return instance

	def node_list(self, obj):
		node_list = obj.nodes.all() 
		return [str(x.ID) for x in node_list]


class NodesStateSerializer(serializers.ModelSerializer):
	def to_representation(self, value):
		return 'Test Node State'
	# State = serializers.CharField(max_length=100)
	# Added = serializers.DateTimeField(read_only=True)
	# class Meta:
	# 	model = NodeState
	# 	fields = ('State', 'Added')


class CurrentStateSerializer(serializers.ModelSerializer):
	State = serializers.IntegerField(min_value=0)
	Added = serializers.DateTimeField(read_only=True)

	class Meta:
		model = CurrentState
		fields = ('State', 'Added')


class NodesSerializer(serializers.ModelSerializer):
	# CharField(max_length=None, min_length=None, allow_blank=False, allow_null=True, trim_whitespace=True)
	ID = serializers.IntegerField(min_value = 0)
	Address = serializers.CharField(max_length = 100)
	Type = serializers.CharField(max_length=3)
	Group = serializers.CharField(max_length=4, allow_blank=True, allow_null=True)
	Added = serializers.DateTimeField(required=False, read_only=True) #timezone.now()
	Updated = serializers.DateTimeField(required=False)
	State = serializers.SerializerMethodField('node_state')
	CurrentState = serializers.SerializerMethodField('node_Amp')

	class Meta:
		model = Nodes
		fields = ('ID', 'Address', 'Type', 'Appliances', 'Group','Added', 'Updated', 'State', 'CurrentState')
	
	def node_state(self, obj):
		return obj.states.last().State # 要回傳字串 #回傳最後一筆狀態

	def node_Amp(self, obj):
		year = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).year
		month = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).month
		day = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).day
		try: 
			current = str(float(obj.current_states.filter(Added__year=year).filter(Added__month=month).filter(Added__day=day).last().State)*10)#轉換成毫安培mA單位 #只取今天有傳值的
		except:
			current = '0'
		return current 
		
	# def node_state(self, obj):
	# 	end_date = datetime.datetime.now()
	# 	start_date = end_date - datetime.timedelta(days=1)
	# 	NodeState.objects.filter(Added__range=(start_date, end_date))
	# 	return obj.states.State # 要回傳字串

	# def node_Amp(self, obj):
	# 	return obj.current_states.last().State



	# def create(self, validated_data):
	# 	Group = validated_data.get['Group']
	# 	try:
	# 		house = House.objects.get(GroupID = Group)
	# 	except House.DoesNotExist:
	# 		house = None
	# 	validated_data['Group'] = house
	# 	validated_data['Added'] = timezone.now()
	# 	validated_data['Updated'] = timezone.now()
	# 	return Nodes.objects.create(**validated_data)
		
	# def update(self, instance, validated_data):
	# 	instance.ID = validated_data.get('ID', instance.ID)
	# 	instance.Address = validated_data.get('Address', instance.Address)
	# 	instance.Type = validated_data.get('Type', instance.Type)
	# 	instance.Appliances = validated_data.get('Appliances', instance.Appliances)
	# 	instance.Group = validated_data.get('Group', instance.Group)
	# 	instance.Updated = timezone.now()
	# 	instance.save()
	# 	return instance


class NodeslistSerializer(serializers.ModelSerializer):
	ID = serializers.IntegerField(min_value = 0)
	Type = serializers.CharField(max_length=3)
	Appliances = serializers.CharField(max_length=100)
	Group = serializers.CharField(max_length=4, allow_blank=True, allow_null=True)
	State = serializers.SerializerMethodField('node_state')
	CurrentState = serializers.SerializerMethodField('node_Amp')

	class Meta:
		model = Nodes
		fields = ('ID', 'Type', 'Appliances', 'Group','Added', 'State', 'CurrentState')

	def node_state(self, obj):
		return obj.states.last().State # 要回傳字串

	def node_Amp(self, obj):
		year = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).year
		month = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).month
		day = pytz.timezone("Asia/Taipei").localize(datetime.datetime.now(), is_dst=None).day
		try: 
			current = str(float(obj.current_states.filter(Added__year=year).filter(Added__month=month).filter(Added__day=day).last().State)*10)#轉換成毫安培mA單位 #只取今天有傳值的
		except:
			current = '0'
		return current 





# class NodesCommendSerializer(serializers.ModelSerializer):
# 	NodeID = serializers.IntegerField(min_value = 0)
# 	State = serializers.CharField(max_length=100)
# 	Added = serializers.DateTimeField()

# 	class Meta:
# 		model = NodeState
# 		fields = ('NodeID', 'State', 'Added')

# 	def create(self,validated_data):
# 		return NodeState.objects.create(**validated_data)


class IRcommendSerializer(serializers.ModelSerializer):
	class Meta:
		model = IRcommend
		fields = ('NodeID', 'Commend', 'RawCode')


class TaskslistSerializer(serializers.ModelSerializer):

	# NodeID 不能直接用他自動的會有問題
	# NodeID = serializers.IntegerField(min_value = 0)
	TaskID = serializers.SerializerMethodField('callTaskIid')
	NodeID = serializers.SerializerMethodField('callID')
	triggerTime = serializers.DateTimeField()
	Commend = serializers.CharField(max_length=100)
	completed = serializers.BooleanField()
	queued = serializers.BooleanField()
	
	class Meta:
		model = TaskSchedule
		fields = ('TaskID','NodeID', 'triggerTime', 'Commend', 'completed','queued')

	def callID(self, obj):
		return str(obj.NodeID.ID) # 要回傳字串	

	def callTaskIid(self, obj):
		return str(obj.id)

# class TasksSerializer(serializers.ModelSerializer):
	# NodeID = serializers.IntegerField(min_value = 0)
	# triggerTime = serializers.DateTimeField()
	# Commend = serializers.CharField(max_length=100)
	
	# class Meta:
	# 	model = TaskSchedule
	# 	fields = ('NodeID', 'triggerTime', 'Commend')



		