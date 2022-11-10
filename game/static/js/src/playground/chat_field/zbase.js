class ChatField {
	constructor(playground){
		this.playground = playground;

		this.$history = $(`<div class="ac-game-chat-field-history">历史记录</div>`);
		this.$input = $(`<input type="text" class="ac-game-chat-field-input">`);

		this.$history.hide();
		this.$input.hide();
		this.func_id = null;
		this.playground.$playground.append(this.$history);
		this.playground.$playground.append(this.$input);

		this.start();
	}

	start(){
		this.add_listening_events();
	}

	add_listening_events() {
        let outer = this;

        this.$input.keydown(function(e) { // 对键盘进行监听
            if (e.which === 27) {  // ESC
                outer.hide_input();
                return false;
            } else if (e.which === 13) {  // ENTER
                let username = outer.playground.root.settings.username;
                let text = outer.$input.val();
                if (text) {
                    outer.$input.val("");
                    outer.add_message(username, text);
                    outer.playground.mps.send_message(username, text);
                }
                return false;
            }
        });
    }

	render_message(message) { // 渲染函数（封装成html对象）
        return $(`<div>${message}</div>`);
    }

    add_message(username, text) {
        this.show_history();
        let message = `[${username}]${text}`;
        this.$history.append(this.render_message(message));
        this.$history.scrollTop(this.$history[0].scrollHeight); // 自动跟进滚动条
    }


	show_history() { // 
        let outer = this;
        this.$history.fadeIn(); // 慢慢渐变显示出来，shou是直接显示出来

        if (this.func_id) clearTimeout(this.func_id);

        this.func_id = setTimeout(function() {
            outer.$history.fadeOut();
            outer.func_id = null;
        }, 3000);  
    }


	show_input() {
		this.show_history();

		this.$input.show();
		this.$input.focus();
	}
	
	hide_input() {
		this.$input.hide();
		this.playground.game_map.$canvas.focus(); // 关闭聊天框后，重新聚焦canvas地图
	}
}
