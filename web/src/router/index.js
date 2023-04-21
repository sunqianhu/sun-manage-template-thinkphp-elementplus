import { createRouter, createWebHistory } from "vue-router";
import { beforeEachGuard, afterEachGuard } from "./guard";
import HomeView from "../views/Home.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView
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
