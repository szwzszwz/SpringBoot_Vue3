<!--网页中心的框-->
<template>
  <div class="home">
    <div class="container">
      <div class="card">
        <div class="card-body">
          <!--          slot表示可以渲染的内容-->
          <slot></slot>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: "ContantBase",
  components: {

  }
}
</script>

<style scope>
.card {
  margin-top: 20px;
}
</style>