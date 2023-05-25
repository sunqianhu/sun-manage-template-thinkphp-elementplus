<template>
  <el-dialog
    :model-value="show"
    title="修改角色"
    width="500"
    :draggable="true"
    @close="close"
    class="edit"
  >
    <el-scrollbar class="scrollbar" v-loading="loading">
      <el-form :model="role" :rules="rules" ref="formRef" label-width="120px">
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
              :default-checked-keys="menuDefaultCheckKeys"
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
import axios from "@/util/axios";

const props = defineProps(["show", "id"]);
const emits = defineEmits(["hide"]);
const role = ref({
  menu_ids: []
});
const formRef = ref();
const rules = {
  name: [{ required: true, message: "请输入角色名称", trigger: "blur" }]
};
const menus = ref([]);
const menuRef = ref(null);
const menuFilterText = ref("");
const loading = ref(true);
const menuDefaultCheckKeys = ref([]);

/**
 * 初始化
 */
const init = async () => {
  const res = await axios.get("admin/system.Role/initEdit", {
    params: { id: props.id }
  });
  if (res.code != 1) {
    ElMessage({
      message: res.message,
      type: "error"
    });
    return;
  }

  menus.value = res.data.menus;
  role.value = res.data.role;

  setTimeout(() => {
    menuDefaultCheckKeys.value = getMenuDefaultCheckKeys(res.data.role.menu_ids);
    loading.value = false;
  }, 800);
};

/**
 * 关闭
 */
const close = () => {
  emits("hide", false);
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
 * 得到菜单默认选中的key(排除父节点)
 * @param {array} menuIds
 */
const getMenuDefaultCheckKeys = (menuIds) => {
  let finalMenuIds = [];
  let i;
  let menuId = 0;
  let node;

  for (i in menuIds) {
    menuId = menuIds[i];
    node = menuRef.value.getNode(menuId);
    if (!node) {
      continue;
    }

    if (!node.childNodes || !node.childNodes.length) {
      finalMenuIds.push(menuId);
    }
  }
  return finalMenuIds;
};

/**
 * 选择菜单
 */
const checkMenu = () => {
  const allKeys = menuRef.value.getCheckedKeys(); // 全选中
  const halfKeys = menuRef.value.getHalfCheckedKeys(); // 半选中
  const keys = [...allKeys, ...halfKeys];
  role.value.menu_ids = keys;
};

/**
 * 提交表单
 */
const submitForm = () => {
  formRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const res = await axios.post("admin/system.Role/saveEdit", role.value);
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

watch(menuFilterText, (value) => {
  menuRef.value?.filter(value);
});

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
