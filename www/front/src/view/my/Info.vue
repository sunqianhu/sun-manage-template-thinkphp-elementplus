<template>
  <el-dialog
    :model-value="open"
    title="账号信息"
    width="500"
    :draggable="true"
    @close="close"
    class="info"
  >
    <div class="field-wrap">
      <div class="field">
        <div class="label">账号</div>
        <div class="content">{{ user.account }}</div>
      </div>
      <div class="field">
        <div class="label">姓名</div>
        <div class="content">{{ user.name }}</div>
      </div>
      <div class="field">
        <div class="label">手机号码</div>
        <div class="content">{{ user.phone }}</div>
      </div>
      <div class="field">
        <div class="label">所属单位</div>
        <div class="content">
          {{ user.department_name }}
        </div>
      </div>
      <div class="field">
        <div class="label">最后登录时间</div>
        <div class="content">
          {{ dayjs.unix(user.login_time).format("YYYY-MM-DD HH:mm:ss") }}
        </div>
      </div>
      <div class="field">
        <div class="label">最后登录ip</div>
        <div class="content">
          {{ user.login_ip }}
        </div>
      </div>
    </div>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";

const props = defineProps(["open"]);
const emits = defineEmits(["close"]);
const user = ref({});
const loading = ref(true);

/**
 * 初始化
 */
const init = async () => {
  loading.value = true;
  const response = await axios.get("manage/My/info");
  loading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  user.value = response.data;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

onMounted(() => {
  init();
});
</script>
<style lang="scss" scoped>
.info {
  .field-wrap {
    .field {
      margin-top: 8px;
      &:first-child {
        margin-top: 0px;
      }
      .label {
        color: var(--font-color-secondary);
        width: 100px;
        display: inline-block;
      }
      .content {
        display: inline-block;
        margin-left: 16px;
      }
    }
  }
}
</style>
