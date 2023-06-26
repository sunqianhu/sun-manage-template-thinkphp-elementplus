<template>
  <el-col :xs="props.xs" :sm="props.sm" :md="props.md" class="col">
    <div class="key">{{ label }}</div>
    <div class="value"><slot></slot></div>
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
  .key {
    color: var(--gray-font-color);
    width: 80px;
    display: inline-block;
  }
  .value {
    display: inline-block;
    margin-left: 16px;
  }
}
</style>
