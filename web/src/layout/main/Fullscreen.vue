<template>
  <div class="fullscreen" @click="onFullscreenClick">
    <FullScreen class="icon" />
  </div>
</template>

<script setup>
import { FullScreen } from "@element-plus/icons-vue";
import screenfull from "screenfull";

/**
 * 全屏
 */
const onFullscreenClick = () => {
  if (screenfull.isEnabled) {
    screenfull.toggle();
  }
};
</script>

<style lang="scss" scoped>
.fullscreen {
  .icon {
    width: 20px;
    height: 20px;
    cursor: pointer;
    &:hover {
      opacity: var(--hover-opacity);
    }
  }
}
</style>
