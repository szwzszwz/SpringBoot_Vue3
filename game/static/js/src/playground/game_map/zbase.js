class GameMap extends AcGameObject {	
	constructor(playground){
		super(); // 调用基类构造函数
		this.playground = playground;
		this.$canvas = $('<canvas></canvas>');
		this.ctx = this.$canvas[0].getContext('2d');
		this.ctx.canvas.width = this.playground.width;
		this.ctx.canvas.height = this.playground.height;
		this.playground.$playground.append(this.$canvas);
	}

	start() {
		
	}

	resize(){ // 重置尺寸
		this.ctx.canvas.width = this.playground.width;
		this.ctx.canvas.height = this.playground.height;
		this.ctx.fillStyle = "rgba(0, 0, 0, 1)";
		this.ctx.fillRect(0, 0, this.ctx.canvas.width, this.ctx.canvas.height);
	}

	update() {
		this.render();
	}

	render(){ // 渲染
		this.ctx.fillStyle = "rgba(0, 0, 0, 0.1)";
		this.ctx.fillRect(0, 0, this.ctx.canvas.width, this.ctx.canvas.height);
		
	}
}

