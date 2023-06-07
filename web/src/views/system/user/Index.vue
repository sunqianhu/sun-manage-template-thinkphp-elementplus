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
          <el-button type="primary" :icon="Search" @click="search">搜索</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="toolbar">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>

    <div class="list">
      <el-table :data="users" v-loading="loading" stripe style="width: 100%">
        <el-table-column prop="account" label="账号" />
        <el-table-column prop="name" label="姓名" />
        <el-table-column prop="phone" label="手机号码" />
        <el-table-column v-slot="{ row }" prop="add_time" label="添加日期">
          {{ dayjs.unix(row.add_time).format("YYYY-MM-DD") }}
        </el-table-column>
        <el-table-column v-slot="{ row }" prop="status" label="状态">
          <el-switch :model-value="row.status_id == 1 ? true : false" @change="editStatus(row)" />
        </el-table-column>
        <el-table-column v-slot="{ row }" label="操作" fixed="right" width="170">
          <!--<el-button size="small">详情</el-button>-->
          <el-button size="small" @click="openEdit(row.id)">修改</el-button>
          <el-dropdown style="margin-left: 12px">
            <el-button size="small">
              更多
              <el-icon><arrow-down /></el-icon>
            </el-button>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="openEditPassword(row.id)">修改密码</el-dropdown-item>
                <el-dropdown-item @click="offLine(row.id)"> 踢下线 </el-dropdown-item>
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
        :page-sizes="[10, 30, 50, 100, 200, 300]"
        v-model:page-size="query.size"
        :total="total"
        @size-change="changePageSize"
        @current-change="changePageCurrent"
      />
    </div>

    <Add :show="addTag" @hide="addTag = false" @refresh="getUsers" v-if="addTag"></Add>
    <Edit
      :show="editTag"
      @hide="editTag = false"
      @refresh="getUsers"
      :id="rowId"
      v-if="editTag"
    ></Edit>
    <EditPassword
      :show="editPasswordTag"
      :id="rowId"
      @hide="editPasswordTag = false"
      v-if="editPasswordTag"
    ></EditPassword>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/util/axios";
import dayjs from "dayjs";
import { Search, ArrowDown, Plus } from "@element-plus/icons-vue";
import Add from "./Add.vue";
import Edit from "./Edit.vue";
import EditPassword from "./EditPassword.vue";

const query = ref({
  size: 30,
  page: 1
});
const loading = ref(true);
const users = ref([]);
const total = ref(0);
const rowId = ref(0);
const addTag = ref(false);
const editTag = ref(false);
const editPasswordTag = ref(false);

/**
 * 初始化
 */
const init = async () => {
  //const res = await axios.get("admin/system.User/initIndex");
  getUsers();
};

/**
 * 得到用户数据
 */
const getUsers = async () => {
  loading.value = true;
  const res = await axios.get("admin/system.User/getIndexUsers", {
    params: query.value
  });
  if (res.code != 1) {
    ElMessage({
      message: res.message,
      type: "error"
    });
    loading.value = false;
    return;
  }
  users.value = res.data.data;
  total.value = res.data.total;
  loading.value = false;
};

/**
 * 搜索
 */
const search = () => {
  query.page = 1;
  getUsers();
};

/**
 * 切换页面显示条目数
 * @param {number} size
 */
const changePageSize = (size) => {
  query.value.size = size;
  query.value.page = 1;
  getUsers();
};

/**
 * 切换页面页码
 * @param {*} page
 */
const changePageCurrent = (page) => {
  query.value.page = page;
  getUsers();
};

/**
 * 打开添加
 */
const openAdd = () => {
  addTag.value = true;
};

/**
 * 打开修改
 */
const openEdit = (id) => {
  rowId.value = id;
  editTag.value = true;
};

/**
 * 修改状态
 * @param {number} id 记录id
 */
const editStatus = async (row) => {
  row.status_id = row.status_id == 1 ? 2 : 1;
  const res = await axios.post("admin/system.User/editStatus", {
    id: row.id,
    status_id: row.status_id
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
};

/**
 * 打开修改密码
 * @param {number} id 记录id
 */
const openEditPassword = async (id) => {
  rowId.value = id;
  editPasswordTag.value = true;
};

/**
 * 踢下线
 * @param {number} id 记录id
 */
const offLine = async (id) => {
  let res = await ElMessageBox.confirm("确定将用户踢下线吗？", "提示", { draggable: true });

  res = await axios.post("admin/system.User/offLine", {
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
  .list {
    margin-top: 16px;
  }
  .pagination {
    margin-top: 16px;
  }
}
</style>
