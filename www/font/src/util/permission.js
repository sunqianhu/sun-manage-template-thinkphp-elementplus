import { useAppStore } from "../stores/app";
import axios from "../util/axios";

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
