# use for our data representations
# You can also use primary key and various other relationships, 
# but hyperlinking is good RESTful design.

#from django.contrib.auth.models import User, Group
from .models import House, Nodes, NodeState, CurrentState, IRcommend
from rest_framework import serializers

class HouseSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = House
        fields = ('GroupID', 'Name')


class NodesSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Nodes
		fields = ('ID', 'Address', 'Type', 'Appliances', 'Group','Added', 'Updated')


class NodeStateSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = NodeState
		fields = ('NodeID', 'State', 'Added')


class CurrentStateSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = CurrentState
		fields = ('NodeID', 'State', 'Added')


class IRcommendSerializer(serializers.HyperlinkedModelSerializer):
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