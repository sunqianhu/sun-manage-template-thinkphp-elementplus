<template>
  <el-menu
    mode="vertical"
    background-color="#001529"
    text-color="rgba(255, 255, 255, 0.65)"
    active-text-color="#ffffff"
    :default-active="defaultActive"
    :collapse="!appStore.siderStatus"
    :unique-opened="true"
    :router="true"
    class="menu"
  >
    <menu-item :menus="menus"></menu-item>
  </el-menu>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import { useAppStore } from "@/store/app";
import axios from "@/helper/axios";
import MenuItem from "./MenuItem.vue";

const appStore = useAppStore();
const route = useRoute();
const defaultActive = route.fullPath; //默认活跃项
const menus = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/Main/getMenus");
  menus.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.menu {
  border-right: none;
}
</style>
