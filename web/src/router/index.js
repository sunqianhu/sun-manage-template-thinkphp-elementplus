import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import "nprogress/nprogress.css";
import axios from "@/util/axios";
import { useAppStore } from "@/store/app";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "admin",
      component: () => import("../layout/main/Index.vue"),
      meta: {
        name: "主布局"
      },
      children: []
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/Login.vue")
    },
    {
      path: "/:pathMatch(.*)*",
      name: "404",
      component: () => import("../views/404.vue")
    }
  ]
});

// 前置守卫
router.beforeEach(async (to, from) => {
  NProgress.start();

  // 白名单
  const writeList = ["/login", "/test", "/404"];
  if (writeList.includes(to.path)) {
    return true;
  }

  // 未登录
  const token = localStorage.getItem("token");
  if (!token) {
    return "/login";
  }

  // 已登录
  if (to.path == "/login") {
    return "/";
  }

  // 动态路由
  const appStore = useAppStore();
  let res;
  if (!appStore.isSetRoute) {
    res = await axios.get("admin/route/getRoutes");
    if (res.code == 0) {
      return "/login";
    }
    appStore.setRoutes(res.data);

    // 变量
    let allRoutes = router.getRoutes();
    let mainRoute = allRoutes.find((route) => route.name == "admin");
    let componentPath = "";
    let dynamicRoutes = [];

    // 主布局
    if (res.data.main) {
      dynamicRoutes = res.data.main;
      if (dynamicRoutes.length > 0) {
        dynamicRoutes.forEach((dynamicRoute) => {
          componentPath = "../views/" + dynamicRoute.component;
          dynamicRoute.component = () => import(componentPath);
          mainRoute.children.push(dynamicRoute);
        });
        mainRoute.redirect = mainRoute.children[0].path;
        router.addRoute(mainRoute);
      }
    }

    // 空白布局
    if (res.data.blank) {
      dynamicRoutes = res.data.blank;
      if (dynamicRoutes.length > 0) {
        dynamicRoutes.forEach((dynamicRoute) => {
          componentPath = "../views/" + dynamicRoute.component;
          dynamicRoute.component = () => import(componentPath);
          router.addRoute(dynamicRoute);
        });
      }
      return to.path;
    }

    return true;
  }

  // 权限指令

  return true;
});

// 后置钩子
router.afterEach((to, from) => {
  NProgress.done();
});

export default router;
