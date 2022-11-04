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
		this.eps = 0.1;
	}

	start(){
		let start
	}

	update() {
		if(this.move_length < this.eps){
			this.destroy();
			return false;
		}

		let moved = Math.min(this.move_length,this.speed * this.timedelta / 1000);
		this.x += this.vx * moved;
		this.y += this.vy * moved;
		this.move_length -= moved;

		for(let i = 0;i < this.playground.players.length;i++){
			let player = this.playground.players[i];
			if(this.player !== player && this.is_collision(player)){
				this.attack(player);
			}
		}

		this.render();
	}

	get_dist(x1, y1, x2, y2){
    	let dx = x2 - x1;
        let dy = y2 - y1;
        return Math.sqrt(dx * dx + dy * dy);
    }
		
	attack(player){ // 攻击
		let angle = Math.atan2(player.y - this.y,player.x - this.x);
		player.is_attacked(angle,this.damage);
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
		this.ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2, false);
		this.ctx.fillStyle = this.color;
		this.ctx.fill();
	}
}