class FireBall extends AcGameObject {
	constructor(playground, player, x, y,radius, vx ,vy, color, speed, move_length, damage){ // damage火球的伤害
		super();
		this.playground = playground;
		this.player =  player;
        this.ctx = this.playground.game_map.ctx;
        this.x = x;
        this.y = y;
        this.vx = vx;
        this.vy = vy; // vx和vy联合起来表示方向
        this.radius = radius;
        this.color = color;
        this.speed = speed;
		this.move_length = move_length;
		this.damage = damage;
		this.eps = 0.01;
	}

	start(){
	}

	update() {
		if(this.move_length < this.eps){
			this.destroy();
			return false;
		}
		this.update_move();

		if(this.player.character !== "enemy"){ // 只有自己判断是否攻击到，别人窗口内不进行判断
			this.update_attack();
		}
		this.render();
	}

	update_move(){
		let moved = Math.min(this.move_length,this.speed * this.timedelta / 1000);
		this.x += this.vx * moved;
		this.y += this.vy * moved;
		this.move_length -= moved;
	}


	update_attack(){
		for(let i = 0;i < this.playground.players.length;i++){
			let player = this.playground.players[i];
			if(this.player !== player && this.is_collision(player)){
				this.attack(player);
			}
		}
	}

	get_dist(x1, y1, x2, y2){
    	let dx = x2 - x1;
        let dy = y2 - y1;
        return Math.sqrt(dx * dx + dy * dy);
    }
		
	attack(player){ // 攻击
		let angle = Math.atan2(player.y - this.y,player.x - this.x);
		player.is_attacked(angle,this.damage);

		if (this.playground.mode === "multi mode") { // 如果是多人模式那么广播一下信息
			this.playground.mps.send_attack(player.uuid, player.x, player.y, angle, this.damage, this.uuid);
		}

		this.destroy();
	}

	is_collision(player){ // 判断是否碰撞
		let distance = this.get_dist(this.x,this.y,player.x,player.y);
		if(distance < this.radius + player.radius){
			return true;
		}
		return false;
	}

	render() {
		this.ctx.beginPath();
		this.ctx.arc(this.x * this.playground.scale, this.y * this.playground.scale, this.radius * this.playground.scale, 0, Math.PI * 2, false);
		this.ctx.fillStyle = this.color;
		this.ctx.fill();
	}

	on_destroy(){ // 删除火球
		let fireballs = this.player.fireballs;
		for(let i = 0;i < fireballs.length;i++){
			if(fireballs[i] === this){
				fireballs.splice(i,1);
				break;
			}
		}
	}
}
