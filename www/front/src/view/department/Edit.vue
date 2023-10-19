<template>
  <el-dialog
    :model-value="open"
    title="修改部门"
    width="500"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="department" :rules="rules" ref="departmentRef" label-width="120px">
        <el-form-item label="所属部门">
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
          <el-input type="number" v-model="department.sort" />
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

const props = defineProps(["open", "id"]);
const emits = defineEmits(["close"]);
const department = ref({});
const departmentRef = ref();
const rules = {
  name: [{ required: true, message: "部门名称不能为空", trigger: "blur" }],
  sort: [{ required: true, message: "排序不能为空", trigger: "blur" }]
};
const treeDepartments = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/Department/initEdit", {
    params: { id: props.id }
  });
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  treeDepartments.value = response.data.treeDepartments;
  if (response.data.department.department_id == "0") {
    response.data.department.department_id = "";
  }
  department.value = response.data.department;
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
  departmentRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const response = await axios.post("manage/Department/saveEdit", department.value);
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
.edit {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
}
</style>
