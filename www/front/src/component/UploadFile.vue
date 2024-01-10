<template>
  <el-upload
    ref="uploadFileRef"
    action="/api/manage/UploadFile/upload"
    v-model:file-list="files"
    :name="props.name"
    :headers="headers"
    :multiple="props.multiple"
    :accept="props.accept"
    :limit="props.limit"
    :disabled="props.disabled"
    :data="data"
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
import { ref, onMounted, watch } from "vue";

const props = defineProps({
  files: {
    type: Array,
    default: []
  },
  modelValue: {
    type: Array,
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
  accept: {
    type: Array,
    default: ""
  },
  disabled: {
    type: Boolean,
    default: false
  },
  limit: {
    type: Number,
    default: 10
  },
  module: {
    type: String,
    default: "file"
  }
});
const emits = defineEmits(["update:modelValue"]);
const headers = { token: localStorage.getItem("token") };
const files = ref([]);
const data = {
  module: props.module
};
const uploadFileRef = ref(null);

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
    uploadFileRef.value.handleRemove(uploadFile);
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
  ElMessage({
    message: "最多上传" + props.limit + "个文件",
    type: "error"
  });
};

/**
 * 得到文件集合
 */
const getFiles = () => {
  const fileValues = files.value;
  let fileValue = {};
  let finalFiles = [];

  if (fileValues.length == 0) {
    return finalFiles;
  }

  for (fileValue of fileValues) {
    if (fileValue.response) {
      finalFiles.push(fileValue.response.data);
      continue;
    }

    finalFiles.push(fileValue);
  }

  return finalFiles;
};

/**
 * 侦听props
 */
watch(
  () => props.modelValue,
  (newModelValue) => {
    init();
  },
  {
    deep: true
  }
);

onMounted(() => {
  init();
});
</script>

<style scoped></style>
