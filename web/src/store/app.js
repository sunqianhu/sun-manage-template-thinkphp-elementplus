import { defineStore } from "pinia";

export const useAppStore = defineStore("app", {
  state: () => {
    return {
      siderStatus: localStorage.getItem("app_sider_status") == "1" ? 1 : 0, // 左边状态
      isSetRoute: false, // 是否设置路由
      routes: [], // 路由
      isSetPermission: false, // 是否设置权限
      permissions: [] // 权限
    };
  },
  actions: {
    /**
     * 切换左边状态
     */
    toggleSiderStatus() {
      this.siderStatus = this.siderStatus == 1 ? 0 : 1;
      localStorage.setItem("app_sider_status", this.siderStatus);
    },

    /**
     * 设置左边状态
     */
    setSiderStatus(value) {
      this.siderStatus = value;
      localStorage.setItem("app_sider_status", this.siderStatus);
    },

    /**
     * 设置路由
     * @param {Array} routes
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
    },

    /**
     * 设置权限
     * @param {Array} permissions
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
