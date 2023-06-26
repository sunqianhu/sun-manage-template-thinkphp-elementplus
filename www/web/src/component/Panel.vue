<template>
  <div class="panel">
    <div class="header">
      <div class="title">{{ props.title }}</div>
      <div class="description" v-if="props.description">{{ props.description }}</div>
      <div class="button">
        <slot name="button"></slot>
      </div>
    </div>
    <div class="body">
      <slot name="default"></slot>
    </div>
  </div>
</template>

<script setup>
const props = defineProps(["title", "description"]);
</script>

<style lang="scss" scoped>
.panel {
  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
    .title {
      padding: 0px 4px;
      color: var(--el-color-primary);
      border-bottom: 2px solid var(--el-color-primary);
      position: relative;
      z-index: 2;
      height: 35px;
      line-height: 35px;
      font-weight: bold;
    }
    .description {
      flex: 1;
      margin-left: 16px;
      color: var(--gray-font-color);
      font-size: var(--small-font-size);
    }
    &::after {
      content: "";
      position: absolute;
      bottom: 0px;
      width: 100%;
      height: 1px;
      background-color: var(--border-color);
    }
  }
  .body {
    margin-top: 12px;
  }
}
</style>
