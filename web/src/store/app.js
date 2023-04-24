import { defineStore } from "pinia";

export const useAppStore = defineStore("app", {
  state: () => {
    return {
      token: "", // token
      routers: [], // 路由
      siderStatus: 1 // 左边状态
    };
  },
  actions: {
    /**
     * 设置token
     * @param {string} token
     */
    setToken(token) {
      this.token = token;
    },

    /**
     * 设置路由
     * @param {string} routers
     */
    setRouters(routers) {
      this.routers = routers;
    },

    /**
     * 切换左边状态
     * @param {int} status 状态
     */
    toggleSiderStatus(status) {
      this.siderStatus = this.siderStatus == 1 ? 1 : 0;
      localStorage.setItem("main_layout_sider_status", this.siderStatus);
    }
  }
});
