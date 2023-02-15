import { createStore } from 'vuex'
import ModuleUser from './user.js';

  export default createStore({
  state: { // 存储数据
  },
  getters: { // 获取state中需要计算的内容
  },
  mutations: { // 对state直接修改操作
  },
  actions: { // 对state的各种操作（更新方式）
  },
  modules: { // 维护state对象，
    user: ModuleUser,
  }
});
