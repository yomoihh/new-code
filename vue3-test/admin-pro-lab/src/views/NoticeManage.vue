<template>
  <div class="notice-list">
    <div 
      v-for="item in notices" 
      :key="item.id" 
      class="notice-item"
      :class="{ 'urgent': item.type === 'high' }"
    >
      <div class="notice-date">{{ item.date }}</div>
      <div class="notice-content">
        <span class="tag" v-if="item.type === 'high'">紧急</span>
        <span class="title">{{ item.title }}</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const notices = ref([
  { id: 1, title: '关于本周六服务器升级维护的通知', date: '2023-11-20', type: 'high' },
  { id: 2, title: '五一劳动节放假安排', date: '2023-04-25', type: 'normal' },
  { id: 3, title: '新版员工手册发布', date: '2023-03-10', type: 'normal' }
])
</script>

<style scoped>
.notice-list { background: white; padding: 20px; border-radius: 8px; }
.notice-item { display: flex; align-items: center; padding: 15px 0; border-bottom: 1px dashed #eee; }
.notice-item:last-child { border-bottom: none; }
.notice-date { color: #999; width: 100px; font-family: monospace; }
.tag { background: #f56c6c; color: white; font-size: 12px; padding: 2px 5px; border-radius: 3px; margin-right: 8px; }
.title { font-size: 15px; color: #333; }
.urgent .title { font-weight: bold; }
</style>