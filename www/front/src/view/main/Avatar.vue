<template>
  <div class="avatar">
    <el-dropdown>
      <span class="link">
        <el-avatar shape="circle" :size="40" :src="avatar"></el-avatar>
      </span>
      <template #dropdown>
        <el-dropdown-menu>
          <el-dropdown-item :icon="User" @click="openInfo"> 账号信息 </el-dropdown-item>
          <el-dropdown-item :icon="User" @click="openEditAvatar"> 修改头像 </el-dropdown-item>
          <el-dropdown-item :icon="Edit" @click="openEditPassword"> 修改密码 </el-dropdown-item>
          <el-dropdown-item :icon="SwitchButton" @click="logout"> 退出登录 </el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>

    <info :open="infoFlag" @close="infoFlag = false" v-if="infoFlag"></info>
    <edit-avatar
      :open="editAvatarFlag"
      @close="editAvatarFlag = false"
      @saveed="
        editAvatarFlag = false;
        init();
      "
      v-if="editAvatarFlag"
    ></edit-avatar>
    <edit-password
      :open="editPasswordFlag"
      @close="editPasswordFlag = false"
      @submited="editPasswordFlag = false"
      v-if="editPasswordFlag"
    ></edit-password>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { Edit, SwitchButton, User } from "@element-plus/icons-vue";
import { useAppStore } from "../../store/app";
import axios from "@/helper/axios";
import Info from "@/view/my/Info.vue";
import EditAvatar from "@/view/my/EditAvatar.vue";
import EditPassword from "@/view/my/EditPassword.vue";

const router = useRouter();
const infoFlag = ref(false);
const editAvatarFlag = ref(false);
const editPasswordFlag = ref(false);
const avatar = ref("");

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/main/getAvatar");
  if (response.code != 1) {
    return;
  }

  avatar.value = response.data;
};

/**
 * 账号信息
 */
const openInfo = async () => {
  infoFlag.value = true;
};

/**
 * 打开修改头像
 */
const openEditAvatar = async () => {
  editAvatarFlag.value = true;
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

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.avatar .link {
  cursor: pointer;
}
</style>
