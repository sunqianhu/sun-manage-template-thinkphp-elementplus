import axios from "axios";
import router from "../router";
import { useAppStore } from "../store/app";
import { config } from "../../config.js";

const instance = axios.create({
  baseURL: config.proxyPrefix,
  timeout: 1000 * 15
});

// 请求拦截器
instance.interceptors.request.use(
  function (config) {
    // token
    let token = localStorage.getItem("token");
    if (token) {
      config.headers.token = token;
    }

    return config;
  },
  function (error) {
    ElMessage({
      message: error.message,
      type: "error"
    });
    return Promise.reject(error);
  }
);

// 响应拦截器
instance.interceptors.response.use(
  function (response) {
    const data = response.data;

    if (data && data.code != 1 && data.message.indexOf("登录已失效") !== -1) {
      logout();
      return Promise.reject(data);
    }

    return data;
  },
  function (error) {
    ElMessage({
      message: error.message,
      type: "error"
    });
    return Promise.reject(error);
  }
);

/**
 * 退出登录
 */
const logout = () => {
  const appStore = useAppStore();

  localStorage.removeItem("token");
  appStore.clearRoutes();
  appStore.clearPermissions();
  router.replace("/login");
};

export default instance;
