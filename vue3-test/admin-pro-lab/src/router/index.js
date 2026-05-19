import { createRouter, createWebHistory } from 'vue-router'

// 静态引入组件
import Login from '@/views/Login.vue'
import Dashboard from '@/views/Dashboard.vue'
import UserManage from '@/views/UserManage.vue'
import RoleManage from '@/views/RoleManage.vue'
import DeptManage from '@/views/DeptManage.vue'
import NoticeManage from '@/views/NoticeManage.vue'

const router = createRouter({
  history: createWebHistory(),
  routes: [
    { path: '/', redirect: '/login' },
    { path: '/login', name: 'Login', component: Login },
    { 
      // 1. 增加动态参数 :username
      path: '/dashboard/:username', 
      name: 'Dashboard', 
      component: Dashboard,
      // 2. 动态重定向：确保进入 Dashboard 时自动跳转到该用户的 User 页面
      redirect: to => {
        return { path: `/dashboard/${to.params.username}/user` }
      },
      children: [
        { path: 'user', component: UserManage },
        { path: 'role', component: RoleManage },
        { path: 'dept', component: DeptManage },
        { path: 'notice', component: NoticeManage }
      ]
    }
  ]
})

export default router