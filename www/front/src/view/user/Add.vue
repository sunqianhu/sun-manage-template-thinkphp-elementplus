<template>
  <el-dialog
    :model-value="open"
    title="添加用户"
    width="550"
    :draggable="true"
    @close="close"
    class="add"
    v-load
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="user" :rules="rules" ref="userRef" label-width="120px">
        <el-form-item label="账号" prop="account">
          <el-input v-model="user.account" autocomplete="off" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input type="password" v-model="user.password" autocomplete="off" show-password />
        </el-form-item>
        <el-form-item label="姓名" prop="name">
          <el-input v-model="user.name" />
        </el-form-item>
        <el-form-item label="手机号码" prop="phone">
          <el-input v-model="user.phone" />
        </el-form-item>
        <el-form-item label="所属部门" prop="department_id">
          <el-tree-select
            v-model="user.department_id"
            :data="departments"
            :render-after-expand="false"
            check-strictly
          />
        </el-form-item>
        <el-form-item label="角色">
          <el-select v-model="user.role_ids" multiple collapse-tags collapse-tags-tooltip>
            <el-option v-for="role in roles" :label="role.name" :value="role.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态" prop="status_id">
          <el-radio-group v-model="user.status_id">
            <el-radio label="1">启用</el-radio>
            <el-radio label="2">停用</el-radio>
          </el-radio-group>
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" @click="submitForm"> 提交 </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";

defineProps(["open"]);
const emits = defineEmits(["close", "refresh"]);

const user = ref({
  status_id: "1"
});
const userRef = ref();
const rules = {
  account: [{ required: true, message: "账号不能为空", trigger: "blur" }],
  password: [{ required: true, message: "密码不能为空", trigger: "blur" }],
  name: [{ required: true, message: "姓名不能为空", trigger: "blur" }],
  phone: [{ required: true, message: "手机号码不能为空", trigger: "blur" }],
  department_id: [{ required: true, message: "所属部门还未选择", trigger: "blur" }],
  status_id: [{ required: true, message: "状态还未选择", trigger: "blur" }]
};
const departments = ref([]);
const roles = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/User/initAdd");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  departments.value = response.data.departments;
  roles.value = response.data.roles;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 提交表单
 */
const submitForm = () => {
  userRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const response = await axios.post("manage/user/saveAdd", user.value);
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
    emits("close", true);
    emits("refresh", true);
  });
};

onMounted(() => {
  init();
});
</script>
<style lang="scss" scoped>
.add {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
}
</style>
