<template>
  <div class="dashboard-layout">
    <aside class="sidebar">
      <div class="logo">后台管理系统</div>
      <nav>
        <!-- to 属性改为动态拼接，保留当前用户名 -->
        <router-link :to="`/dashboard/${currentUser}/user`" active-class="active">👤 用户管理</router-link>
        <router-link :to="`/dashboard/${currentUser}/role`" active-class="active">🛡️ 角色管理</router-link>
        <router-link :to="`/dashboard/${currentUser}/dept`" active-class="active">🏢 部门管理</router-link>
        <router-link :to="`/dashboard/${currentUser}/notice`" active-class="active">📢 系统公告</router-link>
      </nav>
    </aside>

    <main class="main-content">
      <header class="top-bar">
        <div class="welcome">
          👋 欢迎回来，<strong>{{ currentUser }}</strong>
        </div>
        <button class="logout-btn" @click="logout">退出登录</button>
      </header>

      <div class="view-port">
        <router-view></router-view>
      </div>
    </main>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'

const router = useRouter()
const route = useRoute() // 获取当前路由信息对象

// 从路由参数 params 中获取 username
// 使用 computed 确保如果路由参数变化，视图也会更新
const currentUser = computed(() =>{ return route.params.username || '访客' })


const logout = () => {
  if (confirm('确定要退出系统吗？')) {
    // 退出时直接跳回登录页
    router.replace('/login')
  }
}
</script>

<style scoped>
/* 样式保持不变 */
.dashboard-layout { display: flex; height: 100vh; background: #f5f7fa; }
.sidebar { width: 220px; background: #2c3e50; color: white; flex-shrink: 0; }
.logo { height: 60px; line-height: 60px; text-align: center; font-size: 20px; font-weight: bold; border-bottom: 1px solid #34495e; }
.sidebar nav a { 
  display: block; padding: 15px 20px; color: #a4b0be; text-decoration: none; transition: 0.3s; 
}
.sidebar nav a:hover { color: white; background: #34495e; }
.sidebar nav a.active { background: #42b983; color: white; border-left: 4px solid #fff; }

.main-content { flex: 1; display: flex; flex-direction: column; overflow: hidden; }
.top-bar { 
  height: 60px; background: white; padding: 0 20px; 
  display: flex; justify-content: space-between; align-items: center;
  box-shadow: 0 2px 5px rgba(0,0,0,0.05);
}
.logout-btn { background: #ff6b6b; color: white; border: none; padding: 6px 15px; border-radius: 4px; cursor: pointer; }
.view-port { padding: 20px; flex: 1; overflow-y: auto; }
</style>