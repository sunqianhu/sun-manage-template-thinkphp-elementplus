import axios from "@/util/axios";

// 登录
export function loginApi(data) {
  const url = "admin/login/login";
  return axios.post(url, data);
}
