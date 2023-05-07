<template>
  <div class="index">
    <div class="page-name">用户管理</div>

    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="账号">
          <el-input v-model="query.account" />
        </el-form-item>
        <el-form-item label="手机">
          <el-input v-model="query.phone" />
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search"
            >搜索</el-button
          >
        </el-form-item>
      </el-form>
    </div>

    <div class="toolbar">
      <el-button type="primary" :icon="Plus" @click="showAddDialog"
        >添加</el-button
      >
    </div>

    <div class="data">
      <el-table :data="data" v-loading="loading" stripe style="width: 100%">
        <el-table-column prop="account" label="账号" />
        <el-table-column prop="name" label="姓名" />
        <el-table-column prop="phone" label="电话" />
        <el-table-column v-slot="{ row }" prop="add_time" label="添加日期">
          {{ dayjs.unix(row.add_time).format("YYYY-MM-DD") }}
        </el-table-column>
        <el-table-column v-slot="{ row }" prop="status" label="状态">
          <el-switch
            :model-value="row.status_id == 1 ? true : false"
            @change="editStatus(row.id)"
          />
        </el-table-column>
        <el-table-column
          v-slot="{ row }"
          label="操作"
          fixed="right"
          width="220"
        >
          <el-button size="small">详情</el-button>
          <el-button size="small" @click="showEditDialog(row.id)"
            >修改</el-button
          >
          <el-dropdown style="margin-left: 12px">
            <el-button size="small">
              更多
              <el-icon><arrow-down /></el-icon>
            </el-button>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="showEditPasswordDialog(row.id)"
                  >修改密码</el-dropdown-item
                >
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </el-table-column>
      </el-table>
    </div>

    <div class="pagination">
      <el-pagination
        background
        layout="total,->,sizes,jumper,prev, pager, next"
        :page-sizes="[10, 20, 30, 40, 50, 100, 200]"
        v-model:page-size="query.pageSize"
        :total="total"
        @size-change="changePageSize"
        @current-change="changePageNumber"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/util/axios";
import dayjs from "dayjs";
import { Search, ArrowDown, Plus } from "@element-plus/icons-vue";

const query = ref({
  pageSize: 50,
  pageNumber: 1,
});
const loading = ref(true);
const data = ref([]);
const total = ref(0);
const rowId = ref(0);
const addTag = ref(false);
const editTag = ref(false);
const editPasswordTag = ref(false);

/**
 * 初始化
 */
const init = async () => {
  //const res = await axios.get("/admin/system.user/initIndex");
  loadData();
};

/**
 * 加载数据
 */
const loadData = async () => {
  loading.value = true;
  const res = await axios.get("/admin/system.user/loadIndexData", {
    params: query.value,
  });
  data.value = res.data.data;
  total.value = res.data.total;
  loading.value = false;
};

/**
 * 搜索
 */
const search = () => {
  query.pageNumber = 1;
  loadData();
};

/**
 * 切换页面显示记录
 * @param {number} pageSize
 */
const changePageSize = (pageSize) => {
  query.value.pageSize = pageSize;
  query.value.pageNumber = 1;
  loadData();
};

/**
 * 切换分页页码
 * @param {*} pageNumber
 */
const changePageNumber = (pageNumber) => {
  query.value.pageNumber = pageNumber;
  loadData();
};

/**
 * 显示添加对话框
 */
const showAddDialog = () => {
  addTag.value = true;
};

/**
 * 显示修改对话框
 */
const showEditDialog = (id) => {
  rowId.value = id;
  editTag.value = true;
};

/**
 * 修改状态
 * @param {number} id 记录id
 */
const editStatus = async (id) => {
  const res = await axios.post("/pc/system.user/editStatus", { id: id });
  if (res.code != 0) {
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
};

/**
 * 显示修改密码对话框
 */
const showEditPasswordDialog = async (id) => {
  rowId.value = id;
  editPasswordTag.value = true;
};

onMounted(() => {
  init();
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
  .data {
    margin-top: 16px;
  }
  .pagination {
    margin-top: 16px;
  }
}
</style>
