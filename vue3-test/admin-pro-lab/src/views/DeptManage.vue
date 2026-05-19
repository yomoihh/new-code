<template>
  <div class="dept-layout">
    <h3>🏢 组织架构</h3>
    <div class="dept-grid">
      <div class="dept-box" v-for="dept in depts" :key="dept.id">
        <div class="dept-icon">{{ dept.name[0] }}</div>
        <div class="dept-info">
          <h4>{{ dept.name }}</h4>
          <p>📍 {{ dept.location }}</p>
          <p>👤 负责人：<strong>{{ dept.manager }}</strong></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const depts = ref([
  { id: 101, name: '技术研发部', manager: 'Alice', location: '总部大楼 12F' }, // Alice 是经理
  { id: 102, name: '市场营销部', manager: 'David', location: '总部大楼 8F' },
  { id: 103, name: '人力资源部', manager: 'Eva', location: '总部大楼 6F' }
])
</script>

<style scoped>
.dept-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; margin-top: 20px; }
.dept-box { background: white; padding: 20px; border-radius: 8px; display: flex; align-items: center; gap: 15px; border: 1px solid #eee; }
.dept-icon { width: 50px; height: 50px; background: #42b983; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 20px; font-weight: bold; }
.dept-info h4 { margin: 0 0 5px 0; font-size: 16px; }
.dept-info p { margin: 3px 0; font-size: 13px; color: #666; }
</style>