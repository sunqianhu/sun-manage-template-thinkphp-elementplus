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
          <el-dropdown-item :icon="Edit" @click="openEditPassword"> 修改密码 </el-dropdown-item>
          <el-dropdown-item :icon="SwitchButton" @click="logout"> 退出登录 </el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>

    <EditPassword
      :open="editPasswordFlag"
      @close="editPasswordFlag = false"
      v-if="editPasswordFlag"
    ></EditPassword>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import { Edit, SwitchButton } from "@element-plus/icons-vue";
import { useAppStore } from "../../stores/app";
import EditPassword from "@/views/my/EditPassword.vue";

const router = useRouter();
const editPasswordFlag = ref(false);

/**
 * 打开修改密码
 */
const openEditPassword = async () => {
  editPasswordFlag.value = true;
};

/**
 * 退出登录
 */
const logout = () => {
  const appStore = useAppStore();

  localStorage.removeItem("token");
  appStore.clearRoutes();
  appStore.clearPermissions();

  router.replace("/login");
};
</script>

<style lang="scss" scoped>
.avatar .link {
  cursor: pointer;
}
</style>
