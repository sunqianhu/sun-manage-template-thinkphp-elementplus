<template>
  <div class="page-main">
    <el-container :class="{ container: true, close: !siderStatus }">
      <el-aside class="aside">
        <div class="system-name">
          <img src="@/asset/image/logo.svg" class="logo" />
          <span class="name">管理后台</span>
        </div>
        <Menu></Menu>
      </el-aside>
      <el-container class="right-container">
        <el-header class="header">
          <Hamburger></Hamburger>
          <div class="right">
            <Avatar></Avatar>
          </div>
        </el-header>
        <el-main class="main">
          <router-view />
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup>
import { computed } from "vue";
import { useAppStore } from "@/store/app";
import Menu from "./Menu.vue";
import Hamburger from "./Hamburger.vue";
import Avatar from "./Avatar.vue";

const appStore = useAppStore();

// 侧边状态
const siderStatus = computed(() => {
  return appStore.siderStatus;
});
</script>

<style lang="scss">
html {
  height: 100%;

  body {
    height: 100%;

    #app {
      height: 100%;
    }
  }
}
</style>

<style lang="scss" scoped>
.page-main {
  height: 100%;

  .container {
    height: 100%;

    .aside {
      width: 220px;
      box-shadow: 2px 0 6px rgb(0 21 41 / 35%);
      background-color: #001529;
      color: #ffffff;
      transition: all 0.5s;
      z-index: 2;
      .system-name {
        height: 60px;
        line-height: 64px;
        overflow-y: hidden;
        padding-left: 18px;
        .logo {
          height: 24px;
          vertical-align: middle;
        }
        .name {
          font-size: 20px;
          font-weight: 600;
          margin-left: 12px;
          vertical-align: middle;
          display: inline-block;
        }
      }
    }

    .right-container {
      background-color: #f0f2f5;
      .header {
        display: flex;
        align-items: center;
        height: 60px;
        background-color: #ffffff;
        box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
        padding: 0px 16px 0px 0px;
        .right {
          flex: 1;
          display: flex;
          align-items: center;
          justify-content: flex-end;
        }
      }
    }
    &.close {
      .aside {
        width: 64px;
      }
    }
  }
}
</style>
