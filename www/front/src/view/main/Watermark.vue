<template>
  <div class="watermark" v-if="!loading">
    <div class="item" v-for="index in 100">
      <div class="name">{{ data.name + data.id }}</div>
      <div class="time">{{ data.time }}</div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

const data = ref({});
const loading = ref(true);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/Main/getWatermark");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  loading.value = false;
  data.value = response.data;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.watermark {
  pointer-events: none;
  position: absolute;
  left: 0px;
  top: 0px;
  right: 0px;
  bottom: 0px;
  z-index: 3002;
  overflow: hidden;
  .item {
    float: left;
    margin: 50px;
    text-align: center;
    opacity: 0.15;
    transform: rotate(-30deg);
    .name {
      font-size: var(--font-size-big);
    }
  }
}
</style>
