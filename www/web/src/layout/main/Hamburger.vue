<template>
  <div class="hamburger" @click="toggleSider">
    <component :is="icon" class="icon"></component>
  </div>
</template>

<script setup>
import { computed } from "vue";
import { useAppStore } from "@/stores/app";
import { Fold, Expand } from "@element-plus/icons-vue";

const appStore = useAppStore();
const icon = computed(() => {
  return appStore.siderStatus ? Fold : Expand;
}); // 图标

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
