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
      name: "main",
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
  const writeList = ["/login", "/404"];
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

  const appStore = useAppStore();
  let res; // 接口响应

  // 权限
  if (!appStore.isSetPermission) {
    res = await axios.get("admin/permission/getPermissions");
    if (res.code == 0) {
      return "/login";
    }
    appStore.setPermissions(res.data);
  }

  // 动态路由
  if (!appStore.isSetRoute) {
    res = await axios.get("admin/route/getRoutes");
    if (res.code == 0) {
      return "/login";
    }
    appStore.setRoutes(res.data);

    // 变量
    let allRoutes = router.getRoutes();
    let mainRoute = allRoutes.find((route) => route.name == "main");
    let dynamicRoutes = [];

    // 主布局
    if (res.data.main) {
      dynamicRoutes = res.data.main;
      if (dynamicRoutes.length > 0) {
        dynamicRoutes.forEach((dynamicRoute) => {
          dynamicRoute.component = import("../views/" + dynamicRoute.component);
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
          dynamicRoute.component = import("../views/" + dynamicRoute.component);
          router.addRoute(dynamicRoute);
        });
      }
    }

    return to.path;
  }

  return true;
});

// 后置钩子
router.afterEach((to, from) => {
  NProgress.done();
});

export default router;
