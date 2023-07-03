import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import "nprogress/nprogress.css";
import axios from "@/util/axios";
import { useAppStore } from "@/stores/app";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "main",
      component: () => import("../layout/main/Index.vue"),
      meta: {
        name: "主页"
      },
      children: []
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
  const writeList = ["/login", "/404", "/test"];
  if (writeList.includes(to.path)) {
    return true;
  }

  // 登录
  const token = localStorage.getItem("token");
  if (!token) {
    return "/login";
  } else if (to.path == "/login") {
    return "/";
  }

  const appStore = useAppStore();
  let response; // 接口响应

  // 权限
  if (!appStore.isSetPermission) {
    response = await axios.get("admin/Main/getPermissions");
    if (response.code != 1) {
      return "/login";
    }
    appStore.setPermissions(response.data);
  }

  // 动态路由
  if (!appStore.isSetRoute) {
    response = await axios.get("admin/Main/getRoutes");
    if (response.code != 1) {
      return "/login";
    }
    appStore.setRoutes(response.data);

    let allRoutes = router.getRoutes();
    let mainRoute = allRoutes.find((route) => route.name == "main");
    let dynamicRoutes = [];

    if (response.data && response.data.length > 0) {
      dynamicRoutes = response.data;
      dynamicRoutes.forEach((dynamicRoute) => {
        let componentPath = "../views/" + dynamicRoute.component;
        dynamicRoute.component = () => import(/* @vite-ignore */ componentPath);
        mainRoute.children.push(dynamicRoute);
      });
      mainRoute.redirect = mainRoute.children[0].path;
      router.addRoute(mainRoute);
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
