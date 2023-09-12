<template>
  <div class="card-panel">
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
.card-panel {
  background-color: var(--background-color-extra-light);
  border-radius: var(--border-radius);
  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 16px 16px 0px 16px;

    .title {
      font-weight: bold;
      font-size: var(--font-size-big);
    }
    .description {
      flex: 1;
      margin-left: 16px;
      color: var(--font-color-light);
      font-size: var(--font-size-small);
    }
  }
  .body {
    padding: 16px;
  }
}
</style>
