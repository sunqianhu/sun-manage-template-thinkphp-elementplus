<template>
  <el-dialog
    :model-value="show"
    title="添加部门"
    width="500"
    :draggable="true"
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="department" :rules="rules" ref="departmentRef" label-width="120px">
        <el-form-item label="上级部门">
          <el-tree-select
            v-model="department.department_id"
            :data="treeDepartments"
            :render-after-expand="false"
            show-checkbox
            check-strictly
            placeholder="无"
            clearable
          />
        </el-form-item>
        <el-form-item label="部门名称" prop="name">
          <el-input v-model="department.name" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="department.sort" type="number" />
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
import axios from "@/util/axios";

defineProps(["show"]);
const emits = defineEmits(["hide"]);

const department = ref({
  sort: 1
});
const departmentRef = ref({});
const rules = {
  name: [{ required: true, message: "请输入部门名称", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }]
};
const treeDepartments = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("admin/department/initAdd");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  treeDepartments.value = response.data;
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
  departmentRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const response = await axios.post("admin/Department/saveAdd", department.value);
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
    emits("hide", false);
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
