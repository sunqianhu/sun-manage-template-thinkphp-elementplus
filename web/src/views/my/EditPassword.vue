<template>
  <el-dialog :model-value="show" title="修改密码" width="500" :draggable="true" @close="close">
    <div class="edit-password">
      <el-form :model="user" :rules="rules" ref="formRef" label-width="120px">
        <el-form-item label="新密码" prop="password1">
          <el-input type="password" show-password v-model="user.password1" />
        </el-form-item>
        <el-form-item label="确认新密码" prop="password2">
          <el-input type="password" show-password v-model="user.password2" />
        </el-form-item>
      </el-form>
    </div>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" @click="submitForm"> 提交 </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/util/axios";

const props = defineProps(["show"]);
const emits = defineEmits(["hide"]);
const user = ref({});
const formRef = ref();
const rules = {
  password1: [{ required: true, message: "请输入新密码", trigger: "blur" }],
  password2: [{ required: true, message: "请输入确认新密码", trigger: "blur" }]
};

/**
 * 关闭
 */
const close = () => {
  emits("hide", false);
};

/**
 * 提交表单
 */
const submitForm = () => {
  formRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const res = await axios.post("admin/my/editPassword", user.value);
    if (res.code != 1) {
      ElMessage({
        message: res.message,
        type: "error"
      });
      return;
    }

    ElMessage({
      message: res.message,
      type: "success"
    });
    emits("hide", false);
    emits("refresh", true);
  });
};
</script>
<style lang="scss" scoped>
.edit-password {
  padding-right: 50px;
}
</style>
