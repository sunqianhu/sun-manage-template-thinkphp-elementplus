import { useAppStore } from "../store/app";
import axios from "../helper/axios";

/**
 * 是否有权限
 * @param {string} name 权限名称
 * @returns boolean
 */
export const isPermission = (name) => {
  const appStore = useAppStore();
  const permissions = appStore.permissions;
  if (!permissions.includes(name)) {
    return false;
  }

  return true;
};
