<template>
  <el-dialog :model-value="show" title="修改用户" width="500" :draggable="true" @close="close">
    <el-scrollbar max-height="300px" class="page-edit">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
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
            <el-option v-for="role in roles" :label="role.name" :value="role.id.toString()" />
          </el-select>
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

const props = defineProps(["show", "id"]);
const emits = defineEmits(["hide"]);

const form = ref({});
const formRef = ref();
const rules = {
  name: [{ required: true, message: "请输入姓名", trigger: "blur" }],
  phone: [{ required: true, message: "请输入手机号码", trigger: "blur" }],
  department_id: [{ required: true, message: "请选择所属部门", trigger: "blur" }]
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

  res = await axios.get("/pc/system.user/editInit", {
    params: { id: props.id }
  });
  if (res.code != 0) {
    ElMessage({
      message: res.message,
      type: "error"
    });
    return;
  }
  form.value = res.data;
};
init();

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

    const res = await axios.post("/pc/system.user/editSave", form.value);
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
.page-edit {
  padding-right: 50px;
  .el-select {
    width: 100%;
  }
}
.dialog-footer button:first-child {
  margin-right: 10px;
}
</style>
