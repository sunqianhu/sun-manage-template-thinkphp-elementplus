<template>
  <el-dialog
    :model-value="show"
    title="修改部门"
    width="500"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
        <el-form-item label="所属部门">
          <el-tree-select
            v-model="form.parent_id"
            :data="treeDepartments"
            :render-after-expand="false"
            show-checkbox
            check-strictly
            placeholder="无"
            clearable
          />
        </el-form-item>
        <el-form-item label="部门名称" prop="name">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input type="number" v-model="form.sort" />
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <span class="footer">
        <el-button @click="close">取消</el-button>
        <el-button type="primary" @click="submitForm"> 提交 </el-button>
      </span>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/util/axios";

const props = defineProps(["show", "id"]);
const emits = defineEmits(["hide"]);
const form = ref({});
const formRef = ref();
const rules = {
  name: [{ required: true, message: "请输入部门名称", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }],
};
const treeDepartments = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const res = await axios.get("/admin/system.department/initEdit", {
    params: { id: props.id },
  });
  if (res.code != 1) {
    ElMessage({
      message: res.message,
      type: "error",
    });
    return;
  }
  treeDepartments.value = res.data.treeDepartments;
  if (res.data.department.parent_id == "0") {
    res.data.department.parent_id = "";
  }
  form.value = res.data.department;
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

    const res = await axios.post(
      "/admin/system.department/saveEdit",
      form.value
    );
    if (res.code != 1) {
      ElMessage({
        message: res.message,
        type: "error",
      });
      return;
    }

    ElMessage({
      message: res.message,
      type: "success",
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
