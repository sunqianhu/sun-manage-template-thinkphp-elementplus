<template>
  <el-dialog
    :model-value="show"
    title="修改角色"
    width="500"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar class="scrollbar">
      <el-form :model="role" :rules="rules" ref="formRef" label-width="120px">
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="role.name" />
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

const props = defineProps(["show", "id"]);
const emits = defineEmits(["hide"]);
const role = ref({});
const formRef = ref();
const rules = {
  type: [{ required: true, message: "请输入角色类型", trigger: "blur" }],
  name: [{ required: true, message: "请输入角色名称", trigger: "blur" }],
  value: [{ required: true, message: "请输入角色值", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }]
};

/**
 * 初始化
 */
const init = async () => {
  const res = await axios.get("/admin/system.Role/initEdit", {
    params: { id: props.id }
  });
  if (res.code != 1) {
    ElMessage({
      message: res.message,
      type: "error"
    });
    return;
  }
  role.value = res.data;
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

    const res = await axios.post("/admin/system.Role/saveEdit", role.value);
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
