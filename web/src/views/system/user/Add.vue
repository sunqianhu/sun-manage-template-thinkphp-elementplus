<template>
  <el-dialog :model-value="show" title="添加用户" width="550" :draggable="true" @close="close">
    <el-scrollbar max-height="300px" class="page-add">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
        <el-form-item label="账号" prop="account">
          <el-input v-model="form.account" autocomplete="off" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="form.password" autocomplete="off" show-password />
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="手机号码" prop="phone">
          <el-input v-model="form.phone" />
        </el-form-item>
        <el-form-item label="所属部门" prop="department_id">
          <el-tree-select
            v-model="form.department_id"
            :data="departments"
            :render-after-expand="false"
            check-strictly
          />
        </el-form-item>
        <el-form-item label="角色">
          <el-select v-model="form.role_ids" multiple collapse-tags collapse-tags-tooltip>
            <el-option v-for="role in roles" :label="role.name" :value="role.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio label="1">启用</el-radio>
            <el-radio label="2">停用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
    </el-scrollbar>
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

defineProps(["show"]);
const emits = defineEmits(["hide", "refresh"]);

const form = ref({
  status: "1"
});
const formRef = ref();
const rules = {
  account: [{ required: true, message: "请输入账号", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }],
  name: [{ required: true, message: "请输入姓名", trigger: "blur" }],
  phone: [{ required: true, message: "请输入手机号码", trigger: "blur" }],
  department_id: [{ required: true, message: "请选择所属部门", trigger: "blur" }],
  status: [{ required: true, message: "请选择状态", trigger: "blur" }]
};

const departments = ref([]);
const roles = ref([]);
const init = async () => {
  let res = await axios.get("/pc/system.user/getDepartmentSelect");
  departments.value = res.data;

  res = await axios.get("/pc/system.user/getRoleSelect");
  if (res.code != 0) {
    ElMessage({
      message: res.message,
      type: "error"
    });
    return;
  }

  roles.value = res.data;
};
init();

const close = () => {
  emits("hide", false);
};

const submit = () => {
  formRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const res = await axios.post("/pc/system.user/addSave", form.value);
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
.page-add {
  padding-right: 50px;
  .el-select {
    width: 100%;
  }
}
.dialog-footer button:first-child {
  margin-right: 10px;
}
</style>
