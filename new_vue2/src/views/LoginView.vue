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
          <button type="submit" class="btn btn-primary" style="margin-left: 0px;" @click.prevent="login">登录</button>
          <button type="submit" class="btn btn-primary" style="margin-left: 0px;margin-top: 10px;"
            @click.prevent="register">注册</button>
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
      axios.get("http://localhost:80/userTeacherLogin/come", { params: { username: username.value, password: password.value } }).then((res) => {
        console.log(res)
        // 接口调用成功回调
        if (res.data == "yes") {
          store.commit("updateId", username.value);
          store.commit("updateIslogin", true);
          router.push({ name: 'personal_info' })
        }
        if (res.data == "no")
          error_message.value = "输入密码或账号错误";
      })
    }

    const register = () => {
      router.push({ name: 'registerView' })
    }
    return {
      username,
      password,
      error_message,
      login,
      userData,
      register,
    }
  },

  // data(){
  //   return{
  //     data:{
  //       username: "123",
  //       password: "123",
  //     }
  //   }
  // },
  // methods:{
  //   async fetch(){
  //     const { data: resp } = await this.$http.post('localhost:80/u1/t1/' + this.param1 + '/' + this.param2);
  //     if(resp == 400) return this.$message.error(resp.msg);
  //   },
  // },
}

  // new Vue({
  //   el: '#set_user',
  //   data: {
  //     username: '',
  //     password: ''
  //   },
  //   methods: {
  //     set_user(){
  //       admin
  //         .post('localhost:80/u1/t1',{
  //           username: this.username,
  //           password: this.password,
  //         }).then(response =>{
  //           alert("success");
  //       }).catch();
  //       loadTable(num) {
  //         this.pageNum = num;
  //         $.get("/user/page?pageNum=" + this.pageNum + "&pageSize=" + this.pageSize + "&name=" + this.name).then(res => {
  //           this.page = res.data;
  //         });
  //       },
  //     }
  //   }
  // })
</script>

<style scope>
button {
  width: 100%
}

.error_message {
  color: red;
}
</style>