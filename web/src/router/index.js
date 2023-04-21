import { createRouter, createWebHistory } from "vue-router";
import { beforeEachGuard, afterEachGuard } from "./guard";
import Index from "../views/Index.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      component: () => import("../layout/main/Index.vue"),
      meta: {
        name: "首页",
        permission: "all"
      },
      redirect: "/index",
      children: [
        {
          path: "index",
          name: "index",
          component: () => import("../views/Index.vue"),
          meta: {
            name: "工作台"
          }
        }
      ]
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/Login.vue")
    },
    {
      path: "/test",
      name: "test",
      component: () => import("../views/Test.vue")
    }
  ]
});

// 前置守卫
router.beforeEach(beforeEachGuard);

// 后置钩子
router.afterEach(afterEachGuard);

export default router;
