<template>
  <div class="blank-layout">
    <router-view v-slot="{ Component, route }">
      <keep-alive v-if="route.meta.keep_alive == true">
        <component :is="Component" />
      </keep-alive>
      <component :is="Component" v-else />
    </router-view>
  </div>
</template>

<script setup></script>

<style lang="scss" scoped>
.blank-layout {
}
</style>
