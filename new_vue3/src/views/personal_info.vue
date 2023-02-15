<template>
  <ContantBase class="size_view">
    <div class="container">
    <div class="row">
      <button type="button" class="btn btn-outline-primary col aa" @click.prevent="gotos">学生</button>
      <button type="button" class="btn btn-outline-primary col bb" @click.prevent="gotosToTeacher">教职工</button>
      <button type="button" class="btn btn-outline-primary col bb" @click.prevent="gotosToDepartment">部门</button>
    </div>
    </div>
  </ContantBase>
</template>

<script>
import ContantBase from '../components/ContantBase'
import router from "@/router";


export default {
  name: 'personal_info',
  components: {
    ContantBase,
  },

  setup(){
    const gotos = () =>{
        router.push('findstudentView');
    }

    const gotosToDepartment = () =>{
      router.push('finddepartmentView');
    }
    const gotosToTeacher = () =>{

      router.push('findteacherView');
    }
    return {
      gotos,
      gotosToTeacher,
      gotosToDepartment
    }
}

}
</script>

<style scope>
.size_view{
  margin-top:150px;
}
.aa{
  margin-left: 0px;
}
</style>