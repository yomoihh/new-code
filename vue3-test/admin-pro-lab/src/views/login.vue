<template>
  <div class="login-container">
    <div class="login-card">
      <h2>🚀 后台管理系统</h2>
      <p class="subtitle">Vue Router 4 实战演练</p>
      
      <div class="form-item">
        <label>用户名</label>
        <input type="text" v-model="username" placeholder="请输入任意用户名..." />
      </div>
      
      <div class="form-item">
        <label>密码</label>
        <input type="password" v-model="password" placeholder="任意密码..." />
      </div>

      <button @click="handleLogin" :disabled="!username">立即登录</button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
// 引入状态
import { useUserStore } from '@/stores/user'

const username = ref('')
const password = ref('')
const router = useRouter()
const userStore = useUserStore()

const handleLogin = () => {
  if (!username.value.trim()) return alert('请输入用户名')
  
  // ✅ 把登录用户名存入全局状态
  userStore.setUser(username.value)

  router.replace({ name: 'Dashboard' })
}
</script>

<style scoped>
.login-container {
  height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  justify-content: center;
  align-items: center;
}
.login-card {
  background: white;
  padding: 40px;
  border-radius: 12px;
  width: 350px;
  box-shadow: 0 10px 25px rgba(0,0,0,0.2);
  text-align: center;
}
.subtitle { color: #888; margin-bottom: 20px; font-size: 0.9em; }
.form-item { margin-bottom: 15px; text-align: left; }
.form-item label { display: block; margin-bottom: 5px; font-weight: bold; color: #555; }
input { 
  width: 100%; padding: 10px; border: 1px solid #ddd; 
  border-radius: 6px; box-sizing: border-box; 
}
button {
  width: 100%; padding: 12px; background: #667eea; color: white;
  border: none; border-radius: 6px; cursor: pointer; font-size: 16px; margin-top: 10px;
}
button:disabled { background: #ccc; cursor: not-allowed; }
</style>