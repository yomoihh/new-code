// 1. 所有导入统一写在最顶部（只写一次）
import { createApp } from 'vue'
import './style.css'
import App from './App.vue'

// 路由 & 状态管理
import router from './router.js'
import store from './store.js'

// axios
import axios from 'axios'
import VueAxios from 'vue-axios'
import qs from 'qs'

// vant 组件
import { Toast, Swipe, SwipeItem } from 'vant'
import 'vant/lib/index.css'

// ==========================
// axios 全局配置
// ==========================
axios.defaults.baseURL = 'http://localhost:3000/'

// 请求拦截
axios.interceptors.request.use(
  (config) => {
    if (config.method === 'post') {
      config.data = qs.stringify(config.data)
    }
    Toast.loading({ duration: 1 })
    return config
  },
  (error) => Promise.reject(error)
)

// 响应拦截
axios.interceptors.response.use(
  (response) => response,
  (error) => Promise.reject(error)
)

// ==========================
// 创建 & 挂载 Vue 应用
// ==========================
const app = createApp(App)

app
  .use(store)
  .use(router)
  .use(VueAxios, axios)
  .use(Swipe)
  .use(SwipeItem)
  .mount('#app')