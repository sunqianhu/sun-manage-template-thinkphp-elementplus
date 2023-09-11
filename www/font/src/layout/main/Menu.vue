<template>
  <el-menu
    class="menu"
    background-color="#001529"
    text-color="rgba(255, 255, 255, 0.65)"
    :default-active="defaultActive"
    active-text-color="#ffffff"
    :collapse="!siderStatus"
    :unique-opened="true"
    :router="true"
  >
    <MenuItem :menus="menus"></MenuItem>
  </el-menu>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import { useRoute } from "vue-router";
import { useAppStore } from "@/stores/app";
import axios from "@/util/axios";
import MenuItem from "./MenuItem.vue";

const appStore = useAppStore();
const route = useRoute();
const defaultActive = route.fullPath; // 默认活跃项
const menus = ref([]);
const siderStatus = computed(() => {
  return appStore.siderStatus;
});

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("admin/Main/getMenus");
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
