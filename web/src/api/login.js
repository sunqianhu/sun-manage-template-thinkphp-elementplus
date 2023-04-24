import axios from "@/util/axios";

/**
 * 登录
 * @param {object} data 用户名密码
 * @returns Promise
 */
export function login(data) {
  const url = "admin/login/login";
  return axios.post(url, data);
}
