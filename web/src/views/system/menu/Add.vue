<template>
  <el-dialog
    :model-value="show"
    title="添加菜单"
    width="500"
    :draggable="true"
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px">
        <el-form-item label="上级菜单" prop="parent_id">
          <el-tree-select
            v-model="form.parent_id"
            :data="treeMenus"
            :render-after-expand="false"
            show-checkbox
            check-strictly
            placeholder="无"
            clearable
          />
        </el-form-item>
        <el-form-item label="菜单类型" prop="type_id">
          <el-radio-group v-model="form.type_id">
            <el-radio :label="1">目录</el-radio>
            <el-radio :label="2">页面</el-radio>
            <el-radio :label="3">按钮</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="菜单名称" prop="name">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="菜单图标" prop="icon">
          <el-input v-model="form.icon" />
        </el-form-item>
        <el-form-item label="路由路径" prop="component">
          <el-input v-model="form.component" />
        </el-form-item>
        <el-form-item label="组件路径" prop="path">
          <el-input v-model="form.path" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="form.sort" type="number" />
        </el-form-item>
        <el-form-item label="菜单显示" prop="show">
          <el-radio-group v-model="form.show">
            <el-radio :label="1">显示</el-radio>
            <el-radio :label="2">隐藏</el-radio>
          </el-radio-group>
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

defineProps(["show"]);
const emits = defineEmits(["hide", "refresh"]);

const form = ref({
  sort: 1,
  show: 1,
});
const formRef = ref();
const rules = {
  type_id: [{ required: true, message: "请选择菜单类型", trigger: "blur" }],
  name: [{ required: true, message: "请输入菜单名称", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }],
};
const treeMenus = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const res = await axios.get("/admin/system.menu/initAdd");
  treeMenus.value = res.data.treeMenus;
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

    const res = await axios.post("/admin/system.menu/saveAdd", form.value);
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
.add {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
  .footer button:first-child {
    margin-right: 10px;
  }
}
</style>
