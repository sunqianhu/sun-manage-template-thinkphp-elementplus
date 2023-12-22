<template>
  department
  <el-dialog
    :model-value="open"
    title="修改菜单"
    width="600"
    :draggable="true"
    align-center
    @close="close"
    class="edit"
  >
    <el-scrollbar max-height="300px" class="scrollbar" v-loading="pageLoading">
      <el-form :model="menu" :rules="rules" scroll-to-error ref="menuRef" label-width="120px">
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
            <el-radio v-for="type in types" :key="type.key" :label="parseInt(type.key)">
              {{ type.value }}
            </el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="菜单名称" prop="name">
          <el-input v-model="menu.name" />
        </el-form-item>
        <el-form-item label="菜单key" prop="key">
          <el-input v-model="menu.key" />
          <div class="form-message">菜单的唯一标识，用于前端路由名称和权限指令标识</div>
        </el-form-item>
        <el-form-item label="路由路径" prop="path" v-if="menu.type_id == 2">
          <el-input v-model="menu.path" />
          <div class="form-message">例如/system/user</div>
        </el-form-item>
        <el-form-item label="组件路径" prop="component" v-if="menu.type_id == 2">
          <el-input v-model="menu.component" />
          <div class="form-message">相对于view目录</div>
        </el-form-item>
        <el-form-item
          label="菜单图标"
          prop="icon"
          v-if="menu.type_id == 1 || menu.type_id == 2 || menu.type_id == 4"
        >
          <el-input v-model="menu.icon" />
          <div class="form-message">elementplus图标组件名</div>
        </el-form-item>
        <el-form-item label="接口地址" prop="api" v-if="menu.type_id == 2 || menu.type_id == 3">
          <el-input v-model="menu.api" type="textarea" rows="3" />
          <div class="form-message">后端接口网址一行一个，格式：应用/控制器/方法</div>
        </el-form-item>
        <el-form-item label="链接网址" prop="url" v-if="menu.type_id == 4">
          <el-input v-model="menu.url" />
        </el-form-item>
        <el-form-item label="页面布局" prop="layout" v-if="menu.type_id == 2">
          <el-select v-model="menu.layout" clearable>
            <el-option v-for="layout in layouts" :label="layout.value" :value="layout.key" />
          </el-select>
        </el-form-item>
        <el-form-item label="保活" prop="keep_alive" v-if="menu.type_id == 2">
          <el-radio-group v-model="menu.keep_alive">
            <el-radio :label="1">是</el-radio>
            <el-radio :label="2">否</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item
          label="菜单显示"
          prop="show"
          v-if="menu.type_id == 1 || menu.type_id == 2 || menu.type_id == 4"
        >
          <el-radio-group v-model="menu.show">
            <el-radio :label="1">显示</el-radio>
            <el-radio :label="2">隐藏</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input v-model="menu.sort" type="number" />
        </el-form-item>
      </el-form>
    </el-scrollbar>
    <template #footer>
      <el-button @click="close">取消</el-button>
      <el-button type="primary" @click="submitForm" :loading="buttonLoading"> 提交 </el-button>
    </template>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted, nextTick } from "vue";
import axios from "@/helper/axios";

const props = defineProps(["open", "id"]);
const emits = defineEmits(["close", "submited"]);
const menu = ref({});
const menuRef = ref();
const rules = {
  type: [{ required: true, message: "菜单类型不能为空", trigger: "blur" }],
  name: [{ required: true, message: "菜单名称不能为空", trigger: "blur" }],
  key: [{ required: true, message: "菜单key不能为空", trigger: "blur" }],
  sort: [{ required: true, message: "排序不能为空", trigger: "blur" }]
};
const treeMenus = ref([]);
const types = ref([]);
const layouts = ref([]);
const pageLoading = ref(true);
const buttonLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  pageLoading.value = true;
  const response = await axios.get("manage/system.Menu/initEdit", {
    params: { id: props.id }
  });
  pageLoading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  treeMenus.value = response.data.tree_menus;
  types.value = response.data.types;
  layouts.value = response.data.layouts;
  await nextTick();

  if (response.data.menu.menu_id == "0") {
    response.data.menu.menu_id = "";
  }
  menu.value = response.data.menu;
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
const submitForm = async () => {
  await menuRef.value.validate();

  buttonLoading.value = true;
  let response;
  try {
    response = await axios.post("manage/system.Menu/saveEdit", menu.value);
  } catch (error) {
    buttonLoading.value = false;
    return;
  }
  buttonLoading.value = false;
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
  emits("submited", true);
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
