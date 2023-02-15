<template>
  <ContantBase>
    <div class="row g-2">
      <div class="col-4">
        <div class="form-floating">
          <input type="email" class="form-control" v-model="college">
          <label>请输入要查找的学院：</label>
        </div>
      </div>
      <div class="col-4">
        <div class="form-floating">
          <input type="email" class="form-control" v-model="Classroom">
          <label>请输入要查找的班级：</label>
        </div>
      </div>

      <button type="button" class="btn btn-primary col-3 num" @click.prevent="return_back">提交</button>
      <div class="error_message">{{ error_message }}</div>
      <button type="button" class="btn btn-outline-secondary" style="margin-left: 0;margin-top: 20px;"
        data-bs-toggle="modal" data-bs-target="#add-student-btn">新增</button>

      <!-- Modal -->
      <div class="modal fade" id="add-student-btn" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">信息</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="form-floating">
                <input type="email" class="form-control" v-model="id">
                <label>学生学号：</label>
              </div>

              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="name">
                <label>学生姓名：</label>
              </div>

              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="sex">
                <label>性别：</label>
              </div>

              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="age">
                <label>年龄：</label>
              </div>

              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="Classroom">
                <label>班级：</label>
              </div>
              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="college">
                <label>学院：</label>
              </div>
              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="time">
                <label>入学时间：</label>
              </div>
              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="hotel">
                <label>宿舍：</label>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary"
                @click.prevent="to_insert(id, name, sex, age, Classroom, college, time, hotel)">创建</button>
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
            </div>
          </div>
        </div>
      </div>
    </div>

  </ContantBase>
  <ContantBase>
    <table class="table table-striped size">
      <thead>
        <tr class="size_view bigger">
          <th scope="col" class="form">学生学号</th>
          <th scope="col" class="form">学生姓名</th>
          <th scope="col" class="form">性别</th>
          <th scope="col" class="form">年龄</th>
          <th scope="col" class="form">班级</th>
          <th scope="col" class="form">学院</th>
          <th scope="col" class="form">入学时间</th>
          <th scope="col" class="form">宿舍</th>
          <th scope="col" class="form">修改</th>
          <th scope="col" class="form">删除</th>
        </tr>
      </thead>
      <tbody>
        <tr class="first" v-for="user in users" :key="user.id" style="text-align: center;">
          <td>{{ user.id }}</td>
          <td>{{ user.name }}</td>
          <td>{{ user.sex }}</td>
          <td>{{ user.age }}</td>
          <td>{{ user.Classroom }}</td>
          <td>{{ user.college }}</td>
          <td>{{ user.time }}</td>
          <td>{{ user.hotel }}</td>
          <td v-if="display == 1">
            <button type="button" class="btn btn-secondary b_left" data-bs-toggle="modal"
              :data-bs-target="'#update-student-info-modal-' + user.id">修改</button>

            <!-- Modal -->
            <div class="modal fade" :id="'update-student-info-modal-' + user.id" tabindex="-1" data-bs-backdrop="static"
              data-bs-keyboard="false" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">信息</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <div class="form-floating">
                      <input type="text" class="form-control" v-model="user.id" readonly="readonly">
                      <label>学生学号：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="text" class="form-control" v-model="user.name" readonly="readonly">
                      <label>学生姓名：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="text" class="form-control" v-model="user.sex" readonly="readonly">
                      <label>性别：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="text" class="form-control" v-model="user.age">
                      <label>年龄：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="text" class="form-control" v-model="user.Classroom">
                      <label>班级：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="text" class="form-control" v-model="user.college">
                      <label>学院：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="text" class="form-control" v-model="user.time" readonly="readonly">
                      <label>入学时间：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="text" class="form-control" v-model="user.hotel">
                      <label>宿舍：</label>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-primary"
                      @click.prevent="to_change(user.id, user.name, user.age, user.Classroom, user.college, user.hotel)">提交</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                  </div>
                </div>
              </div>
            </div>

          </td>
          <td v-else><button type="button" class="btn btn-outline-secondary hidden"></button></td>
          <td v-if="display == 1"><button type="button" class="btn btn-danger b_left"
              @click.prevent="to_delete(user.id, user.name)">删除</button></td>
          <td v-else><button type="button" class="btn btn-outline-secondary hidden"></button></td>
        </tr>
      </tbody>
    </table>
  </ContantBase>
