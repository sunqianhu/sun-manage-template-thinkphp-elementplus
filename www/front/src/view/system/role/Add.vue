<template>
  <el-dialog
    :model-value="open"
    title="添加角色"
    width="500"
    :draggable="true"
    @close="close"
    class="add"
  >
    <el-scrollbar max-height="300px" class="scrollbar">
      <el-form :model="role" :rules="rules" scroll-to-error ref="roleRef" label-width="120px">
        <el-form-item label="角色名称" prop="name">
          <el-input v-model="role.name" />
        </el-form-item>
        <el-form-item label="角色权限" prop="menu_ids">
          <div>
            <el-input v-model="menuFilterText" placeholder="关键词" />
            <el-tree
              :props="{ children: 'children', label: 'name' }"
              :data="menus"
              show-checkbox
              node-key="id"
              :filter-node-method="filterMenu"
              ref="menuRef"
              empty-text="无菜单"
              @check="checkMenu"
            />
          </div>
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
import { ref, watch, onMounted } from "vue";
import axios from "@/helper/axios";

defineProps(["open"]);
const emits = defineEmits(["close", "submited"]);
const role = ref({
  menu_ids: []
});
const roleRef = ref({});
const rules = {
  name: [{ required: true, message: "角色名称不能为空", trigger: "blur" }]
};
const menus = ref([]);
const menuRef = ref(null);
const menuFilterText = ref("");

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/system.Role/initAdd");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  menus.value = response.data;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 过滤菜单节点
 */
const filterMenu = (value, data) => {
  if (value === "") {
    return true;
  }
  return data.name.includes(value);
};

/**
 * 选择菜单
 */
const checkMenu = () => {
  const allKeys = menuRef.value.getCheckedKeys(); //全选中
  const halfKeys = menuRef.value.getHalfCheckedKeys(); //半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.menu_ids = keys;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  await roleRef.value.validate();

  const response = await axios.post("manage/system.Role/saveAdd", role.value);
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

watch(menuFilterText, (value) => {
  menuRef.value?.filter(value);
});

onMounted(() => {
  init();
});
</script>
<style lang="scss" scoped>
.add {
  .scrollbar {
    padding-right: 50px;
  }
}
</style>
