class Player extends AcGameObject {
	constructor(playground, x, y, radius, color, speed, character, username, photo) { // 球的中心点坐标（x,y），半径(radius)，颜色(color)，移动速度（speed高度百分比），表示是自己还是人机还是匹配的敌人（character）


		super();
		this.playground = playground;
		this.ctx = this.playground.game_map.ctx;
		this.x = x;
		this.y = y;
		this.vx = 1;
		this.vy = 1; // vx和vy联合起来表示方向
		this.damage_x = 0;
		this.damage_y = 0; // 碰撞后的方向
		this.damage_speed = 0; // 碰撞后的速度
		this.friction = 0.9; // 速度减少量（摩擦力）
		this.move_length = 0;
		this.radius = radius;
		this.color = color;
		this.speed = speed;
		this.character = character;
		this.username = username;
		this.photo = photo;
		this.eps = 0.01; // 当误差<0.1就算0

		this.spent_time = 0;

		this.fireballs = [];
		this.cur_skill = null;

		if(this.character !== "robot"){
			this.img = new Image();
			this.img.src = this.photo;
		}

		if(this.character === "me"){
			this.fireball_coldtime = 3; // 冷却时间，单位是秒
			this.fireball_img = new Image();
			this.fireball_img.src = "https://cdn.acwing.com/media/article/image/2021/12/02/1_9340c86053-fireball.png";

			this.blink_coldtime = 5;  // 单位：秒
            this.blink_img = new Image();
            this.blink_img.src = "https://cdn.acwing.com/media/article/image/2021/12/02/1_daccabdc53-blink.png";

		}
	}

	start() {
		this.playground.player_count++;
		this.playground.notice_board.write("已就绪: " + this.playground.player_count + "人");

		if(this.playground.player_count >= 3){
			this.playground.state = "fighting";
			this.playground.notice_board.write("Fighting");
		}

		if(this.character === "me"){
			this.add_listening_events();
		}else if (this.character === "robot"){
			let tx = Math.random() * this.playground.width / this.playground.scale;
			let ty = Math.random() * this.playground.width / this.playground.scale;
			this.move_to(tx,ty);
		}
	
	}

	add_listening_events(){
		let outer = this;
		this.playground.game_map.$canvas.on("contextmenu", function() {
			return true;
		});


		this.playground.game_map.$canvas.mousedown(function(e) { // 对鼠标的监听

			if(outer.playground.state !== "fighting"){
				return false;
			}
			const rect = outer.ctx.canvas.getBoundingClientRect();
			if(e.which === 3){
				let tx = (e.clientX - rect.left) / outer.playground.scale;
				let ty = (e.clientY - rect.top) / outer.playground.scale;
				outer.move_to(tx, ty);

				if(outer.playground.mode === "multi mode"){
					outer.playground.mps.send_move_to(tx,ty);
				}
			} else if(e.which === 1){

				let tx = (e.clientX - rect.left) / outer.playground.scale;
				let ty = (e.clientY - rect.top) / outer.playground.scale;
            	if(outer.cur_skill === "fireball"){
					if (outer.fireball_coldtime > outer.eps)
						return false;
                	let fireball = outer.shoot_fireball(tx, ty);
					if(outer.playground.mode === "multi mode"){
						outer.playground.mps.send_shoot_fireball(tx,ty,fireball.uuid);
					}
                } else if (outer.cur_skill === "blink") {
                    if (outer.blink_coldtime > outer.eps)
                        return false;

                    outer.blink(tx, ty);

                    if (outer.playground.mode === "multi mode") {
                        outer.playground.mps.send_blink(tx, ty);
                    }
                }

                outer.cur_skill = null;
            }
		});	

		$(window).keydown(function(e) { // 对键盘的监听
			if(outer.playground.state !== "fighting"){
				return true;
			}

			if (e.which === 81) {  // q
                if (outer.fireball_coldtime > outer.eps)
                    return true;

                outer.cur_skill = "fireball";
                return false;
            } else if (e.which === 70) {  // f
                if (outer.blink_coldtime > outer.eps)
                    return true;

                outer.cur_skill = "blink";
                return false;
            }
		});
	}	

