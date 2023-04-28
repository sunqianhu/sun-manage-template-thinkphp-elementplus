import axios from "@/util/axios";
import { useAppStore } from "@/store/app";

const mainRoute = {
  path: "/",
  name: "admin",
  component: () => import("../layout/main/Index.vue"),
  meta: {
    name: "首页"
  },
  redirect: "/index",
  children: []
};

export const load = (router) => {};
