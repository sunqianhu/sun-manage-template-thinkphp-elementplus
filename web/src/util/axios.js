import axios from "axios";

const request = axios.create({
  baseURL: "/api",
  timeout: 1000 * 15
});

// 请求拦截器
request.interceptors.request.use(
  function (config) {
    // 在发送请求之前做些什么
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
      message: error,
      type: "error"
    });
    return Promise.reject(error);
  }
);

export default request;
