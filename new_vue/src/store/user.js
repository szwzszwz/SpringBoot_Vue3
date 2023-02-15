export default {
    state: { // 存储数据
        id: "",
        name: "",
        classroom: "",
        is_login: false,
    },
    getters: { // 获取state中需要计算的内容
    },
    mutations: { // 对state直接修改操作
        updateId(state, id) {
            state.id = id;
        },
        updateName(state, name) {
            state.name = name;
        },
        updateClassroom(state, classroom) {
            state.classroom = classroom;
        },
        updateIslogin(state, is_login){
            state.is_login = is_login;
        }
    },
    actions: {
    },
    modules: { // 维护state对象，新创建文件
    }
}