	shoot_fireball(tx, ty) {
		let x = this.x,y = this.y;
		let radius = 0.01;
		let angle = Math.atan2(ty - this.y,tx - this.x);
		let vx = Math.cos(angle),vy = Math.sin(angle);
		let color = "orange";
		let speed = 0.5;
		let move_length = 1;
		
		let fireball = new FireBall(this.playground,this,x,y,radius,vx,vy,color,speed,move_length,0.01);
		this.fireballs.push(fireball);
		
		this.fireball_coldtime = 3; // 重置cd

		return fireball; // 为了能获取发射子弹的uuid，为了同步
	}

	destroy_fireball(uuid){
		for(let i = 0;i < this.fireballs.length;i++){
			let fireball = this.fireballs[i];
			if(fireball.uuid === uuid){
				fireball.destroy();
				break;
			}
		}
	}

	blink(tx, ty) {
        let d = this.get_dist(this.x, this.y, tx, ty);
        d = Math.min(d, 0.8);
        let angle = Math.atan2(ty - this.y, tx - this.x);
        this.x += d * Math.cos(angle);
        this.y += d * Math.sin(angle);

        this.blink_coldtime = 5;
        this.move_length = 0;  // 闪现完停下来
    }


	get_dist(x1, y1, x2, y2){
		let dx = x2 - x1;
		let dy = y2 - y1;
		return Math.sqrt(dx * dx + dy * dy);
	}

	move_to(tx, ty){
		this.move_length = this.get_dist(this.x, this.y, tx, ty);
		let angle = Math.atan2(ty - this.y,tx - this.x); // 用atan2函数求角度
		this.vx = Math.cos(angle);
		this.vy = Math.sin(angle);
	}

	is_attacked(angle,damage){
 		for(let i = 0;i < 20 + Math.random() * 10;i++){
        	let x = this.x,y = this.y;
            let radius = this.radius * Math.random() * 0.1;
            let angle = Math.PI * 2 * Math.random();
            let vx = Math.cos(angle);
            let vy = Math.sin(angle);
            let color = this.color;
            let speed = this.speed * 10;
            let move_length = this.radius * Math.random() * 5;
            new Particle(this.playground,x,y,radius,vx,vy,color,speed,move_length);
        }

		this.radius -= damage;
		if(this.radius < this.eps){
			this.destroy();
			return false;
		}	
		
		this.damage_x = Math.cos(angle);
		this.damage_y = Math.sin(angle);
		this.damage_speed = damage * 100;
		this.speed *= 0.9; // 被攻击以后速度减慢
	}

	receive_attack(x, y, angle, damage, ball_uuid, attacker){
		attacker.destroy_fireball(ball_uuid);
        this.x = x;
        this.y = y;
        this.is_attacked(angle, damage);
	}

	update() {
		this.spent_time += this.timedelta / 1000;
		if (this.character === "me" && this.playground.state === "fighting") { // 只有自己有冷却时间
			this.update_coldtime();
		}

		this.update_move();
		this.render();
	}

	update_coldtime(){
		this.fireball_coldtime -= this.timedelta / 1000;
		this.fireball_coletime = Math.max(this.fireball_coldtime, 0);

		this.blink_coldtime -= this.timedelta / 1000;
        this.blink_coldtime = Math.max(this.blink_coldtime, 0);
	}

