<template>
  <div class="index">
    <div class="page-name">操作日志</div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="操作时间">
          <el-date-picker
            v-model="query.time"
            type="datetimerange"
            value-format="YYYY-MM-DD HH:mm:ss"
            range-separator="至"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
          />
        </el-form-item>
        <el-form-item label="用户姓名">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item label="手机号码">
          <el-input v-model="query.phone" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search">搜索</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="list">
      <el-table :data="operationLogs" v-loading="loading" row-key="id" style="width: 100%">
        <el-table-column prop="name" label="用户姓名" />
        <el-table-column label="操作时间" v-slot="{ row }">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
        <el-table-column prop="url" label="操作地址" width="450" />
        <el-table-column prop="ip" label="操作ip" />
      </el-table>
    </div>

    <div class="pagination">
      <el-pagination
        background
        layout="total,->,sizes,jumper,prev, pager, next"
        :page-sizes="[10, 30, 50, 100, 200, 300]"
        :page-size="query.size"
        :total="total"
        @size-change="changePageSize"
        @current-change="changePageCurrent"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { dayjs } from "element-plus";
import { Search } from "@element-plus/icons-vue";
import axios from "@/helper/axios";

const query = ref({
  time: [
    dayjs().subtract(3, "month").format("YYYY-MM-DD") + " 00:00:00",
    dayjs().format("YYYY-MM-DD") + " 23:59:59"
  ],
  size: 30,
  page: 1
});
const operationLogs = ref([]);
const loading = ref(true);
const total = ref(0);

/**
 * 获取操作日志
 */
const getOperationLogs = async () => {
  if (query.value.time) {
    query.value.start_time = dayjs(query.value.time[0]).unix();
    query.value.end_time = dayjs(query.value.time[1]).unix();
  }

  loading.value = true;
  const response = await axios.get("manage/system.OperationLog/getIndexOperationLogs", {
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

  total.value = response.data.total;
  operationLogs.value = response.data.data;
};

/**
 * 搜索
 */
const search = () => {
  getOperationLogs();
};

/**
 * 切换页面显示条目数
 * @param {number} size
 */
const changePageSize = (size) => {
  query.value.size = size;
  query.value.number = 1;
  getOperationLogs();
};

/**
 * 切换当前页
 * @param {number} page
 */
const changePageCurrent = (page) => {
  query.value.page = page;
  getOperationLogs();
};

onMounted(() => {
  getOperationLogs();
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
  .list {
    ::v-deep(th.el-table__cell) {
      background-color: var(--background-color);
    }
  }
  .pagination {
    margin-top: 16px;
  }
}
</style>
