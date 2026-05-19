<template>
  <div class="role-container">
    <div class="role-card" v-for="role in roles" :key="role.id">
      <div class="role-header">
        <h4>{{ role.name }}</h4>
        <span class="count-badge">{{ role.userCount }} 名成员</span>
      </div>
      <p class="role-desc">{{ role.desc }}</p>
      <div class="permissions">
        <span v-for="p in role.permissions" :key="p" class="perm-tag">{{ p }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const roles = ref([
  { 
    id: 1, 
    name: '超级管理员', 
    desc: '拥有系统所有操作权限，包括删除数据。', 
    userCount: 1, // 对应 Alice
    permissions: ['用户管理', '角色设定', '部门调整', '发布公告'] 
  },
  { 
    id: 2, 
    name: '普通员工', 
    desc: '仅具备基础查看和个人信息编辑权限。', 
    userCount: 2, // 对应 Bob, Charlie
    permissions: ['查看列表', '修改个人资料'] 
  }
])
</script>

<style scoped>
.role-container { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
.role-card { background: white; padding: 20px; border-radius: 8px; border: 1px solid #eee; transition: 0.3s; }
.role-card:hover { box-shadow: 0 4px 12px rgba(0,0,0,0.1); transform: translateY(-2px); }
.role-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px; }
.role-header h4 { margin: 0; color: #333; }
.count-badge { font-size: 12px; color: #888; background: #f4f4f5; padding: 2px 6px; border-radius: 4px; }
.role-desc { color: #666; font-size: 14px; margin-bottom: 15px; height: 40px; }
.perm-tag { display: inline-block; font-size: 12px; border: 1px solid #d9ecff; color: #409eff; background: #ecf5ff; padding: 2px 8px; border-radius: 4px; margin: 0 5px 5px 0; }
</style>