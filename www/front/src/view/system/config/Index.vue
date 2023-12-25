<template>
  <div class="index" v-loading="pageLoading">
    <div class="page-name">系统设置</div>
    <el-form :model="config" label-width="130px" ref="configRef" class="form">
      <el-form-item label="版本号" prop="version">
        <el-input v-model="config.version" />
      </el-form-item>
      <div class="submit-wrap">
        <el-button type="primary" class="button" @click="submitForm" :loading="buttonLoading">
          保存
        </el-button>
      </div>
    </el-form>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";

const configRef = ref({});
const config = ref({});
const pageLoading = ref(true);
const buttonLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/system.Config/init");
  pageLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  config.value = response.data.config;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await configRef.value.validate();

  buttonLoading.value = true;
  let response;
  try {
    response = await axios.post("manage/system.Config/save", config.value);
  } catch (error) {
    buttonLoading.value = false;
    return;
  }
  buttonLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  ElMessage({
    message: response.message,
    type: "success"
  });
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-panel);
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-name {
    font-size: 20px;
    font-weight: bold;
  }
  .form {
    width: 500px;
    margin-top: 16px;
    .el-select {
      width: 100%;
    }
    .submit-wrap {
      padding-left: 130px;
    }
  }
}
</style>
