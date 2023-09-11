<template>
  <el-dialog
    :model-value="open"
    title="修改字典"
    width="500"
    :draggable="true"
    @close="close"
    class="edit"
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
          <el-input type="number" v-model="dictionary.sort" />
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

const props = defineProps(["open", "id"]);
const emits = defineEmits(["close"]);
const dictionary = ref({});
const dictionaryRef = ref();
const rules = {
  type: [{ required: true, message: "请输入字典类型", trigger: "blur" }],
  key: [{ required: true, message: "请输入字典键", trigger: "blur" }],
  value: [{ required: true, message: "请输入字典值", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }]
};

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("admin/Dictionary/initEdit", {
    params: { id: props.id }
  });
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  dictionary.value = response.data;
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

    const response = await axios.post("admin/Dictionary/saveEdit", dictionary.value);
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
