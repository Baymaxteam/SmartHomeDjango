from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser

from .models import House, Nodes, NodeState, CurrentState, IRcommend
from .serializers import HouseSerializer, NodesSerializer

class JSONResponse(HttpResponse):
	# """
	# An HttpResponse that renders its content into JSON.
	# """
	def __init__(self, data, **kwargs):
		content = JSONRenderer().render(data)
		kwargs['content_type'] = 'application/json'
		super(JSONResponse, self).__init__(content, **kwargs)



@csrf_exempt
def House_list(request):
	if request.method == 'GET':
		HouseSetting = House.objects.all()
		serializer = HouseSerializer(HouseSetting, many=True)
		return JSONResponse(serializer.data)

	elif request.method == 'POST':
		data = JSONParser().parse(request)
		ID = data['GroupID'] # 檢查ID是否有重複
		try:
			house = House.objects.get(GroupID = ID)
		except House.DoesNotExist:
			serializer = HouseSerializer(data=data)
			if serializer.is_valid():
				serializer.save()
				return JSONResponse(serializer.data, status=201)
			return JSONResponse(serializer.errors, status=400)
		return HttpResponse(status=204)

		
@csrf_exempt
def House_detail(request, GroupID): #pk = primaryKey
	try:
		house = House.objects.get(GroupID = GroupID)
	except House.DoesNotExist:
		return HttpResponse(status=404)

	if request.method == 'GET':
		serializer = HouseSerializer(house)
		return JSONResponse(serializer.data)

	elif request.method == 'PUT':
		data = JSONParser().parse(request)
		serializer = HouseSerializer(house, data=data)
		if serializer.is_valid():
			serializer.save()
			return JSONResponse(serializer.data)
		return JSONResponse(serializer.errors, status=400)

	elif request.method == 'DELETE':
		house.delete()
		return HttpResponse(status=204)


# class HouseViewSet(viewsets.ModelViewSet):
#     queryset = House.objects.all()
#     serializer_class = HouseSerializer


# class NodesViewSet(viewsets.ModelViewSet):
#     queryset = Nodesobjects.all()
#     serializer_class = NodesSerializer