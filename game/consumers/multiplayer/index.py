from channels.generic.websocket import AsyncWebsocketConsumer
import json
from django.conf import settings
from django.core.cache import cache # redis存储对战信息

class MultiPlayer(AsyncWebsocketConsumer):
	async def connect(self):
		self.room_name = None
		for i in range(1000): # 枚举1000个房间
			name = "room-%d" % (i)
			if not cache.has_key(name) or len(cache.get(name)) < settings.ROOM_CAPACITY:
				self.room_name = name
				break
	
		if not self.room_name: # 如果没有空房间,不建立连接
			return 

		await self.accept()

		if not cache.has_key(self.room_name): # 如果有空房间且没有该房间
			cache.set(self.room_name, [], 3600) # 有效期为1h
			
		for player in cache.get(self.room_name): # 服务器向本地发送当前已有的玩家信息
			await self.send(text_data=json.dumps({
				'event': "create_player",
				'uuid': player['uuid'],
				'username':player['username'],
				'photo': player['photo'],
			}))	

		await self.channel_layer.group_add(self.room_name, self.channel_name)

	async def disconnect(self, close_code):
		print('disconnect')
		await self.channel_layer.group_discard(self.room_name, self.channel_name)


	async def create_player(self, data):
		players = cache.get(self.room_name)
		players.append({
			'uuid': data['uuid'],
			'username': data['username'],
			'photo': data['photo'],
		})
		cache.set(self.room_name,players,3600) # 当最后一名玩家创建完成以后，房间存储一个小时
		await self.channel_layer.group_send( # 群发信息(包括自己)
			self.room_name,
			{
				'type': "group_create_player", # 接收函数的名字
				'event': "create_player",
				'uuid': data['uuid'],
				'username': data['username'],
				'photo':data['photo'],
			}
		)
        

	async def group_create_player(self,data):
		await self.send(text_data=json.dumps(data)) # 将data发送给前端

	async def receive(self, text_data):
		data = json.loads(text_data)
		event = data['event']

		if event == "create_player":
			await self.create_player(data)
        
