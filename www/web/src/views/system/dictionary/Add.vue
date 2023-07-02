<template>
  <el-dialog
    :model-value="open"
    title="添加字典"
    width="500"
    :draggable="true"
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="dictionary" :rules="rules" ref="dictionaryRef" label-width="120px">
        <el-form-item label="字典类型" prop="type">
          <el-input v-model="dictionary.type" />
        </el-form-item>
        <el-form-item label="字典键" prop="name">
          <el-input v-model="dictionary.key" />
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

defineProps(["open"]);
const emits = defineEmits(["close"]);
const dictionary = ref({
  sort: 1
});
const dictionaryRef = ref({});
const rules = {
  type: [{ required: true, message: "请输入字典类型", trigger: "blur" }],
  key: [{ required: true, message: "请输入字典键", trigger: "blur" }],
  value: [{ required: true, message: "请输入字典值", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }]
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
  dictionaryRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const response = await axios.post("admin/Dictionary/saveAdd", dictionary.value);
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
</script>
<style lang="scss" scoped>
.add {
  .scrollbar {
    padding-right: 50px;
  }
}
</style>
