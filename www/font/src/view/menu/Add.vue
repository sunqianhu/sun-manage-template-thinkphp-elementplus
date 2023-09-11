<template>
  <el-dialog
    :model-value="open"
    title="添加菜单"
    width="500"
    :draggable="true"
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="menu" :rules="rules" ref="menuRef" label-width="120px">
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
        <el-form-item label="菜单图标" prop="icon" v-if="menu.type_id == 1 || menu.type_id == 2">
          <el-input v-model="menu.icon" />
          <div class="form-message">elementplus图标组件名</div>
        </el-form-item>

        <el-form-item label="接口地址" prop="api" v-if="menu.type_id == 2 || menu.type_id == 3">
          <el-input v-model="menu.api" type="textarea" rows="3" />
          <div class="form-message">后端接口网址一行一个，格式：/应用/控制器/方法</div>
        </el-form-item>

        <el-form-item label="排序" prop="sort">
          <el-input v-model="menu.sort" type="number" />
        </el-form-item>
        <el-form-item label="菜单显示" prop="show" v-if="menu.type_id == 1 || menu.type_id == 2">
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

defineProps(["open"]);
const emits = defineEmits(["close", "refresh"]);

const menu = ref({
  type_id: 1,
  sort: 1,
  show: 1
});
const menuRef = ref();
const rules = {
  type_id: [{ required: true, message: "请选择菜单类型", trigger: "blur" }],
  name: [{ required: true, message: "请输入菜单名称", trigger: "blur" }],
  key: [{ required: true, message: "请输入菜单key", trigger: "blur" }],
  sort: [{ required: true, message: "请输入排序", trigger: "blur" }]
};
const treeMenus = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("admin/Menu/initAdd");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  treeMenus.value = response.data.treeMenus;
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
  menuRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const response = await axios.post("admin/Menu/saveAdd", menu.value);
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
.add {
  .scrollbar {
    padding-right: 50px;
    .el-select {
      width: 100%;
    }
  }
}
</style>