</template>

<script>
import axios from "axios";
import { ref } from "vue";
import ContantBase from "@/components/ContantBase";
import { Modal } from 'bootstrap/dist/js/bootstrap';

export default {
  name: 'findstudentView',
  components: {
    ContantBase
  },

  setup() {
    let college = ref('');
    let Classroom = ref('');
    let display = ref('');
    let error_message = ref('');
    const insert_user = ref([]);
    const users = ref([
      {
        id: '',
        name: '',
        sex: '',
        age: '',
        Classroom: '',
        college: '',
        time: '',
        hotel: '',
      }
    ])

    const return_back = () => {
      axios.get("http://localhost:80/studentcontroller/returnstudentinfo", {
        params: {
          'college': college.value,
          'Classroom': Classroom.value
        }
      }).then((res) => {
        console.log(res);
        if (res.data === "error") {
          console.log("error");
          error_message.value = "输入学院或班级有误";
        } else {
          error_message.value = "";
          for (let i = 0; i < res.data.length; i++) {
            users.value = res.data
          }
          display.value = 1;
        }
      })
    }
    const to_insert = (id, name, sex, age, Classroom, college, time, hotel) => {
      axios.get("http://localhost:80/admChangeUserInfoController/insertInfoById", {
        params: {
          'id': id,
          'name': name,
          'sex': sex,
          'age': age,
          'Classroom': Classroom,
          'college': college,
          'time': time,
          'hotel': hotel
        }
      }).then((res) => {
        console.log(res)
        Modal.getInstance("#add-student-btn").hide();
        refresh_students();
      })
    }

    const to_change = (uid, uname, uage, uClassroom, ucollege, uhotel) => {
      axios.get("http://localhost:80/admChangeUserInfoController/changeInfoById", {
        params: {
          'id': uid,
          'name': uname,
          'age': uage,
          'Classroom': uClassroom, // 可以更改
          'college': ucollege, // 可以更改（先改classroom）
          'hotel': uhotel // 可以更改
        }
      }).then((res) => {
        console.log(res);
        Modal.getInstance('#update-student-info-modal-' + uid).hide();
        refresh_students();
      })
    }

    const refresh_students = () => {
      axios.get("http://localhost:80/studentcontroller/returnstudentinfo", {
        params: {
          'college': college.value,
          'Classroom': Classroom.value
        }
      }).then((res) => {
        console.log(res);
        for (let i = 0; i < res.data.length; i++) {
          users.value = res.data
        }
        display.value = 1;
      })
    }

    const to_delete = (uid, uname) => {
      axios.get("http://localhost:80/admChangeUserInfoController/deleteInfoById", {
        params: {
          'id': uid,
          'name': uname,
        }
      }).then((res) => {
        console.log(res);
        if (res.data === "success") {
          refresh_students();
        }
      })
    }
    return {
      return_back,
      college,
      Classroom,
      users,
      display,
      to_insert,
      error_message,
      to_change,
      to_delete,
      insert_user
    }
  },
}
</script>

<style scope>
.size {
  font-size: 17px;
  margin-top: 15px;
}

.num {
  margin-top: 17px;
  margin-left: 58px;
}

.first {
  font-size: 20px;
}

.bigger {
  font-size: 30px;

}

.hidden {
  display: none;
  visibility: hidden;
}

.form {
  text-align: center;
}

.b_left {
  margin-left: 0px;
}

.error_message {
  color: red;
}
</style>