import { createRouter, createWebHistory } from "vue-router";
import NProgress from "nprogress";
import "nprogress/nprogress.css";
import axios from "@/helper/axios";
import { useAppStore } from "@/store/app";

/**
 * 得到登录路由路径
 * @returns
 */
const getLoginRoutePath = () => {
  return "/login";
};

//路由对象
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "main",
      component: () => import("../view/main/Index.vue"),
      meta: {
        name: "首页"
      },
      children: []
    },
    {
      path: "/blank",
      name: "blank",
      component: () => import("../view/blank/Index.vue"),
      meta: {
        name: "空白页面"
      },
      children: []
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../view/Login.vue"),
      meta: {
        name: "登录"
      }
    },
    {
      path: "/test",
      name: "test",
      component: () => import("../view/Test.vue"),
      meta: {
        name: "测试页面"
      }
    },
    {
      path: "/:pathMatch(.*)*",
      name: "404",
      component: () => import("../view/404.vue"),
      meta: {
        name: "页面没有找到"
      }
    }
  ]
});

//前置守卫
router.beforeEach(async (to, from) => {
  NProgress.start();

  //白名单
  const writeList = ["/login", "/404", "/test"];
  if (writeList.includes(to.path)) {
    return true;
  }

  //登录
  const token = localStorage.getItem("token");
  if (!token) {
    return getLoginRoutePath();
  }

  const appStore = useAppStore();
  let response; //响应

  //权限
  if (!appStore.isSetPermission) {
    response = await axios.get("manage/frame/getPermissions");
    if (response.code != 1) {
      return getLoginRoutePath();
    }
    appStore.setPermissions(response.data);
  }

  //动态路由
  if (!appStore.isSetRoute) {
    response = await axios.get("manage/frame/getRoutes");
    if (response.code != 1) {
      return getLoginRoutePath();
    }
    appStore.setRoutes(response.data);

    let allRoutes = router.getRoutes();
    let mainRoute = allRoutes.find((route) => route.name == "main");
    let blankRoute = allRoutes.find((route) => route.name == "blank");
    let childRoutes = [];
    const componentFilePaths = import.meta.glob([
      "@/view/*.vue",
      "@/view/*/*.vue",
      "@/view/*/*/*.vue",
      "@/view/*/*/*/*.vue"
    ]);

    if (response.data.length > 0) {
      childRoutes = response.data;

      childRoutes.forEach((childRoute) => {
        childRoute.component = componentFilePaths["/src/view/" + childRoute.component];
        if (childRoute.layout == "main") {
          mainRoute.children.push(childRoute);
          if (childRoute.parent_redirect) {
            mainRoute.redirect = childRoute.path;
          }
        }
        if (childRoute.layout == "blank") {
          blankRoute.children.push(childRoute);
          if (childRoute.parent_redirect) {
            blankRoute.redirect = childRoute.path;
          }
        }
      });

      router.addRoute(mainRoute);
      router.addRoute(blankRoute);
    }

    return to.path;
  }

  return true;
});

//后置钩子
router.afterEach((to, from) => {
  NProgress.done();
  document.title = to.meta.name;
});

export default router;
