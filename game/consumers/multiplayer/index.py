from channels.generic.websocket import AsyncWebsocketConsumer
import json
from django.conf import settings
from django.core.cache import cache # redis存储对战信息

class MultiPlayer(AsyncWebsocketConsumer):
	async def connect(self):
		await self.accept()


	async def disconnect(self, close_code):
		print('disconnect')
		await self.channel_layer.group_discard(self.room_name, self.channel_name)


	async def create_player(self, data):
		self.room_name = None

		start = 0
		for i in range(start,1000000000): # 枚举1000个房间
			name = "room-%d" % (i)
			if not cache.has_key(name) or len(cache.get(name)) < settings.ROOM_CAPACITY:
				self.room_name = name
				break

		if not self.room_name: # 如果没有空房间,不建立连接
			return

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
				'type': "group_send_event", # 接收函数的名字
				'event': "create_player",
				'uuid': data['uuid'],
				'username': data['username'],
				'photo':data['photo'],
			}
		)

	async def group_send_event(self,data):
		await self.send(text_data=json.dumps(data)) # 将data发送给前端


	async def move_to(self, data):
		await self.channel_layer.group_send(
			self.room_name,
			{
				'type': "group_send_event",
				'event': "move_to",
				'uuid': data['uuid'],
				'tx': data['tx'],
				'ty': data['ty'],
			}
		)

	async def shoot_fireball(self, data):
		await self.channel_layer.group_send(
		self.room_name,
		{
			'type': "group_send_event",
			'event': "shoot_fireball",
			'uuid': data['uuid'],
			'tx': data['tx'],
			'ty': data['ty'],
			'ball_uuid': data['ball_uuid'],
		}
	)

	async def attack(self, data):
		'''if not self.room_name:
			return
		players = cache.get(self.room_name)

		if not players:
			return
		for player in players:
			if player['uuid'] == data['attackee_uuid']:
				player['hp'] -= 25

		remain_cnt = 0
		for player in players:
			if player['hp'] > 0:
				remain_cnt += 1

		if remain_cnt > 1:
			if self.room_name:
				cache.set(self.room_name, players, 3600)
		else:
			def db_update_player_score(username, score):
				player = Player.objects.get(user__username=username)
				player.score += score
				player.save()
			for player in players:
				if player['hp'] <= 0:
					await database_sync_to_async(db_update_player_score)(player['username'], -5)
				else:
					await database_sync_to_async(db_update_player_score)(player['username'], 10)'''

		await self.channel_layer.group_send(
			self.room_name,
			{
				'type': "group_send_event",
				'event': "attack",
				'uuid': data['uuid'],
				'attackee_uuid': data['attackee_uuid'],
				'x': data['x'],
				'y': data['y'],
				'angle': data['angle'],
				'damage': data['damage'],
				'ball_uuid': data['ball_uuid'],
			}
		)

	async def blink(self, data):
		await self.channel_layer.group_send(
			self.room_name,
			{
				'type': "group_send_event",
				'event': "blink",
				'uuid': data['uuid'],
				'tx': data['tx'],
				'ty': data['ty'],
			}
		)

	async def receive(self, text_data):
		data = json.loads(text_data)
		event = data['event']

		if event == "create_player":
			await self.create_player(data)
		elif event == "move_to":
			await self.move_to(data)
		elif event == "shoot_fireball":
			await self.shoot_fireball(data)
		elif event == "attack":
			await self.attack(data)
		elif event == "blink":
			await self.blink(data)
		'''elif event == "message":
			await self.message(data)'''

