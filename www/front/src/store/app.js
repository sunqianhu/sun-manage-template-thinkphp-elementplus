import { defineStore } from "pinia";
import router from "../router/index.js";

export const useAppStore = defineStore("app", {
  state: () => {
    return {
      siderStatus: true, //左边状态
      isSetRoute: false, //是否设置路由
      routes: [], //路由
      isSetPermission: false, //是否设置权限
      permissions: [] //权限
    };
  },
  actions: {
    /**
     * 切换左边状态
     */
    toggleSiderStatus() {
      let value = "1";

      this.siderStatus = this.siderStatus ? false : true;
      value = this.siderStatus ? "1" : "0";
      localStorage.setItem("app_sider_status", value);
    },

    /**
     * 设置左边状态
     * @param {boolean} status
     */
    setSiderStatus(status) {
      let value = "1";

      this.siderStatus = status;
      value = this.siderStatus ? "1" : "0";
      localStorage.setItem("app_sider_status", value);
    },

    /**
     * 设置路由
     * @param {array} routes 路由数组
     */
    setRoutes(routes) {
      this.isSetRoute = true;
      this.routes = routes;
    },

    /**
     * 清除路由
     */
    clearRoutes() {
      this.isSetRoute = false;
      this.routes = [];

      const allRoutes = router.getRoutes();
      let mainRoute = allRoutes.find((route) => route.name == "main");
      let childrenLength = mainRoute.children.length;
      let childrenIndex = 0;
      if (childrenLength > 0) {
        for (childrenIndex; childrenIndex < childrenLength; childrenIndex++) {
          router.removeRoute(mainRoute.children[childrenIndex].name);
        }
        mainRoute.children = [];
      }
      mainRoute.redirect = undefined;
      router.addRoute(mainRoute);
    },

    /**
     * 设置权限
     * @param {array} permissions 权限数组
     */
    setPermissions(permissions) {
      this.isSetPermission = true;
      this.permissions = permissions;
    },

    /**
     * 清除权限
     */
    clearPermissions() {
      this.isSetPermission = false;
      this.permissions = [];
    }
  }
});
