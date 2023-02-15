import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import personal_info from '../views/personal_info.vue'
import grade_student from '../views/grade_student.vue'
import LoginView from '../views/LoginView.vue'
import exit_sys from '../views/exit_sys'
import changeView from '../views/changeView'
import registerView from '../views/registerView'

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
    path: '/grade_student',
    name: 'grade_student',
    component: grade_student
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
    path: '/changeView',
    name: 'changeView',
    component: changeView
  },
  {
    path: '/registerView',
    name: 'registerView',
    component: registerView
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
