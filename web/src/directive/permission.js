import { isPermission } from "../util/permission";

export default {
  // 挂载完成后
  mounted(el, binding, vnode, prevVnode) {
    console.log(binding);
    let name = binding.value;
    if (name == "") {
      return;
    }

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
