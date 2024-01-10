<template>
  <el-col :xs="props.xs" :sm="props.sm" :md="props.md" :lg="props.lg" class="col">
    <div class="label">{{ label }}：</div>
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
  },
  lg: {
    type: Number,
    default: 6
  }
});
</script>

<style scoped lang="scss">
.col {
  display: flex;
  padding: 3px 0px;
  .label {
    color: var(--font-color-secondary);
  }
  .content {
  }
}
</style>