	update_move() { // 只负责更新玩家移动
		if(Math.random() < 1 / 300.0 && this.spent_time > 4 && !this.character === "robot"){
			let player = this.playground.players[Math.floor(Math.random() * this.playground.players.length)];
			let tx = player.x + player.speed * this.vx * this.timedelta / 1000 * 0.3;
			let ty = player.y + player.speed * this.vy * this.timedelta / 1000 * 0.3;
			this.shoot_fireball(tx,ty);
		}
		if(this.damage_speed > this.eps){
			this.vx = this.vy = 0;
			this.move_length = 0;
			this.x += this.damage_x * this.damage_speed * this.timedelta / 1000;
			this.y += this.damage_y * this.damage_speed * this.timedelta / 1000;
			this.damage_speed *= this.friction;
		} else {
			if(this.move_length < this.eps) {
				this.move_length = 0;
				this.vx = this.vy = 0;
				if(!this.character === "robot"){
		        	let tx = Math.random() * this.playground.width / this.playground.scale;
                    let ty = Math.random() * this.playground.height / this.playground.scale;
		            this.move_to(tx,ty);
		        }
		   	} else {
		    	let moved = Math.min(this.move_length, this.speed * this.timedelta / 1000); // 单位是秒
		        // 每秒钟移动speed，两帧之间时间差timedelta，计算一帧移动多少，即每一帧真实的移动距离（取最小值是因为防止超出计算好的move_length的长度）
		        this.x += this.vx * moved; // 在该角度（vx和vy）下，对于x和y轴一帧分别的运动长度（x和y）
		       	this.y += this.vy * moved;
		 		this.move_length -= moved;
		    }
		} 
	}


	render() {
		let scale = this.playground.scale;
		if(this.character !== "robot"){ // 渲染图片
			this.ctx.save();
			this.ctx.beginPath();
			this.ctx.arc(this.x * scale, this.y * scale, this.radius * scale, 0, Math.PI * 2, false);
			this.ctx.stroke();
			this.ctx.clip();
			this.ctx.drawImage(this.img, (this.x - this.radius) * scale, (this.y - this.radius) * scale, this.radius * 2 * scale, this.radius * 2 * scale); 
			this.ctx.restore();
		} else {
			this.ctx.beginPath();
            this.ctx.arc(this.x * scale, this.y * scale, this.radius * scale, 0, Math.PI * 2, false); // 画圆
            this.ctx.fillStyle = this.color;
            this.ctx.fill();
		}
		if (this.character === "me" && this.playground.state === "fighting") {
            this.render_skill_coldtime();
        }
	}

	render_skill_coldtime() {
        let scale = this.playground.scale;
        let x = 1.5, y = 0.9, r = 0.04;

        this.ctx.save();
        this.ctx.beginPath();
        this.ctx.arc(x * scale, y * scale, r * scale, 0, Math.PI * 2, false);
        this.ctx.stroke();
        this.ctx.clip();
        this.ctx.drawImage(this.fireball_img, (x - r) * scale, (y - r) * scale, r * 2 * scale, r * 2 * scale);
        this.ctx.restore();

        if (this.fireball_coldtime > 0) {
            this.ctx.beginPath();
            this.ctx.moveTo(x * scale, y * scale);
            this.ctx.arc(x * scale, y * scale, r * scale, 0 - Math.PI / 2, Math.PI * 2 * (1 - this.fireball_coldtime / 3) - Math.PI / 2, true);
            this.ctx.lineTo(x * scale, y * scale);
            this.ctx.fillStyle = "rgba(0, 0, 255, 0.6)";
            this.ctx.fill();
        }

        x = 1.62, y = 0.9, r = 0.04;
        this.ctx.save();
        this.ctx.beginPath();
        this.ctx.arc(x * scale, y * scale, r * scale, 0, Math.PI * 2, false);
        this.ctx.stroke();
        this.ctx.clip();
        this.ctx.drawImage(this.blink_img, (x - r) * scale, (y - r) * scale, r * 2 * scale, r * 2 * scale);
        this.ctx.restore();

        if (this.blink_coldtime > 0) {
            this.ctx.beginPath();
            this.ctx.moveTo(x * scale, y * scale);
            this.ctx.arc(x * scale, y * scale, r * scale, 0 - Math.PI / 2, Math.PI * 2 * (1 - this.blink_coldtime / 5) - Math.PI / 2, true);
            this.ctx.lineTo(x * scale, y * scale);
            this.ctx.fillStyle = "rgba(0, 0, 255, 0.6)";
            this.ctx.fill();
        }

    }

	on_destroy() {
    	if (this.character === "me") {
        	if (this.playground.state === "fighting") {
            	this.playground.state = "over";
            	//this.playground.score_board.lose();
        	}
        }

        for (let i = 0; i < this.playground.players.length; i ++ ) {
            if (this.playground.players[i] === this) {
                this.playground.players.splice(i, 1);
                break;
            }
        }
    }

}
