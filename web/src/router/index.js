import { createRouter, createWebHistory } from "vue-router";
import { beforeEachGuard, afterEachGuard } from "./guard";
import Index from "../views/Index.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "index",
      component: Index
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
