import { defineStore } from "pinia";

export const useAppStore = defineStore("app", {
  state: () => {
    return {
      siderStatus: localStorage.getItem("app_sider_status") == "1" ? 1 : 0, // 左边状态
      routers: [] // 路由
    };
  },
  actions: {
    /**
     * 设置路由
     * @param {string} routers
     */
    setRouters(routers) {
      this.routers = routers;
    },

    /**
     * 切换左边状态
     */
    toggleSiderStatus() {
      this.siderStatus = this.siderStatus == 1 ? 0 : 1;
      localStorage.setItem("app_sider_status", this.siderStatus);
    }
  }
});
