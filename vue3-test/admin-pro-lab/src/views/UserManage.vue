<template>
  <div class="page-card">
    <div class="page-header">
      <h3>👤 用户列表</h3>
      <span class="badge">共 {{ users.length }} 人</span>
    </div>
    <table class="data-table">
      <thead>
        <tr><th>ID</th><th>姓名</th><th>所属部门</th><th>担任角色</th><th>状态</th></tr>
      </thead>
      <tbody>
        <tr v-for="u in users" :key="u.id">
          <td>#{{ u.id }}</td>
          <td><strong>{{ u.name }}</strong></td>
          <td>{{ u.dept }}</td>
          <td><span class="role-tag">{{ u.role }}</span></td>
          <td>
            <span :class="['status-dot', u.status === 'active' ? 'green' : 'gray']"></span>
            {{ u.status === 'active' ? '在线' : '离线' }}
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'

const route = useRoute()

// 模拟数据：完全保留你原来的内容
const users = ref([
  { id: 1001, name: 'Alice', dept: '技术研发部', role: '超级管理员', status: 'active' },
  { id: 1002, name: 'Bob', dept: '市场营销部', role: '普通员工', status: 'active' },
  { id: 1003, name: 'Charlie', dept: '技术研发部', role: '普通员工', status: 'inactive' }
])

onMounted(() => {
  const loginName = route.params.username
  if (loginName && !users.value.some(item => item.name === loginName)) {
    users.value.push({
      id: Date.now(),
      name: loginName,
      dept: '当前登录部门',
      role: '普通员工',
      status: 'active'
    })
  }
})
</script>

<style scoped>
.page-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 12px rgba(0,0,0,0.05); }
.page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
.badge { background: #eef1f6; padding: 4px 8px; border-radius: 12px; font-size: 12px; color: #666; }
.data-table { width: 100%; border-collapse: collapse; }
.data-table th, .data-table td { text-align: left; padding: 12px; border-bottom: 1px solid #eee; }
.role-tag { background: #e1f3d8; color: #67c23a; padding: 2px 6px; border-radius: 4px; font-size: 12px; }
.status-dot { display: inline-block; width: 8px; height: 8px; border-radius: 50%; margin-right: 5px; }
.green { background: #42b983; } .gray { background: #ccc; }
</style>