<template>
  <div class="detail" v-loading="loading">
    <panel title="用户信息" class="pannel">
      <description>
        <description-item label="用户id">{{ user.id }}</description-item>
        <description-item label="账号">{{ user.account }}</description-item>
        <description-item label="姓名">{{ user.name }}</description-item>
        <description-item label="手机号码">{{ user.phone }}</description-item>
        <description-item label="部门">{{ user.department?.name }}</description-item>
        <description-item label="角色">{{ user.role_name_string }}</description-item>
        <description-item label="状态">{{ user.status_name }}</description-item>
        <description-item label="添加时间">
          {{ dayjs.unix(user.add_time).format("YYYY-MM-DD HH:mm:ss") }}
        </description-item>
        <description-item label="最后修改时间">
          {{ dayjs.unix(user.edit_time).format("YYYY-MM-DD HH:mm:ss") }}
        </description-item>
        <description-item label="最后登录时间">
          {{ dayjs.unix(user.login_time).format("YYYY-MM-DD HH:mm:ss") }}
        </description-item>
        <description-item label="最后登录ip">{{ user.login_ip }}</description-item>
      </description>
    </panel>

    <panel title="登录日志" class="pannel">
      <template #extra>
        <el-link href="/system/login-log" type="primary" target="_blank"> 更多 </el-link>
      </template>
      <el-table :data="loginLogs" row-key="id" style="width: 100%">
        <el-table-column prop="ip" label="登录ip" />
        <el-table-column label="登录时间" v-slot="{ row }">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
      </el-table>
    </panel>

    <panel title="操作日志" class="pannel">
      <template #extra>
        <el-link href="/system/operation-log" type="primary" target="_blank"> 更多 </el-link>
      </template>
      <el-table :data="operationLogs" row-key="id" style="width: 100%">
        <el-table-column label="操作时间" v-slot="{ row }">
          {{ dayjs.unix(row.time).format("YYYY-MM-DD HH:mm:ss") }}
        </el-table-column>
        <el-table-column prop="url" label="操作地址" width="450" />
        <el-table-column prop="ip" label="操作ip" />
      </el-table>
    </panel>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import axios from "@/helper/axios";
import Panel from "@/component/Panel.vue";
import Description from "@/component/Description.vue";
import DescriptionItem from "@/component/DescriptionItem.vue";
import dayjs from "dayjs";

const route = useRoute();
const user = ref({});
const loginLogs = ref([]);
const operationLogs = ref([]);
const loading = ref(true);

/**
 * 初始化
 */
const init = async () => {
  loading.value = true;
  let response;
  try {
    response = await axios.get("manage/system.User/detail", {
      params: { id: route.params.id }
    });
  } catch (error) {
    loading.value = false;
    return;
  }
  loading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  user.value = response.data.user;
  loginLogs.value = response.data.login_logs;
  operationLogs.value = response.data.operation_logs;
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
:global(body) {
  background: var(--background-color-page-texture);
}
.detail {
  padding: var(--padding);
  .pannel {
    margin-top: var(--margin);
    &:first-child {
      margin-top: 0px;
    }
  }
}
</style>
