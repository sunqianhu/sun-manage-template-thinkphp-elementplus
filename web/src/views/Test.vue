<template>
  <div>
    <UploadFile v-model="files" multiple>
      <el-button type="primary">上传</el-button>
      <template #tip>
        <div>提示提示ddd</div>
      </template>
    </UploadFile>
  </div>
</template>

<script setup>
import { ref } from "vue";
import UploadFile from "../component/UploadFile.vue";

const files = ref([
  {
    name: "2.jpg",
    type: "image/jpeg",
    ext: "jpg",
    size: 255784,
    path: "20230608\\68e85627f9d652fd9308de7cadbed4e4.jpg"
  },
  {
    name: "3.jpg",
    type: "image/jpeg",
    ext: "jpg",
    size: 255784,
    path: "20230608\\68e85627f9d652fd9308de7cadbed4e4.jpg"
  }
]);

setInterval(() => {
  //console.log(files);
}, 8000);
</script>

<style scoped></style>
