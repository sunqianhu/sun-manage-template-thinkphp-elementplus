<template>
  <div class="index">
    <div class="page-name">用户管理</div>

    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="部门">
          <el-tree-select
            v-model="query.department_id"
            :data="departments"
            :render-after-expand="false"
            check-strictly
            clearable
          />
        </el-form-item>
        <el-form-item label="角色">
          <el-select v-model="query.role_id" clearable>
            <el-option v-for="role in roles" :label="role.name" :value="role.id" />
          </el-select>
        </el-form-item>
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
        <el-table-column v-slot="{ row }" prop="account" label="账号">
          <el-link :href="'/system/user/' + row.id" type="primary" target="_blank">
            {{ row.account }}
          </el-link>
        </el-table-column>
        <el-table-column prop="name" label="姓名" />
        <el-table-column prop="department.name" label="部门" />
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

    <add
      :open="addFlag"
      @close="addFlag = false"
      @submited="
        getUsers();
        addFlag = false;
      "
      v-if="addFlag"
    ></add>
    <edit
      :open="editFlag"
      @close="editFlag = false"
      @submited="
        getUsers();
        editFlag = false;
      "
      :id="rowId"
      v-if="editFlag"
    ></edit>
    <EditPassword
      :open="editPasswordFlag"
      :id="rowId"
      @close="editPasswordFlag = false"
      @submited="editPasswordFlag = false"
      v-if="editPasswordFlag"
    ></EditPassword>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
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
const departments = ref([]);
const roles = ref([]);
const users = ref([]);
const total = ref(0);
const rowId = ref(0);
const addFlag = ref(false);
const editFlag = ref(false);
const editPasswordFlag = ref(false);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/system.User/initIndex");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  departments.value = response.data.departments;
  roles.value = response.data.roles;
  getUsers();
};

/**
 * 得到用户数据
 */
const getUsers = async () => {
  loading.value = true;
  const response = await axios.get("manage/system.User/getIndexUsers", {
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
  users.value = response.data.data;
  total.value = response.data.total;
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
  addFlag.value = true;
};

/**
 * 打开修改
 */
const openEdit = (id) => {
  rowId.value = id;
  editFlag.value = true;
};

/**
 * 修改状态
 * @param {number} id 记录id
 */
const editStatus = async (row) => {
  row.status_id = row.status_id == 1 ? 2 : 1;
  const response = await axios.post("manage/system.User/editStatus", {
    id: row.id,
    status_id: row.status_id
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
};

/**
 * 打开修改密码
 * @param {number} id 记录id
 */
const openEditPassword = async (id) => {
  rowId.value = id;
  editPasswordFlag.value = true;
};

/**
 * 踢下线
 * @param {number} id 记录id
 */
const offLine = async (id) => {
  let response = await ElMessageBox.confirm("确定将用户踢下线吗？", "提示", { draggable: true });

  response = await axios.post("manage/system.User/offLine", {
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
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: var(--background-color-panel);
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-name {
    font-size: 20px;
    font-weight: bold;
  }
  .search {
    margin-top: var(--margin);
  }
  .toolbar {
  }
  .list {
    margin-top: var(--margin);
    ::v-deep(th.el-table__cell) {
      background-color: var(--background-color-table-header);
    }
  }
  .pagination {
    margin-top: var(--margin);
  }
}
</style>
