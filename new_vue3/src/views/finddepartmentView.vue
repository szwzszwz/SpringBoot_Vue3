<template>
  <ContantBase>
    <div class="row g-2">
      <button type="button" class="btn btn-outline-secondary" style="margin-left: 0;margin-top: 20px;"
        data-bs-toggle="modal" data-bs-target="#add-department-btn">新增</button>

      <!-- Modal -->
      <div class="modal fade" id="add-department-btn" tabindex="-1" data-bs-backdrop="static" data-bs-keyboard="false"
        aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="staticBackdropLabel">信息</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
              <div class="form-floating">
                <input type="email" class="form-control" v-model="Dno">
                <label>部门编号：</label>
              </div>

              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="Dname">
                <label>部门名称：</label>
              </div>

              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="Dduty">
                <label>部门简介：</label>
              </div>

              <div class="form-floating" style="margin-top: 10px">
                <input type="email" class="form-control" v-model="Dhead">
                <label>部门负责人：</label>
              </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-primary"
                @click.prevent="to_insert(Dno, Dname, Dduty, Dhead)">创建</button>
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
          <th scope="col" class="form">部门编号</th>
          <th scope="col" class="form">部门名称</th>
          <th scope="col" class="form">部门简介</th>
          <th scope="col" class="form">部门负责人</th>
          <th scope="col" class="form">修改</th>
          <th scope="col" class="form">删除</th>
        </tr>
      </thead>
      <tbody>
        <tr class="first" v-for="user in users" :key="user.Dno">
          <td style="text-align: center;line-height:45px;">{{ user.Dno }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.Dname }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.Dduty }}</td>
          <td style="text-align: center;line-height:45px;">{{ user.Dhead }}</td>
          <td v-if="aa == 1" style="text-align: center;">
            <button type="button" class="btn btn-secondary b_left" data-bs-toggle="modal"
              :data-bs-target="'#update-department-info-modal-' + user.Dno">修改</button>

            <!-- Modal -->
            <div class="modal fade" :id="'update-department-info-modal-' + user.Dno" tabindex="-1"
              data-bs-backdrop="static" data-bs-keyboard="false" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h1 class="modal-title fs-5" id="staticBackdropLabel">信息</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <div class="form-floating">
                      <input type="email" class="form-control" v-model="user.Dno">
                      <label>部门编号：</label>
                    </div>

                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.Dname">
                      <label>部门名称：</label>
                    </div>

                    <div class="form-floating" style="margin-top: 10px">
                      <input type="email" class="form-control" v-model="user.Dhead">
                      <label>部门负责人：</label>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-primary"
                      @click.prevent="to_change(user.Dno, user.Dname, user.Dhead)">提交</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                  </div>
                </div>
              </div>
            </div>


          </td>
          <td v-else><button type="button" class="btn btn-outline-secondary hidden"></button></td>
          <td v-if="aa == 1" style="text-align: center;"><button type="button" class="btn btn-danger b_left"
              @click.prevent="to_delete(user.Dno, user.Dname)">删除</button></td>
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
  name: 'finddepartmentView',
  components: {
    ContantBase
  },

  setup() {
    let Dname = ref('');
    let aa = ref('');
    const users = ref([
      {
        Dno: '',
        Dname: '',
        Dduty: '',
        Dhead: '',
      },
    ])

    const refresh_departments = () => {
      axios.get("http://localhost:80/DepartmentInfoController/departmentInfo", {
      }).then((res) => {
        console.log(res);
        for (let i = 0; i < res.data.length; i++) {
          users.value = res.data
        }
        aa.value = 1;
      })
    }

    refresh_departments();

    const to_change = (uDno, uDname, uDhead) => {
      axios.get("http://localhost:80/OperationDepartmentController/changeInfoById", {
        params: {
          'Dno': uDno,
          'Dname': uDname,
          'Dhead': uDhead,
        }
      }).then((res) => {
        console.log(res)
        Modal.getInstance('#update-department-info-modal-' + uDno).hide();
        refresh_departments();
      })
    }

    const to_delete = (uDno, uDname) => {
      axios.get("http://localhost:80/OperationDepartmentController/deleteInfoById", {
        params: {
          'Dno': uDno,
          'Dname': uDname,
        }
      }).then((res) => {
        console.log(res)
        if (res.data === "success") {
          refresh_departments();
        }
      })
    }

    const to_insert = (Dno, Dname, Dduty, Dhead) => {
      axios.get("http://localhost:80/OperationDepartmentController/insertInfoById", {
        params: {
          'Dno': Dno,
          'Dname': Dname,
          'Dduty': Dduty,
          'Dhead': Dhead,
        }
      }).then((res) => {
        console.log(res)
        Modal.getInstance("#add-department-btn").hide();
        refresh_departments();
      })
    }

    return {
      refresh_departments,
      Dname,
      users,
      aa,
      to_change,
      to_delete,
      to_insert,
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