<template>
  <div class="hamburger" @click="toggleSider">
    <Fold class="icon" v-if="siderStatus" />
    <Expand class="icon" v-if="!siderStatus" />
  </div>
</template>

<script setup>
import { computed } from "vue";
import { useAppStore } from "@/store/app";
import { Fold, Expand } from "@element-plus/icons-vue";

const appStore = useAppStore();

// 侧边状态
const siderStatus = computed(() => {
  return appStore.siderStatus;
});

// 切换侧边
const toggleSider = () => {
  appStore.toggleSiderStatus();
};
</script>

<style lang="scss" scoped>
.hamburger {
  display: flex;
  height: 60px;
  padding: 0px 16px;
  cursor: pointer;
  align-items: center;
  .icon {
    width: 25px;
    height: 25px;
  }
  &:hover {
    background: rgba(0, 0, 0, 0.025);
  }
}
</style>
