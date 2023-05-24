<template>
  <div class="layout">
    <el-container :class="{ container: true, close: !siderStatus }">
      <el-aside class="aside">
        <div class="system-name">
          <img src="@/asset/image/logo.svg" class="logo" />
          <span class="name">管理后台</span>
        </div>
        <Menu></Menu>
      </el-aside>
      <el-container class="workspace">
        <el-header class="header">
          <Hamburger></Hamburger>
          <div class="right">
            <FullScreen class="full-screen"></FullScreen>
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
import { computed, onMounted } from "vue";
import { useAppStore } from "@/store/app";
import Menu from "./Menu.vue";
import Hamburger from "./Hamburger.vue";
import FullScreen from "./FullScreen.vue";
import Avatar from "./Avatar.vue";

const appStore = useAppStore();
const siderStatus = computed(() => {
  return appStore.siderStatus;
});

/**
 * 初始化
 */
const init = () => {
  if (document.body.clientWidth < 768) {
    appStore.setSiderStatus(0);
  }
};

window.onresize = () => {
  if (document.body.clientWidth < 768) {
    appStore.setSiderStatus(0);
  }
};

onMounted(() => {
  init();
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
.layout {
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
        height: 50px;
        line-height: 50px;
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

    .workspace {
      background-color: var(--fill-color);
      .header {
        display: flex;
        align-items: center;
        height: 50px;
        background-color: #ffffff;
        box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
        padding: 0px;
        .full-screen {
          margin-right: 16px;
        }
        .right {
          flex: 1;
          display: flex;
          align-items: center;
          justify-content: flex-end;
          margin-right: 16px;
        }
      }
      .main {
        padding: 16px;
      }
    }
    &.close {
      .aside {
        width: 64px;
      }
    }
  }

  @media (max-width: 768px) {
    .container {
      &.close {
        .aside {
          width: 0px;
        }
      }
    }
  }
}
</style>
