import { defineStore } from 'pinia'

export const useUserStore = defineStore('user', {
  state: () => ({
    // 当前登录的用户名
    currentUsername: '',
  }),

  actions: {
    // 设置用户名
    setUser(name) {
      this.currentUsername = name
    },
  },

  // 开启持久化（刷新不丢失）
  persist: true,
})