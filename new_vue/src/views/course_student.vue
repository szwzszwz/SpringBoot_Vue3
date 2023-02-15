<template>
  <ContantBase>
    <table class="table table-striped size">
      <thead>
        <tr class="size_view first">
          <th scope="col">课程号</th>
          <th scope="col">课程名</th>
          <th scope="col">授课老师</th>
          <th scope="col">学分</th>
          <!--        <th scope="col">操作</th>-->
        </tr>
      </thead>
      <tbody>
        <tr class="first" v-for="user in users" :key="user.num_course">
          <td>{{ user.num_course }}</td>
          <td>{{ user.name_course }}</td>
          <td>{{ user.name_teacher }}</td>
          <td>{{ user.credit }}</td>
        </tr>
      </tbody>
    </table>
  </ContantBase>
</template>

<script>
import ContantBase from '../components/ContantBase';
import { ref } from "vue";
import axios from "axios";
import store from '@/store';

export default {
  name: 'course_student',
  components: {
    ContantBase,
  },
  setup() {
    let credit = ref('');
    const users = ref([
      {
        num_course: '',
        name_course: '',
        name_teacher: '',
        credit: ''
      }
    ])
    axios.get("http://localhost:80/studentcourses/courseInfo", {
      params: {
        id: store.state.user.id,
        classroom: store.state.user.classroom
      }
    }).then((res) => {
      console.log(res)
      for (let i = 0; i < res.data.length; i++) {
        users.value = res.data
      }

    })

    //编辑
    // const edit=(data)=>{
    //   console.log(data,222)
    //   formData.value=data
    // }
    //
    // const formData=ref({
    //   num_course:'',
    //   name_course:'',
    //   name_teacher:'',
    //   credit:''
    // })

    //新增
    // const add=()=>{
    //   formData.value={
    //     num_course:'',
    //     name_course:'',
    //     name_teacher:'',
    //     credit:''
    //   }
    // }


    return {
      credit,
      users,
      // edit,
      // add
    }
  }
}
</script>

<style scope>
.size_view {
  font-size: 40px;
}

.size {
  font-size: 20px;
}

.first {
  text-align: center;
}
</style>