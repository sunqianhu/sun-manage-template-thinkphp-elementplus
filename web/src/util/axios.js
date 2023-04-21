import axios from "axios";

const request = axios.create({
  baseURL: "/api",
  timeout: 1000 * 15
});

// 请求拦截器
request.interceptors.request.use(
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
      message: error,
      type: "error"
    });
    return Promise.reject(error);
  }
);

// 响应拦截器
request.interceptors.response.use(
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

export default request;
