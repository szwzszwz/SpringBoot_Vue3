<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand size1" href="#">管理员</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText"
        aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <ul class="navbar-nav" v-if="!$store.state.user.is_login">
        <li class="nav-item">
          <router-link class="nav-link size3" :to="{ name: 'LoginView' }">登录</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link size2" :to="{ name: 'exit_sys' }">退出</router-link>
        </li>
      </ul>
      <ul class="navbar-nav" v-else>
        <li class="nav-item">
          <router-link class="nav-link size3" :to="{ name: 'personal_info' }">{{
            $store.state.user.id
          }}</router-link>
        </li>
        <li class="nav-item">
          <router-link class="nav-link size2" style="cursor: pointer" :to="{ name: 'exit_sys' }">退出</router-link>
        </li>
      </ul>
    </div>
  </nav>
</template>

<script>
export default {
  name: "NavBar",
}


</script>


<style scope>
.size1 {
  font-size: 55px;
}

.size3 {
  margin-top: 23px;
  font-size: 28px;

  /*margin-left: 570px;*/
}

.size2 {
  margin-top: 23px;
  font-size: 28px;
}
</style>