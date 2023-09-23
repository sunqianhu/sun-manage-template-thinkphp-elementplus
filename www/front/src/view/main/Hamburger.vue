<template>
  <div class="hamburger" @click="toggleSider">
    <component :is="appStore.siderStatus ? Fold : Expand" class="icon"></component>
  </div>
</template>

<script setup>
import { useAppStore } from "@/store/app";
import { Fold, Expand } from "@element-plus/icons-vue";

const appStore = useAppStore();

/**
 * 切换左边
 */
const toggleSider = () => {
  appStore.toggleSiderStatus();
};
</script>

<style lang="scss" scoped>
.hamburger {
  height: 50px;
  width: 50px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  .icon {
    width: 25px;
    height: 25px;
  }
  &:hover {
    background: rgba(0, 0, 0, 0.025);
    .icon {
      opacity: var(--opacity);
    }
  }
}
</style>
