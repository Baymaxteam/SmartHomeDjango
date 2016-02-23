
starttime = pytz.timezone("Asia/Taipei").localize(datetime.datetime(2016, 1, 1), is_dst=None)
addedtime = starttime
timenow = pytz.timezone("Asia/Taipei").localize(datetime.datetime(2016, 2, 22), is_dst=None)

NodeID = 8
watte = 210

while addedtime != timenow:
    if (addedtime.hour >= 17 and addedtime.hour <= 23) or (addedtime.hour >= 11 and addedtime.hour <= 14) or (addedtime.hour >= 7 and addedtime.hour <= 9):
        current = random.randint(int(watte/110*1000*0.8),int(watte/110*1000*1.2))
    else:
        current = random.randint(int(5/110*1000*0.7),int(5/110*1000*1.3))
    node_obj = Nodes.objects.get(ID = NodeID)
    CurrentState.objects.create(NodeID = node_obj, State = current, Added = addedtime)
    lastday = addedtime.day
    addedtime +=  datetime.timedelta(minutes = 1)
    if addedtime.day!=lastday:
        print(addedtime)