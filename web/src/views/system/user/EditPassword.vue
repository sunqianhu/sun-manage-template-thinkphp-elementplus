<template>
  <el-dialog :model-value="show" title="修改密码" width="500" :draggable="true" @close="close">
    <div class="page-edit-password">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
        <el-form-item label="新密码" prop="password1">
          <el-input type="password" show-password v-model="form.password1" />
        </el-form-item>
        <el-form-item label="确认新密码" prop="password2">
          <el-input type="password" show-password v-model="form.password2" />
        </el-form-item>
      </el-form>
    </div>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="submit"> 提交 </el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref } from "vue";
import axios from "@/utils/axios";

const props = defineProps(["show", "id"]);
const emits = defineEmits(["hide"]);

const form = ref({});
const formRef = ref();
const rules = {
  password1: [{ required: true, message: "请输入新密码", trigger: "blur" }],
  password2: [{ required: true, message: "请输入确认新密码", trigger: "blur" }]
};

// 关闭
const close = () => {
  emits("hide", false);
};

// 提交
const submit = () => {
  formRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const data = {
      id: props.id,
      status: form.value.status ? 1 : 2
    };
    const res = await axios.post("/pc/system.user/editPassword", data);
    if (res.code != 0) {
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
.page-edit-password {
  padding-right: 50px;
  .el-select {
    width: 100%;
  }
}
.dialog-footer button:first-child {
  margin-right: 10px;
}
</style>
