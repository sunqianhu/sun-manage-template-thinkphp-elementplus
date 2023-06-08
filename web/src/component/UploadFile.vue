<template>
  <el-upload
    ref="uploadRef"
    action="/api/admin/UploadFile/uploadFile"
    v-model:file-list="files"
    :headers="headers"
    multiple
    name="file"
    :on-success="success"
    :on-remove="remove"
  >
    <el-button type="primary">上传</el-button>
  </el-upload>
</template>

<script setup>
import { ref, onMounted } from "vue";

const props = defineProps(["modelValue"]);
const emits = defineEmits(["update:modelValue"]);

const headers = { token: localStorage.getItem("token") };
const files = ref([]);
const uploadRef = ref(null);

/**
 * 初始化
 */
const init = () => {
  files.value = props.modelValue;
};

/**
 * 上传成功
 * @param {*} response
 * @param {*} uploadFile
 * @param {*} uploadFiles
 */
const success = (response, uploadFile, uploadFiles) => {
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    uploadRef.value.handleRemove(uploadFile);
    return;
  }

  emits("update:modelValue", getFiles());
};

/**
 * 删除文件
 * @param {*} file
 * @param {*} uploadFiles
 */
const remove = (uploadFile, uploadFiles) => {
  emits("update:modelValue", getFiles());
};

/**
 * 得到文件
 */
const getFiles = () => {
  const dataFiles = files.value;
  if (dataFiles.length == 0) {
    return [];
  }

  let index = 0;
  let vmodelFiles = [];
  let dataFile = {};

  for (index in dataFiles) {
    dataFile = dataFiles[index];

    if (dataFile.response) {
      vmodelFiles.push(dataFile.response.data);
      continue;
    }

    vmodelFiles.push(dataFile);
  }

  return vmodelFiles;
};

onMounted(() => {
  init();
});
</script>

<style scoped></style>
