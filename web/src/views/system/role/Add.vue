<template>
  <el-dialog
    :model-value="show"
    title="添加角色"
    width="500"
    :draggable="true"
    @close="close"
    class="add"
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
import { ref } from "vue";
import axios from "@/util/axios";

defineProps(["show"]);
const emits = defineEmits(["hide"]);

const role = ref({
  sort: 1
});
const formRef = ref({});
const rules = {
  name: [{ required: true, message: "请输入角色名称", trigger: "blur" }]
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

    const res = await axios.post("/admin/system.Role/saveAdd", role.value);
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
.add {
  .scrollbar {
    padding-right: 50px;
  }
}
</style>
