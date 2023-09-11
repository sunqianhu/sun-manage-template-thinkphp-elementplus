<template>
  <div class="index">
    <div class="page-name">菜单管理</div>
    <div class="search">
      <el-form :model="query">
        <el-row :gutter="16">
          <el-col :md="8" :sm="24">
            <el-form-item label="菜单名称">
              <el-input v-model="query.name" />
            </el-form-item>
          </el-col>
          <el-col :md="8" :sm="24">
            <el-button type="primary" :icon="Search" @click="search">查询</el-button>
          </el-col>
        </el-row>
      </el-form>
    </div>

    <div class="tool">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>

    <div class="list">
      <el-table
        :data="menus"
        v-loading="loading"
        row-key="id"
        default-expand-all
        style="width: 100%"
      >
        <el-table-column prop="name" label="菜单名称" />
        <el-table-column prop="key" label="菜单key" />
        <el-table-column v-slot="{ row }" prop="type_id" label="菜单类型" width="100">
          <TypeTag :type="row.type_id"></TypeTag>
        </el-table-column>
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column v-slot="{ row }" label="操作" fixed="right" width="140">
          <el-button size="small" @click="openEdit(row.id)">修改</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="del(row.id)">
            <template #reference>
              <el-button size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </el-table-column>
      </el-table>
    </div>

    <Add :open="addFlag" @close="addFlag = false" @refresh="getMenus" v-if="addFlag"></Add>
    <Edit
      :open="editFlag"
      @close="editFlag = false"
      @refresh="getMenus"
      :id="rowId"
      v-if="editFlag"
    ></Edit>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search, Plus } from "@element-plus/icons-vue";
import axios from "@/util/axios";
import Add from "./Add.vue";
import Edit from "./Edit.vue";
import TypeTag from "./TypeTag.vue";

const rowId = ref(0);
const query = ref({});
const menus = ref([]);
const loading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);

/**
 * 得到菜单
 */
const getMenus = async () => {
  loading.value = true;
  const response = await axios.get("manage/Menu/getIndexMenus", {
    params: query.value
  });
  loading.value = false;
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
 * 搜索
 */
const search = () => {
  getMenus();
};

/**
 * 打开添加页面
 */
const openAdd = () => {
  addFlag.value = true;
};

/**
 * 打开修改
 */
const openEdit = (id) => {
  editFlag.value = true;
  rowId.value = id;
};

/**
 * 删除
 * @param {number} id
 */
const del = async (id) => {
  const response = await axios.post("manage/Menu/delete", {
    id: id
  });
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
  getMenus();
};

onMounted(() => {
  getMenus();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: #ffffff;
  padding: 16px;
  border-radius: var(--border-radius);
  .page-name {
    font-size: 20px;
    font-weight: bold;
  }
  .search {
    margin-top: 16px;
  }

  .toolbar {
  }

  .list {
    margin-top: 16px;
    ::v-deep(th.el-table__cell) {
      background-color: var(--fill-color);
    }
  }
}
</style>
