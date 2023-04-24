import axios from "@/util/axios";

/**
 * 得到菜单
 * @returns Promise
 */
export function getMenus() {
  const url = "admin/menu/getMenus";
  return axios.get(url);
}
