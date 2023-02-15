<template>
  <div class="pos">
    <div class="container">
      <div class="toast show">
        <div class="toast-header">
          <strong class="me-auto size">信息</strong>
        </div>
        <div class="toast-body">
          <p class="center_info size">学生学号：</p>
          <div class="row g-3 align-items-center">
            <div class="col-auto">
              <input class="form-control locat" aria-describedby="passwordHelpInline" v-model="id">
            </div>
          </div>
          <p class="center_info size">课程名：</p>
          <div class="row g-3 align-items-center">
            <div class="col-auto">
              <input class="form-control locat" aria-describedby="passwordHelpInline" v-model="namecourse">
            </div>
          </div>
          <p class="center_info size">学生新成绩：</p>
          <div class="row g-3 align-items-center">
            <div class="col-auto">
              <input class="form-control locat" aria-describedby="passwordHelpInline" v-model="grade">
            </div>
          </div>
          <button type="button" class="btn btn-outline-primary col" style="margin-top: 30px;margin-bottom: 13px;"
            @click.prevent="back">提交</button>
          <button type="button" class="btn btn-outline-primary col" style="margin-top: 30px;margin-bottom: 13px;"
            @click.prevent="return_back">取消</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import router from "@/router";
import { ref } from "vue";
import axios from "axios";
import { useRoute } from "vue-router";

export default {
  name: 'changeView',
  components: {
  },
  setup() {
    const route = useRoute();

    let id = ref('');
    let namecourse = ref('');
    let grade = ref('');
    id.value = route.query.uid;
    namecourse.value = route.query.unamecourse;
    grade.value = route.query.ugrade

    const back = () => {
      axios.get("http://localhost:80/teacherChangeGradeController/changevalue", {
        params: {
          'id': id.value,
          'namecourse': namecourse.value,
          'grade': grade.value
        }
      }).then((res) => {
        console.log(res)
        console.log(id.value)
      })
      router.push({ name: 'grade_student' });
    }
    const return_back = () => {
      router.push({ name: 'grade_student' })
    }
    return {
      back,
      grade,
      id,
      namecourse,
      return_back,
    }
  },
}
</script>
<style scope>
.size {
  font-size: 17px;
  margin-top: 6px;
}

.pos {
  position: absolute;
  left: 50%;
  top: 50%;
  margin-left: -220px;
  margin-top: -170px;
}

.locat {
  padding-left: 150px;
  padding-right: 100px;
}

.num {
  margin: 50px 0 0 0;
}
</style>