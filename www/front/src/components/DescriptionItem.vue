<template>
  <el-col :xs="props.xs" :sm="props.sm" :md="props.md" class="col">
    <div class="label">{{ label }}</div>
    <div class="content"><slot></slot></div>
  </el-col>
</template>

<script setup lang="ts">
const props = defineProps({
  label: {
    type: String,
    default: ""
  },
  xs: {
    type: Number,
    default: 24
  },
  sm: {
    type: Number,
    default: 12
  },
  md: {
    type: Number,
    default: 8
  }
});
</script>

<style scoped lang="scss">
.col {
  .label {
    color: var(--font-color-secondary);
    width: 80px;
    display: inline-block;
  }
  .content {
    display: inline-block;
    margin-left: 16px;
  }
}
</style>
