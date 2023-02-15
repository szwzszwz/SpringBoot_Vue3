import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import personal_info from '../views/personal_info.vue'
import LoginView from '../views/LoginView.vue'
import exit_sys from '../views/exit_sys'
import findstudentView from '../views/findstudentView'
import findteacherView from '../views/findteacherView'
import finddepartmentView from '../views/finddepartmentView'

// 配置路由
const routes = [
  {
    path: '/',
    name: 'home',
    component: HomeView
  },
  {
    path: '/personal_info',
    name: 'personal_info',
    component: personal_info
  },
  {
    path: '/LoginView',
    name: 'LoginView',
    component: LoginView
  },
  {
    path: '/exit_sys',
    name: 'exit_sys',
    component: exit_sys
  },
  {
    path: '/findstudentView',
    name: 'findstudentView',
    component: findstudentView
  },
  {
    path: '/findteacherView',
    name: 'findteacherView',
    component: findteacherView
  },
  {
    path: '/finddepartmentView',
    name: 'finddepartmentView',
    component: finddepartmentView
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
