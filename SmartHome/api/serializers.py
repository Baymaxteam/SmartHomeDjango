# use for our data representations
# You can also use primary key and various other relationships, 
# but hyperlinking is good RESTful design.

#from django.contrib.auth.models import User, Group
from .models import House, Nodes, NodeState, CurrentState, IRcommend
from rest_framework import serializers
from django.utils import timezone

class HouseSerializer(serializers.ModelSerializer):
	GroupID = serializers.CharField(max_length=10)
	Name = serializers.CharField(max_length=10)
	
	class Meta:
		model = House
		fields = ('GroupID', 'Name') # fields 回傳group耗電量

	def create(self, validated_data):
		return House.objects.create(**validated_data)

	def update(self, instance, validated_data):
		instance.GroupID = validated_data.get('GroupID', instance.GroupID)
		instance.Name = validated_data.get('Name', instance.Name)
		instance.save()
		return instance

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
	Address = serializers.IntegerField(min_value = 0)
	Type = serializers.CharField(max_length=3)
	Group = serializers.CharField(max_length=4, allow_blank=True, allow_null=True)
	Added = serializers.DateTimeField(required=False, read_only=True) #timezone.now()
	Updated = serializers.DateTimeField(required=False)
	State = NodesStateSerializer(many=True, read_only=True)
	CurrentState = CurrentStateSerializer(many=True, read_only=True)

	class Meta:
		model = Nodes
		fields = ('ID', 'Address', 'Type', 'Appliances', 'Group','Added', 'Updated', 'State', 'CurrentState')



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
		return obj.current_states.last().State




class NodesCommendSerializer(serializers.ModelSerializer):
	State = serializers.CharField(max_length=100)
	Added = serializers.DateTimeField(read_only=True)
	class Meta:
		model = NodeState
		fields = ('State', 'Added')




class IRcommendSerializer(serializers.ModelSerializer):
	class Meta:
		model = IRcommend
		fields = ('NodeID', 'Commend', 'RawCode')



# ##
# class UserSerializer(serializers.HyperlinkedModelSerializer):
#     class Meta:
#         model = User
#         fields = ('url', 'username', 'email', 'groups')


# class SnippetSerializer(serializers.Serializer):
#     pk = serializers.IntegerField(read_only=True)
#     title = serializers.CharField(required=False, allow_blank=True, max_length=100)
#     code = serializers.CharField(style={'base_template': 'textarea.html'})
#     linenos = serializers.BooleanField(required=False)
#     language = serializers.ChoiceField(choices=LANGUAGE_CHOICES, default='python')
#     style = serializers.ChoiceField(choices=STYLE_CHOICES, default='friendly')

#     def create(self, validated_data):
#         """
#         Create and return a new `Snippet` instance, given the validated data.
#         """
#         return Snippet.objects.create(**validated_data)

#     def update(self, instance, validated_data):
#         """
#         Update and return an existing `Snippet` instance, given the validated data.
#         """
#         instance.title = validated_data.get('title', instance.title)
#         instance.code = validated_data.get('code', instance.code)
#         instance.linenos = validated_data.get('linenos', instance.linenos)
#         instance.language = validated_data.get('language', instance.language)
#         instance.style = validated_data.get('style', instance.style)
#         instance.save()
#         return instance