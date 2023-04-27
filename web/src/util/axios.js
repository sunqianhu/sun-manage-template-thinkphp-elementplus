import axios from "axios";

const instance = axios.create({
  baseURL: "/api",
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
    // 对请求错误做些什么
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
    return response.data;
  },
  function (error) {
    ElMessage({
      message: error.message,
      type: "error"
    });
    return Promise.reject(error);
  }
);

export default instance;
