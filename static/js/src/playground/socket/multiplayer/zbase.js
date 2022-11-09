class MultiPlayerSocket {
    constructor(playground) {
		this.playground = playground;

		this.ws = new WebSocket("wss://app3866.acapp.acwing.com.cn/wss/multiplayer/"); // 建立连接

		this.start();
	}

	start(){
		this.receive();
	}

	receive() {
		let outer = this;
		this.ws.onmessage = function(e){ // 处理从前端接收wss信息的函数
			let data = JSON.parse(e.data) // 解析json
			let uuid = data.uuid;
			if (uuid === outer.uuid) return false; // 判断是不是自己发的消息
			
			let event = data.event;
            if (event === "create_player") {
                outer.receive_create_player(uuid, data.username, data.photo);
            } else if (event === "move_to") {
                outer.receive_move_to(uuid, data.tx, data.ty);
            } else if (event === "shoot_fireball") {
                outer.receive_shoot_fireball(uuid, data.tx, data.ty, data.ball_uuid);
            } else if (event === "attack") {
                outer.receive_attack(uuid, data.attackee_uuid, data.x, data.y, data.angle, data.damage, data.ball_uuid);
            } else if (event === "blink") {
                outer.receive_blink(uuid, data.tx, data.ty);
            } /*else if (event === "message") {
                outer.receive_message(uuid, data.username, data.text);
            }*/
		};
	}

	send_create_player(username,photo) { // 给别的窗口发送创建我的信息
        let outer = this;
        this.ws.send(JSON.stringify({ 
            'event': "create_player",
            'uuid': outer.uuid,
            'username': username,
            'photo': photo,
        }));
    }

    get_player(uuid) { //通过uuid找到player
        let players = this.playground.players;
        for (let i = 0; i < players.length; i ++ ) {
            let player = players[i];
            if (player.uuid === uuid)
                return player;
        }

        return null;
    }

    receive_create_player(uuid, username, photo) { // 接收创建别的玩家的信息
        let player = new Player(
            this.playground,
            this.playground.width / 2 / this.playground.scale,
            0.5,
            0.05,
            "white",
            0.15,
            "enemy",
            username,
            photo,
        );

        player.uuid = uuid; // 每个对象的uuid是创建者电脑上显示的uuid，所以要把别人电脑上我的uuid改成我电脑上我的uuid
        this.playground.players.push(player); // 将新创建的player加入players集合
    }

	 send_move_to(tx, ty) { // 发送我移动的位置
        let outer = this;
        this.ws.send(JSON.stringify({
            'event': "move_to",
            'uuid': outer.uuid,
            'tx': tx,
            'ty': ty,
        }));
    }

	receive_move_to(uuid, tx, ty) { // 接收别的玩家移动的位置信息
        let player = this.get_player(uuid);

        if (player) { // 如果该玩家没有掉线
            player.move_to(tx, ty);
        }
    }


	// 关于火球的接收和发送
	send_shoot_fireball(tx, ty, ball_uuid) {
        let outer = this;
        this.ws.send(JSON.stringify({
            'event': "shoot_fireball",
            'uuid': outer.uuid,
            'tx': tx,
            'ty': ty,
            'ball_uuid': ball_uuid,
        }));
    }

    receive_shoot_fireball(uuid, tx, ty, ball_uuid) {
        let player = this.get_player(uuid);
        if (player) {
            let fireball = player.shoot_fireball(tx, ty);
            fireball.uuid = ball_uuid;
        }
    }
	
	// 关于攻击信息的接收和发送
	send_attack(attackee_uuid, x, y, angle, damage, ball_uuid) { // 同步位置、角度、伤害、炮弹（打中人后消失）
        let outer = this;
        this.ws.send(JSON.stringify({
            'event': "attack",
            'uuid': outer.uuid,
            'attackee_uuid': attackee_uuid,
            'x': x,
            'y': y,
            'angle': angle,
            'damage': damage,
            'ball_uuid': ball_uuid,
        }));
    }

    receive_attack(uuid, attackee_uuid, x, y, angle, damage, ball_uuid) { // uuid攻击者的id，attackee_uuid被攻击者的id
        let attacker = this.get_player(uuid);
        let attackee = this.get_player(attackee_uuid);

        if (attacker && attackee) {
            attackee.receive_attack(x, y, angle, damage, ball_uuid, attacker);
        }
    }

	
	send_blink(tx, ty) {
        let outer = this;
        this.ws.send(JSON.stringify({
            'event': "blink",
            'uuid': outer.uuid,
            'tx': tx,
            'ty': ty,
        }));
    }
	
	receive_blink(uuid, tx, ty) {
        let player = this.get_player(uuid);
        if (player) {
            player.blink(tx, ty);
        }
    }

}
