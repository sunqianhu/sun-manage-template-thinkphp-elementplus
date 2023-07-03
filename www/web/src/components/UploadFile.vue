<template>
  <el-upload
    ref="uploadRef"
    action="/api/admin/UploadFile/uploadFile"
    v-model:file-list="files"
    :name="props.name"
    :headers="headers"
    :multiple="props.multiple"
    :disabled="props.disabled"
    :limit="props.limit"
    :on-success="success"
    :on-remove="remove"
    :on-change="change"
    :on-exceed="exceed"
  >
    <template #default>
      <slot></slot>
    </template>
    <template #tip>
      <slot name="tip"></slot>
    </template>
  </el-upload>
</template>

<script setup>
import { ref, onMounted } from "vue";

const props = defineProps({
  modelValue: {
    default: []
  },
  name: {
    type: String,
    default: "file"
  },
  multiple: {
    type: Boolean,
    default: false
  },
  disabled: {
    type: Boolean,
    default: false
  },
  limit: {
    type: Number,
    default: 4
  }
});
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
 * 改变
 * @param {*} file
 * @param {*} uploadFiles
 */
const change = (uploadFile, uploadFiles) => {
  emits("update:modelValue", getFiles());
};

/**
 * 超出限制
 * @param {Array} files 超出限制的文件
 * @param {Array} uploadFiles 已上传的文件
 */
const exceed = (files, uploadFiles) => {
  let totalNumber = files.length + uploadFiles.length;
  let exceedNumber = totalNumber - props.limit;
  ElMessage({
    message: "最多上传" + props.limit + "个文件，超出" + exceedNumber + "个，请重新选择",
    type: "error"
  });
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
