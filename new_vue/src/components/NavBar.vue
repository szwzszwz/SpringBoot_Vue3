<template>
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand fs-1">学生</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText"
        aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarText">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0" v-if="$store.state.user.is_login">
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'personal_info' }">个人信息</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'course_student' }">课程</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'grade_student' }">成绩</router-link>
          </li>
        </ul>

        <ul class="navbar-nav me-auto mb-2 mb-lg-0" v-else>
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'LoginView' }">个人信息</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'LoginView' }">课程</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'LoginView' }">成绩</router-link>
          </li>
        </ul>

        <ul class="navbar-nav" v-if="!$store.state.user.is_login">
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'LoginView' }">登录</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'exit_sys' }">退出</router-link>
          </li>
        </ul>
        <ul class="navbar-nav" v-else>
          <li class="nav-item">
            <router-link class="nav-link size2" :to="{ name: 'personal_info' }">{{
              $store.state.user.name
            }}</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link size2" style="cursor: pointer" :to="{ name: 'exit_sys' }">退出</router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: "NavBar",
}


</script>


<style scope>
.size2 {
  margin-top: 23px;
  font-size: 25px;
}
</style>