import { createRouter, createWebHashHistory } from "vue-router";

const Router = createRouter({
    history: createWebHashHistory(),
    routes: [{
            path: "/", // 主页面路由
            // ⬇️ 把这里的 name 删掉，警告就彻底消失了
            // name: "main",  ❌ 原来的警告来源
            component: () => import("views/Index.vue"),
            children: [
                {
                    path: "",
                    name: "main", // ✅ 把 name 放在空路径这里
                    redirect: "/home",
                },
                {
                    path: "/home",
                    name: "home",
                    component: () => import("views/Home.vue"),
                },
                {
                    path: "/order",
                    name: "order",
                    component: () => import("views/Order.vue"),
                },
                {
                    path: "/me",
                    name: "me",
                    component: () => import("views/Me.vue"),
                }
            ],
        },
        {
            path: "/login",
            name: "login",
            component: () => import("views/Login.vue"),
        },
    ],
});

export default Router;