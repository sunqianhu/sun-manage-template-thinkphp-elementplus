import NProgress from "nprogress";
import "nprogress/nprogress.css";

/**
 * 路由全局前置守卫
 * @param {*} to 即将要进入的目标
 * @param {*} from 正要离开的路由
 * @returns false | 一个路由地址 | true
 */
export const beforeEachGuard = async (to, from) => {
  NProgress.start();

  // 白名单
  const writeList = ["/login", "/404"];
  if (writeList.includes(to.path)) {
    return true;
  }
};

/**
 * 路由全局后置钩子
 * @param {*} to
 * @param {*} from
 */
export const afterEachGuard = (to, from) => {
  NProgress.done();
};
