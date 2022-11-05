export class AcGame {
    constructor(id, OS) {
		this.id = id;
		this.$ac_game = $('#' + id); // id是ac_game_1234567
		this.OS = OS;
		
		this.settings = new Settings(this);
		this.menu = new AcGameMenu(this);
		this.playground = new AcGamePlayground(this);
		
		this.start();
	}

	start() {

	}

}
