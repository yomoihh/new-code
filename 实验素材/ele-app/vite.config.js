import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import path from 'path'

export default defineConfig({
    // 以插件的形式引入vue
    plugins: [
        vue()
    ],
    // 目录别名
    resolve: {
        alias: {
            '@': path.join(__dirname, 'src'),
            'comp': path.join(__dirname, 'src/components'),
            'views': path.join(__dirname, 'src/views'),
            'assets': path.join(__dirname, 'src/assets')
        }
    },
    // 服务启动端口
    server:
    {
        port: 4000
    },
    // 第三方依赖库
    optimizeDeps: {
        include: ['mescroll.js']
    },

    // ======================
    // 👇 只加了这一段配置 👇
    // ======================
    define: {
        __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: false
    }
})