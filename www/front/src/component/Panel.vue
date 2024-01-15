<template>
  <div class="panel">
    <slot name="header">
      <div class="header" v-if="title || subTitle || $slots.extra">
        <div class="title" v-if="title">{{ title }}</div>
        <div class="sub-title" v-if="subTitle">{{ subTitle }}</div>
        <div class="extra">
          <slot name="extra">{{ extra }}</slot>
        </div>
      </div>
    </slot>
    <div class="body">
      <slot name="default"></slot>
    </div>
  </div>
</template>

<script setup>
const props = defineProps({
  title: {
    type: String,
    default: ""
  },
  subTitle: {
    type: String,
    default: ""
  },
  extra: {
    type: String,
    default: ""
  }
});
</script>

<style lang="scss" scoped>
.panel {
  background: var(--background-color-panel);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    position: relative;
    height: 45px;
    .title {
      padding: 0px 8px;
      margin-left: var(--margin-small);
      color: var(--color-primary);
      border-bottom: 2px solid var(--color-primary);
      position: relative;
      z-index: 2;
      font-size: var(--font-size-big);
      font-weight: bold;
      line-height: 43px;
    }
    .sub-title {
      flex: 1;
      margin-left: var(--margin);
      color: var(--font-color-secondary);
      font-size: var(--font-size-small);
    }
    .extra {
      margin-left: auto;
      margin-right: 16px;
    }
    &::after {
      content: "";
      position: absolute;
      bottom: 0px;
      left: 0px;
      right: 0px;
      height: 0.5px;
    }
  }
  .body {
    padding: var(--padding);
  }
}
</style>
