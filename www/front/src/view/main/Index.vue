<template>
  <div class="main-layout">
    <el-container :class="{ close: !appStore.siderStatus }" class="container">
      <el-aside class="aside">
        <div class="system-name">
          <img src="@/asset/image/logo.png" class="logo" />
          <span class="name">vue管理系统模板</span>
        </div>
        <el-scrollbar class="menu-wrap"><Menu></Menu></el-scrollbar>
        <div class="version">版本：{{ config.version }}</div>
      </el-aside>
      <el-container class="workspace">
        <el-header class="header">
          <hamburger></hamburger>
          <div class="right">
            <light-dark class="light-dark"></light-dark>
            <full-screen class="fullscreen"></full-screen>
            <avatar></avatar>
          </div>
        </el-header>
        <el-main class="body">
          <router-view v-slot="{ Component, route }">
            <keep-alive>
              <component :is="Component" v-if="route.meta.keep_alive == true" />
            </keep-alive>
            <component :is="Component" v-if="route.meta.keep_alive != true" />
          </router-view>
          <el-backtop :right="15" :bottom="15" target=".workspace .body"> UP </el-backtop>
        </el-main>
      </el-container>
    </el-container>
    <message></message>
    <watermark />
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useAppStore } from "@/store/app";
import Menu from "./Menu.vue";
import LightDark from "./LightDark.vue";
import Hamburger from "./Hamburger.vue";
import FullScreen from "./FullScreen.vue";
import Avatar from "./Avatar.vue";
import Message from "./Message.vue";
import Watermark from "@/component/Watermark.vue";
import axios from "@/helper/axios";

const appStore = useAppStore();
const config = ref({});

/**
 * 初始化
 */
const init = async () => {
  if (document.body.clientWidth < 768) {
    appStore.setSiderStatus(false);
  }

  const response = await axios.get("manage/main/init");
  if (response.code != 1) {
    return;
  }
  config.value = response.data.config;
};

/**
 * 窗口大小改变回调
 */
window.onresize = () => {
  if (document.body.clientWidth < 768) {
    appStore.setSiderStatus(false);
  } else {
    appStore.setSiderStatus(true);
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
.main-layout {
  height: 100%;

  .container {
    height: 100%;

    .aside {
      width: 220px;
      box-shadow: 2px 0 6px rgb(0 21 41 / 35%);
      background-color: #1d1e72;
      color: #ffffff;
      z-index: 2;
      transition: width 0.5s;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      .system-name {
        width: 220px;
        height: 50px;
        line-height: 50px;
        overflow: hidden;
        transition: all 0.5s;
        padding-left: 12px;
        .logo {
          height: 25px;
          vertical-align: text-bottom;
        }
        .name {
          font-size: 20px;
          font-weight: bold;
          margin-left: 8px;
          display: inline-block;
          transition: all 0.5s;
        }
      }
      .menu-wrap {
        flex: 1;
      }
      .version {
        padding-left: 16px;
        font-size: var(--font-size-small);
        color: var(--font-color-secondary);
      }
    }

    .workspace {
      background-color: var(--background-color-page-texture);
      .header {
        display: flex;
        align-items: center;
        height: 50px;
        background-color: #ffffff;
        box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
        padding: 0px;
        .right {
          flex: 1;
          display: flex;
          align-items: center;
          justify-content: flex-end;
          margin-right: 16px;
          .light-dark {
            margin-right: 16px;
          }
          .fullscreen {
            margin-right: 16px;
          }
        }
      }
      .body {
        padding: 16px;
      }
    }
    &.close {
      .aside {
        width: 64px;
        .system-name {
          padding-left: 19px;
          .name {
            margin-left: 30px;
          }
        }
        .version {
          display: none;
        }
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

//暗黑模式
.dark {
  .main-layout {
    .container {
      .aside {
        background-color: #141414;
      }
      .workspace {
        .header {
          background-color: #141414;
        }
      }
    }
  }
}
</style>
