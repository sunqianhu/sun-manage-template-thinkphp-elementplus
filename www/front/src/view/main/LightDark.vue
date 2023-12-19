<template>
  <div class="light-dark">
    <el-tooltip effect="dark" content="切换主题" placement="bottom">
      <el-switch
        v-model="switchChecked"
        :active-action-icon="Moon"
        :inactive-action-icon="Sunny"
        @change="toggleDark"
      />
    </el-tooltip>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useDark, useToggle } from "@vueuse/core";
import { Sunny, Moon } from "@element-plus/icons-vue";

const isDark = useDark();
const toggleDark = useToggle(isDark);
const switchChecked = ref(isDark);
</script>

<style lang="scss" scoped>
.light-dark {
  cursor: pointer;
  :deep(.el-switch .el-icon) {
    color: #203549;
  }
  :deep(.el-switch.is-checked .el-switch__core) {
    background-color: #203549;
    border-color: #203549;
  }
  :deep(.el-switch.is-checked .el-icon) {
    color: #506579;
  }
  &:hover {
  }
}
</style>
