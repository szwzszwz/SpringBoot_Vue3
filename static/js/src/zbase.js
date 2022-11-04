export class AcGame {
    constructor(id) {
		this.id = id;
		this.$ac_game = $('#' + id); // id是ac_game_1234567
		this.menu = new AcGameMenu(this);
		this.playground = new AcGamePlayground(this);

		this.start();
	}

	start() {

	}

}
