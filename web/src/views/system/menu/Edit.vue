<template>
  department
  <el-dialog
    :model-value="show"
    title="修改菜单"
    width="500"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="menu" :rules="rules" ref="formRef" label-width="120px">
        <el-form-item label="上级菜单" prop="menu_id">
          <el-tree-select
            v-model="menu.menu_id"
            :data="treeMenus"
            :render-after-expand="false"
            show-checkbox
            check-strictly
            placeholder="无"
            clearable
          />
        </el-form-item>
        <el-form-item label="菜单类型" prop="type_id">
          <el-radio-group v-model="menu.type_id">
            <el-radio :label="1">目录</el-radio>
            <el-radio :label="2">页面</el-radio>
            <el-radio :label="3">按钮</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="菜单名称" prop="name">
          <el-input v-model="menu.name" />
        </el-form-item>

        <el-form-item label="路由路径" prop="path" v-if="menu.type_id == 2">
          <el-input v-model="menu.path" />
        </el-form-item>
        <el-form-item label="组件路径" prop="component" v-if="menu.type_id == 2">
          <el-input v-model="menu.component" />
        </el-form-item>
        <el-form-item label="菜单图标" prop="icon" v-if="menu.type_id == 1 || menu.type_id == 2">
          <el-input v-model="menu.icon" />
        </el-form-item>

        <el-form-item label="接口地址" prop="api" v-if="menu.type_id == 2 || menu.type_id == 3">
          <el-input v-model="menu.api" type="textarea" rows="3" />
          <div class="form-message">后端接口网址一行一个，格式：应用/控制器/方法</div>
        </el-form-item>

        <el-form-item label="排序" prop="sort">
          <el-input v-model="menu.sort" type="number" />
        </el-form-item>
        <el-form-item label="菜单显示" prop="show" v-if="menu.type_id == 2">
          <el-radio-group v-model="menu.show">
            <el-radio :label="1">显示</el-radio>
            <el-radio :label="2">隐藏</el-radio>
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
import axios from "@/util/axios";

const props = defineProps(["show", "id"]);
const emits = defineEmits(["hide", "refresh"]);

const menu = ref({});
const formRef = ref();
const rules = {
  type: [{ required: true, message: "请选择菜单类型", trigger: "blur" }],
  name: [{ required: true, message: "请输入菜单名称", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }]
};
const treeMenus = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const res = await axios.get("/admin/system.Menu/initEdit", {
    params: { id: props.id }
  });

  if (res.code != 1) {
    ElMessage({
      message: res.message,
      type: "error"
    });
    return;
  }

  if (res.data.menu.menu_id == "0") {
    res.data.menu.menu_id = "";
  }
  menu.value = res.data.menu;
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
    const res = await axios.post("/admin/system.Menu/saveEdit", menu.value);
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
  padding-right: 50px;
  .el-select {
    width: 100%;
  }
}
</style>
