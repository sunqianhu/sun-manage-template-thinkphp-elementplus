<template>
  <el-dialog
    :model-value="show"
    title="添加字典"
    width="500"
    :draggable="true"
    @close="close"
    class="add"
  >
    <el-scrollbar class="scrollbar">
      <el-form :model="dictionary" :rules="rules" ref="formRef" label-width="120px">
        <el-form-item label="字典类型" prop="type">
          <el-input v-model="dictionary.type" />
        </el-form-item>
        <el-form-item label="字典名称" prop="name">
          <el-input v-model="dictionary.name" />
        </el-form-item>
        <el-form-item label="字典值" prop="value">
          <el-input v-model="dictionary.value" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="dictionary.sort" type="number" />
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

const dictionary = ref({
  sort: 1
});
const formRef = ref({});
const rules = {
  type: [{ required: true, message: "请输入字典类型", trigger: "blur" }],
  name: [{ required: true, message: "请输入字典名称", trigger: "blur" }],
  value: [{ required: true, message: "请输入字典值", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }]
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

    const res = await axios.post("admin/system.Dictionary/saveAdd", dictionary.value);
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
