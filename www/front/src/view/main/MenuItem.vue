<template>
  <template v-for="menu in menus" :key="menu.id">
    <template v-if="!menu.children">
      <el-menu-item index="" v-if="menu.type_id == 4" @click="openOutLink(menu.url)">
        <el-icon v-if="menu.icon">
          <component :is="icons[menu.icon]"></component>
        </el-icon>
        <span>{{ menu.name }}</span>
      </el-menu-item>
      <el-menu-item :index="menu.path" v-else>
        <el-icon v-if="menu.icon">
          <component :is="icons[menu.icon]"></component>
        </el-icon>
        <span>{{ menu.name }}</span>
      </el-menu-item>
    </template>
    <el-sub-menu v-else :index="'/' + menu.id">
      <template #title>
        <el-icon v-if="menu.icon">
          <component :is="icons[menu.icon]"></component>
        </el-icon>
        <span>{{ menu.name }}</span>
      </template>
      <menu-item :menus="menu.children"></menu-item>
    </el-sub-menu>
  </template>
</template>

<script setup>
import * as icons from "@element-plus/icons-vue";

const props = defineProps({
  menus: {
    type: Array,
    default: []
  }
});

/**
 * 打开外部链接
 * @param {*} url
 */
const openOutLink = (url) => {
  window.open(url);
};
</script>

<style lang="scss" scoped>
.el-sub-menu.is-active {
  :deep(.el-sub-menu__title) {
    color: #ffffff !important;
  }
}
.el-menu-item.is-active {
  background-color: #1890ff;
}
</style>
