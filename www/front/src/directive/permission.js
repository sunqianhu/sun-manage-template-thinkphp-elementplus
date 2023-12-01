import { isPermission } from "../helper/permission";

export default {
  //挂载完成后
  mounted(el, binding, vnode, prevVnode) {
    let name = binding.value;
    if (isPermission(name)) {
      return;
    }

    if (el.parentNode) {
      el.parentNode.removeChild(el);
    } else {
      el.style.display = "none";
    }
  }
};
