<template>
  <div class="hamburger" @click="toggleHamburger">
    <component :is="icon" class="icon"></component>
  </div>
</template>

<script setup>
import { computed } from "vue";
import { useAppStore } from "@/store/app";
import { Fold, Expand } from "@element-plus/icons-vue";

const appStore = useAppStore();

// 侧边状态
const icon = computed(() => {
  return appStore.siderStatus ? Fold : Expand;
});

/**
 * 切换汉堡宝
 */
const toggleHamburger = () => {
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
      opacity: var(--hover-opacity);
    }
  }
}
</style>
