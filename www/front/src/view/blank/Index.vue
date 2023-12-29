<template>
  <div class="blank-layout">
    <router-view v-slot="{ Component, route }">
      <keep-alive v-if="route.meta.keep_alive == true">
        <component :is="Component" />
      </keep-alive>
      <component :is="Component" v-else />
    </router-view>
    <watermark />
  </div>
</template>

<script setup>
import Watermark from "@/component/Watermark.vue";
import { useDark, useToggle } from "@vueuse/core";

const isDark = useDark();
useToggle(isDark);
</script>

<style lang="scss" scoped>
:global(html body) {
  max-width: 1440px;
  margin: 0px auto;
}
.blank-layout {
}
</style>
