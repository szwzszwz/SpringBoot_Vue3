<template>
  <div class="pos">
    <div class="container mt-3">
      <div class="toast show">
        <div class="toast-header">
          <strong class="me-auto size">信息</strong>
        </div>
        <div class="toast-body" v-if="$store.state.user.is_login">
          <!--正在登陆-->
          <p class="center_info size">是否确定退出？</p>
          <button type="button" class="btn btn-outline-primary" @click="login">取消</button>
          <button type="button" class="btn btn-outline-primary" @click="logout">确定</button>
        </div>
        <div class="toast-body" v-else>
          <p class="center_info size">是否确定退出？</p>
          <button type="button" class="btn btn-outline-primary" @click="return_login_view">取消</button>
          <button type="button" class="btn btn-outline-primary" @click="return_home_view">确定</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import router from "@/router";
import store from '@/store';

export default {
  name: 'exit_sys',
  components: {
  },

  setup() {
    const login = () => { // 不退出
      router.push({ name: 'personal_info' });
    }
    const logout = () => {      // 退出
      store.commit("updateIslogin", false);
      store.commit("updateId", '');
      store.commit("updateName", '');
      router.push({ name: 'LoginView' });
    }
    const return_login_view = () => {
      router.push({ name: 'LoginView' });
    }
    const return_home_view = () => {
      router.push({ name: 'home' });
    }
    return {
      login,
      logout,
      return_login_view,
      return_home_view,
    }
  }
}

</script>

<style scope>
.center_info {
  text-align: center;
}

button {
  width: 90px;
  height: 40px;
  margin-left: 45px;
}

.size {
  font-size: 17px;
}

.pos {
  position: absolute;
  left: 50%;
  top: 50%;
  margin-left: -180px;
  margin-top: -120px;
}
</style>