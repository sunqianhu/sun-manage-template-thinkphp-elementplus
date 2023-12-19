<template>
  <div class="fullscreen" @click="toggleFullScreen">
    <el-tooltip effect="dark" content="切换全屏" placement="bottom">
      <FullScreen class="icon" />
    </el-tooltip>
  </div>
</template>

<script setup>
import { FullScreen } from "@element-plus/icons-vue";
import screenfull from "screenfull";

/**
 * 切换全屏
 */
const toggleFullScreen = () => {
  if (screenfull.isEnabled) {
    screenfull.toggle();
  } else {
    ElMessage({
      message: "你的浏览器不支持全屏，请更换浏览器",
      type: "error"
    });
  }
};
</script>

<style lang="scss" scoped>
.fullscreen {
  line-height: 1px;
  .icon {
    width: 20px;
    height: 20px;
    cursor: pointer;
    &:hover {
      opacity: var(--opacity);
    }
  }
}
</style>
