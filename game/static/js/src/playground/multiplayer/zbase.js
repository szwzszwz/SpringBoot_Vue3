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
            } /*else if (event === "move_to") {
                outer.receive_move_to(uuid, data.tx, data.ty);
            } else if (event === "shoot_fireball") {
                outer.receive_shoot_fireball(uuid, data.tx, data.ty, data.ball_uuid);
            } else if (event === "attack") {
                outer.receive_attack(uuid, data.attackee_uuid, data.x, data.y, data.angle, data.damage, data.ball_uuid);
            } else if (event === "blink") {
                outer.receive_blink(uuid, data.tx, data.ty);
            } else if (event === "message") {
                outer.receive_message(uuid, data.username, data.text);
            }*/
		};
	}

	send_create_player(username,photo) {
        let outer = this;
        this.ws.send(JSON.stringify({ 
            'event': "create_player",
            'uuid': outer.uuid,
            'username': username,
            'photo': photo,
        }));
    }

    /*get_player(uuid) {
        let players = this.playground.players;
        for (let i = 0; i < players.length; i ++ ) {
            let player = players[i];
            if (player.uuid === uuid)
                return player;
        }

        return null;
    }*/

    receive_create_player(uuid, username, photo) {
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
}
