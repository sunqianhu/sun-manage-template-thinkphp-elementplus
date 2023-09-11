<template>
  <template v-for="menu in menus">
    <el-menu-item v-if="!menu.children" :index="menu.url">
      <el-icon v-if="menu.icon">
        <component :is="icons[menu.icon]"></component>
      </el-icon>
      <span>{{ menu.name }}</span>
    </el-menu-item>
    <el-sub-menu v-else index="">
      <template #title>
        <el-icon v-if="menu.icon">
          <component :is="icons[menu.icon]"></component>
        </el-icon>
        <span>{{ menu.name }}</span>
      </template>
      <MenuItem :menus="menu.children"></MenuItem>
    </el-sub-menu>
  </template>
</template>

<script setup>
import * as icons from "@element-plus/icons-vue";

const props = defineProps({
  menus: Array
});
</script>

<style lang="scss" scoped>
.el-sub-menu.is-active {
  ::v-deep(.el-sub-menu__title) {
    color: #ffffff !important;
  }
}
.el-menu-item.is-active {
  background-color: #1890ff;
}
</style>
