class AcGamePlayground {
    constructor(root) {
        this.root = root;
        this.$playground = $(`<div class="ac-game-playground"></div>`);

       	this.hide();
		this.root.$ac_game.append(this.$playground);
        this.start();
    }

    get_random_color() {
        let colors = ["blue", "red", "pink", "grey", "green"];
        return colors[Math.floor(Math.random() * 5)];
    }


	start() {
		let outer = this;
		$(window).resize(function() {
			outer.resize();
		});
	}

	resize() { // 调整不同的窗口比例
		this.width = this.$playground.width();
		this.height = this.$playground.height();
		let unit = Math.min(this.height / 9,this.width / 16);
		
		this.width = unit * 16;
		this.height = unit * 9;
		this.scale = this.height; // 相对位置的单位1

		if(this.game_map) this.game_map.resize();
	}


	show() { // 显示playground界面
    	this.$playground.show();

		this.resize();

		this.width = this.$playground.width();
		this.height = this.$playground.height();
		this.game_map = new GameMap(this);
		this.players = [];
		this.players.push(new Player(this, this.width / 2 / this.scale, 0.5, 0.05, "white", 0.15, true));
		for(let i = 0;i < 5;i++){ // 敌人
			this.players.push(new Player(this, this.width / 2 / this.scale, 0.5, 0.05, this.get_random_color(), 0.15, false));
		}
 }
    hide() { // 关闭playground界面
        this.$playground.hide();
    }
}
