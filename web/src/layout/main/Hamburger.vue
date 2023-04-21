<template>
  <div class="hamburger" @click="toggleSider">
    <Fold class="icon" v-if="siderState" />
    <Expand class="icon" v-if="!siderState" />
  </div>
</template>

<script setup>
import { computed } from "vue";
// import { useStore } from "vuex";
import { Fold, Expand } from "@element-plus/icons-vue";

//const store = useStore();

// 侧边状态
// const siderState = computed(() => {
//   return store.getters.sider;
// });

// // 切换侧边
// const toggleSider = () => {
//   store.commit("toggleSider");
// };
</script>

<style lang="scss" scoped>
.hamburger {
  display: flex;
  height: 60px;
  padding: 0px 16px;
  cursor: pointer;
  align-items: center;
  .icon {
    width: 25px;
    height: 25px;
  }
  &:hover {
    background: rgba(0, 0, 0, 0.025);
  }
}
</style>
