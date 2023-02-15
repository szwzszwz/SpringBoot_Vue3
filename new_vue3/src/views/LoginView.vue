<template>
  <ContantBase>
    <div class="row justify-content-md-center">
      <div class="col-3">
        <form @submit.prevent="login">
          <div class="mb-3">
            <label for="username" class="form-label">用户名</label>
            <input v-model="username" type="username" class="form-control" id="username">
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">密码</label>
            <input v-model="password" type="password" class="form-control" id="password">
          </div>
          <div class="error_message">{{ error_message }}</div>
          <button type="submit" class="btn btn-primary" style="margin-left: 34%;" @click.prevent="login">登录</button>
        </form>
      </div>
    </div>

  </ContantBase>
</template>

<script>
import ContantBase from '../components/ContantBase';
import { ref } from 'vue';
import axios from "axios";
import router from "@/router";
import store from '@/store';

export default {
  name: 'LoginView',
  components: {
    ContantBase,
  },

  setup() {
    let username = ref('');
    let password = ref('');
    let error_message = ref('');
    let userData = ref({})
    const login = () => {
      axios.get("http://localhost:80/admLogin/login", {
        params: {
          username: username.value,
          password: password.value
        }
      }).then((res) => {
        console.log(res)
        if (res.data == "yes") {
          store.commit("updateId", username.value);
          store.commit("updateIslogin", true);
          router.push({ name: 'personal_info' })
        }
        if (res.data == "no")
          error_message.value = "输入密码或账号错误";
      })
    }
    return {
      username,
      password,
      error_message,
      login,
      userData
    }
  }
}

</script>

<style scope>
button {
  width: 100%
}

.error_message {
  color: red;
}
</style>