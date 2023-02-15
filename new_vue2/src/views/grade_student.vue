<template>
  <ContantBase>
    <div class="second">班级信息</div>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
          aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
          <ul class="navbar-nav">
            <li class="nav-item">
              <a class="nav-link third" @click.prevent="classes(Class1)">{{ Class1 }}</a>
            </li>
            <li class="nav-item">
              <a class="nav-link third" @click.prevent="classes(Class2)">{{ Class2 }}</a>
            </li>
            <li class="nav-item">
              <a class="nav-link third" @click.prevent="classes(Class3)">{{ Class3 }}</a>
            </li>
            <li class="nav-item">
              <a class="nav-link third" @click.prevent="classes(Class4)">{{ Class4 }}</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <table class="table table-striped size">

      <thead>
        <tr class="size_view first">
          <th scope="col">学号</th>
          <th scope="col">姓名</th>
          <th scope="col">课程名</th>
          <th scope="col">成绩</th>
          <th scope="col">修改</th>
        </tr>
      </thead>
      <tbody>
        <tr class="first" v-for="user in users" :key="user.id">
          <td class="cen">{{ user.id }}</td>
          <td class="cen">{{ user.namestudent }}</td>
          <td class="cen">{{ user.namecourse }}</td>
          <td class="cen">{{ user.grade }}</td>
          <td v-if="aa == 1"><button type="button" class="btn btn-secondary" style="margin: 0"
              @click.prevent="to_change(user.id, user.namecourse, user.grade)">修改</button></td>
          <td v-else><button type="button" class="btn btn-outline-secondary hidden">修改</button></td>
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
import { useRouter } from "vue-router";

export default {
  name: 'grade_student',
  components: {
    ContantBase,
  },
  setup() {
    const router = useRouter();
    let button_change = ref('');
    let aa = ref('');
    let lists = [];
    let Class1 = ref('');
    let Class2 = ref('');
    let Class3 = ref('');
    let Class4 = ref('');
    let users = ref([
      {
        id: '',
        namestudent: '',
        namecourse: '',
        grade: ''
      }
    ])

    axios.get("http://localhost:80/teacherChangeGradeController/returnClass", {
      params: {
        numteacher: store.state.user.id
      }
    }).then((res) => {
      console.log(res);
      lists[0] = res.data[0].Class1;
      lists[1] = res.data[1].Class2;
      lists[2] = res.data[2].Class3;
      lists[3] = res.data[3].Class4;
      lists.sort();
      Class1.value = lists[0];
      Class2.value = lists[1];
      Class3.value = lists[2];
      Class4.value = lists[3];
    })

    const classes = (Class) => {
      axios.get("http://localhost:80/teacherChangeGradeController/returngrade", {
        params: {
          classroom: Class,
          numteacher: store.state.user.id
        }
      }).then((res) => {
        console.log(res)
        console.log(res.data)
        for (let i = 0; i < res.data.length; i++) {
          users.value = res.data
        }
        aa.value = 1
      })
    }

    const to_change = (uid, unamecourse, ugrade) => {
      router.push({
        path: 'changeView',
        query: {
          uid: uid,
          unamecourse: unamecourse,
          ugrade: ugrade
        }// 要传递的参数
      })
    }

    return {
      users,
      button_change,
      aa,
      classes,
      lists,
      Class1,
      Class2,
      Class3,
      Class4,
      to_change,
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

.second {
  text-align: center;
  font-size: 31px;
}

.third {
  margin-left: 90px;
  margin-right: 90px;
}

.hidden {
  display: none;
  visibility: hidden;
}

.cen {
  font-size: 25px;
}
</style>