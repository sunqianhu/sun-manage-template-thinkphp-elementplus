<template>
  <div class="avatar">
    <el-dropdown>
      <span class="link">
        <el-avatar
          shape="square"
          :size="40"
          src="https://himg.bdimg.com/sys/portraitn/item/public.1.34d1db4b.d_5df9jxq_PmPwv0MZmKvg"
        ></el-avatar>
      </span>
      <template #dropdown>
        <el-dropdown-menu>
          <el-dropdown-item :icon="User" @click="openInfo"> 账号信息 </el-dropdown-item>
          <el-dropdown-item :icon="Edit" @click="openEditPassword"> 修改密码 </el-dropdown-item>
          <el-dropdown-item :icon="SwitchButton" @click="logout"> 退出登录 </el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>

    <info :open="infoFlag" @close="infoFlag = false" v-if="infoFlag"></info>
    <edit-password
      :open="editPasswordFlag"
      @close="editPasswordFlag = false"
      @submited="editPasswordFlag = false"
      v-if="editPasswordFlag"
    ></edit-password>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { Edit, SwitchButton, User } from "@element-plus/icons-vue";
import { useAppStore } from "../../store/app";
import axios from "@/helper/axios";
import Info from "@/view/my/Info.vue";
import EditPassword from "@/view/my/EditPassword.vue";

const router = useRouter();
const infoFlag = ref(false);
const editPasswordFlag = ref(false);

/**
 * 账号信息
 */
const openInfo = async () => {
  infoFlag.value = true;
};

/**
 * 打开修改密码
 */
const openEditPassword = async () => {
  editPasswordFlag.value = true;
};

/**
 * 退出登录
 */
const logout = async () => {
  const appStore = useAppStore();
  let url;

  const response = await axios.get("manage/Login/logout");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  appStore.clearRoutes();
  appStore.clearPermissions();
  localStorage.removeItem("token");

  router.replace("/login");
};
</script>

<style lang="scss" scoped>
.avatar .link {
  cursor: pointer;
}
</style>
