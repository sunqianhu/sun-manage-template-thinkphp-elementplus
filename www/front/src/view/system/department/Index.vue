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
    <Add
      :open="addFlag"
      @close="addFlag = false"
      @submited="
        getDepartments();
        addFlag = false;
      "
      v-if="addFlag"
    ></Add>
    <Edit
      :open="editFlag"
      @close="editFlag = false"
      @submited="
        getDepartments();
        editFlag = false;
      "
      :id="rowId"
      v-if="editFlag"
    ></Edit>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search, Plus } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import Add from "./Add.vue";
import Edit from "./Edit.vue";

const rowId = ref(0);
const query = ref({});
const departments = ref([]);
const loading = ref(true);
const addFlag = ref(false);
const editFlag = ref(false);

/**
 * 加载数据
 */
const getDepartments = async () => {
  loading.value = true;
  const response = await axios.get("manage/system.Department/getIndexDepartments", {
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

  departments.value = response.data;
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
  const response = await axios.post("manage/system.Department/delete", {
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
  getDepartments();
};

onMounted(() => {
  getDepartments();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-panel);
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
      background-color: var(--background-color-table-header);
    }
  }
  .pagination {
    margin-top: 16px;
  }
}
</style>
