<template>
  <div class="index">
    <div class="page-name">部门管理</div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="部门名称">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search">搜索</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="toolbar">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>

    <div class="list">
      <el-table
        :data="departments"
        v-loading="loading"
        row-key="id"
        default-expand-all
        style="width: 100%"
      >
        <el-table-column prop="name" label="部门名称" />
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
    <Add :show="addTag" @hide="addTag = false" @refresh="getDepartments" v-if="addTag"></Add>
    <Edit
      :show="editTag"
      @hide="editTag = false"
      @refresh="getDepartments"
      :id="rowId"
      v-if="editTag"
    ></Edit>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search, Plus } from "@element-plus/icons-vue";
import axios from "@/util/axios";
import Add from "./Add.vue";
import Edit from "./Edit.vue";

const rowId = ref(0);
const query = ref({});
const departments = ref([]);
const loading = ref(true);
const addTag = ref(false);
const editTag = ref(false);

/**
 * 加载数据
 */
const getDepartments = async () => {
  loading.value = true;
  const res = await axios.get("admin/system.Department/getIndexDepartments", {
    params: query.value
  });
  departments.value = res.data;
  loading.value = false;
};

/**
 * 搜索
 */
const search = () => {
  getDepartments();
};

/**
 * 打开添加页面
 */
const openAdd = () => {
  addTag.value = true;
};

/**
 * 打开修改
 */
const openEdit = (id) => {
  editTag.value = true;
  rowId.value = id;
};

/**
 * 删除
 * @param {number} id
 */
const del = async (id) => {
  const res = await axios.post("admin/system.Department/delete", {
    id: id
  });
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
  getDepartments();
};

onMounted(() => {
  getDepartments();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: #ffffff;
  padding: 16px;
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
  }
  .pagination {
    margin-top: 16px;
  }
}
</style>
