<template>
  <ContantBase>
    <div class="row g-2">
      <div>
        <div class="form-floating">
          <input type="email" class="form-control" v-model="college">
          <label>请输入要查找的部门或学院：</label>
        </div>
      </div>
      <button type="button" class="btn btn-primary" style="margin-left: 0;margin-top: 20px;"
        @click.prevent="refresh_teachers">提交</button>
      <button type="button" class="btn btn-outline-secondary" style="margin-left: 0;margin-top: 20px;"
        data-bs-toggle="modal" data-bs-target="#add-teacher-btn">新增</button>

      <!-- Modal -->
      <div class="modal fade" id="add-teacher-btn" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">信息</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="form-floating">
                <input type="email" class="form-control" v-model="numteacher">
                <label>教师编号：</label>
              </div>
              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="name">
                <label>教师姓名：</label>
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
                <input type="email" class="form-control" v-model="numcourse">
                <label>课程编号：</label>
              </div>
              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="course">
                <label>所教课程：</label>
              </div>
              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="college">
                <label>所处学院或部门：</label>
              </div>
              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="title">
                <label>职称：</label>
              </div>
              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="salary">
                <label>薪资：</label>
              </div>

            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary"
                @click.prevent="to_insert(numteacher, name, sex, age, numcourse, course, college, title, salary)">创建</button>
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
          <th scope="col" class="form">教师编号</th>
          <th scope="col" class="form">教师姓名</th>
          <th scope="col" class="form">性别</th>
          <th scope="col" class="form">年龄</th>
          <th scope="col" class="form">所教课程</th>
          <th scope="col" class="form">所处学院或部门</th>
          <th scope="col" class="form">职称</th>
          <th scope="col" class="form">薪资</th>
          <th scope="col" class="form">修改</th>
          <th scope="col" class="form">删除</th>
        </tr>
      </thead>
      <tbody>
        <tr class="first" v-for="user in users" :key="user.numteacher">
          <td style="text-align: center;line-height:45px;">{{ user.numteacher }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.name }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.sex }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.age }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.course }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.college }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.title }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.salary }}</td>
          <td v-if="aa == 1"><button type="button" class="btn btn-secondary b_left" data-bs-toggle="modal"
              :data-bs-target="'#update-teacher-info-modal-' + user.numteacher">修改</button>

            <!-- Modal -->
            <div class="modal fade" :id="'update-teacher-info-modal-' + user.numteacher" tabindex="-1"
              data-bs-backdrop="static" data-bs-keyboard="false" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">信息</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <div class="form-floating">
                      <input type="email" class="form-control" v-model="user.numteacher" readonly="readonly">
                      <label>教师编号：</label>
                    </div>

                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.name" readonly="readonly">
                      <label>教师姓名：</label>
                    </div>

                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.sex" readonly="readonly">
                      <label>性别：</label>
                    </div>

                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.age" readonly="readonly">
                      <label>年龄：</label>
                    </div>

                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.course">
                      <label>所教课程：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.college">
                      <label>所处学院或部门：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.title">
                      <label>职称：</label>
                    </div>
                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.salary">
                      <label>薪资：</label>
                    </div>

                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-primary"
                      @click.prevent="to_change(user.numteacher, user.course, user.college, user.title, user.salary)">提交</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                  </div>
                </div>
              </div>
            </div>

          </td>
          <td v-else><button type="button" class="btn btn-outline-secondary hidden"></button></td>
          <td v-if="aa == 1"><button type="button" class="btn btn-danger b_left"
              @click.prevent="to_delete(user.numteacher, user.name)">删除</button></td>
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
    let aa = ref('');
    const users = ref([
      {
        numteacher: '',
        name: '',
        sex: '',
        age: '',
        course: '',
        college: '',
        title: '',
        salary: '',
      },
    ])

    const refresh_teachers = () => {
      axios.get("http://localhost:80/teachercontroller/returnteacherinfo", {
        params: {
          'college': college.value
        }
      }).then((res) => {
        console.log(res);
        for (let i = 0; i < res.data.length; i++) {
          users.value = res.data
        }
        if (res.data.length > 0)
          aa.value = 1;
      })
    }

    const to_delete = (uid, uname) => {
      axios.get("http://localhost:80/admChangeTeacherInfoController/deleteInfoById", {
        params: {
          'id': uid,
          'name': uname,
        }
      }).then((res) => {
        console.log(res);
        if (res.data === "success") {
          refresh_teachers();
        }
      })
    }

    const to_change = (numteacher, course, college, title, salary) => {
      axios.get("http://localhost:80/admChangeTeacherInfoController/changeInfoById", {
        params: {
          'numteacher': numteacher,
          'course': course,
          'college': college, // 可以更改（老师）
          'title': title, // 可以更改
          'salary': salary // 可以更改
        }
      }).then((res) => {
        console.log(res)
        Modal.getInstance('#update-teacher-info-modal-' + numteacher).hide();
        refresh_teachers();
      })
    }

    const to_insert = (numteacher, name, sex, age, numcourse, course, college, title, salary) => {
      axios.get("http://localhost:80/admChangeTeacherInfoController/insertInfoById", {
        params: {
          'numteacher': numteacher,
          'name': name,
          'sex': sex,
          'age': age,
          'numcourse': numcourse,
          'course': course,
          'college': college,
          'title': title,
          'salary': salary,
        }
      }).then((res) => {
        console.log(res)
        Modal.getInstance("#add-teacher-btn").hide();
        refresh_teachers();
      })
    }

    return {
      refresh_teachers,
      college,
      users,
      aa,
      to_insert,
      to_delete,
      to_change
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
</style>