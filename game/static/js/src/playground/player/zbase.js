class Player extends AcGameObject {
	constructor(playground, x, y, radius, color, speed, is_me) { // 球的中心点坐标（x,y），半径(radius)，颜色(color)，移动速度（speed高度百分比），表示是不是自己（is_me）
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
		this.is_me = is_me;
		this.eps = 0.1; // 当误差<0.1就算0

		this.spent_time = 0;
		this.cur_skill = null;
	}

	start() {
		if(this.is_me){
			this.add_listening_events();
		}else {
			let tx = Math.random() * this.playground.width;
			let ty = Math.random() * this.playground.width;
			this.move_to(tx,ty);
		}
	
	}

	add_listening_events(){
		let outer = this;
		this.playground.game_map.$canvas.on("contextmenu", function() {
			return false;
		});


		this.playground.game_map.$canvas.mousedown(function(e) { // 对鼠标的监听
			if(e.which === 3){
				outer.move_to(e.clientX, e.clientY);
			} else if(e.which === 1){
            	if(outer.cur_skill === "fireball"){
                	outer.shoot_fireball(e.clientX,e.clientY);
                }
                outer.cur_skill = null;
            }
		});	

		$(window).keydown(function(e) { // 对键盘的监听
			if(e.which === 81){ // Q
				outer.cur_skill = "fireball";
				return false;
			}
		});
	}	

	shoot_fireball(tx, ty) {
		let x = this.x,y = this.y;
		let radius = this.playground.height * 0.01;
		let angle = Math.atan2(ty - this.y,tx - this.x);
		let vx = Math.cos(angle),vy = Math.sin(angle);
		let color = "orange";
		let speed = this.playground.height * 0.5;
		let move_length = this.playground.height * 1;
		
		new FireBall(this.playground,this,x,y,radius,vx,vy,color,speed,move_length,this.playground.height * 0.01);
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
		if(this.radius < 10){
			this.destroy();
			return false;
		}	
		
		this.damage_x = Math.cos(angle);
		this.damage_y = Math.sin(angle);
		this.damage_speed = damage * 100;
		this.speed *= 0.9; // 被攻击以后速度减慢
	}

	update() {
		this.spent_time += this.timedelta / 1000;
		if(Math.random() < 1 / 300.0 && this.spent_time > 4 && !this.is_me){
			let player = this.playground.players[Math.floor(Math.random() * this.playground.players.length)];
			let tx = player.x + player.speed * this.vx * this.timedelta / 1000 * 0.3;
			let ty = player.y + player.speed * this.vy * this.timedelta / 1000 * 0.3;
			this.shoot_fireball(tx,ty);
		}
		
		if(this.damage_speed > 10){
			this.vx = this.vy = 0;
			this.move_length = 0;
			this.x += this.damage_x * this.damage_speed * this.timedelta / 1000;
			this.y += this.damage_y * this.damage_speed * this.timedelta / 1000;
			this.damage_speed *= this.friction;
		} else {
			if(this.move_length < this.eps) {
				this.move_length = 0;
				this.vx = this.vy = 0;
				if(!this.is_me){
					let tx = Math.random() * this.playground.width;
            	  	let ty = Math.random() * this.playground.width;
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
		this.render();
	}

	render() {
		this.ctx.beginPath();
		this.ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false); // 画圆
		this.ctx.fillStyle = this.color;
		this.ctx.fill();
	}


	on_destroy() {
       // if (this.character === "me") {
           // if (this.playground.state === "fighting") {
              //  this.playground.state = "over";
            //    this.playground.score_board.lose();
          //  }
        //}

        for (let i = 0; i < this.playground.players.length; i ++ ) {
            if (this.playground.players[i] === this) {
                this.playground.players.splice(i, 1);
                break;
            }
        }
    }

}
