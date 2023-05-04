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
          <el-dropdown-item :icon="SwitchButton" @click="logout"> 退出登录 </el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>
  </div>
</template>

<script setup>
import { useRouter } from "vue-router";
import { SwitchButton } from "@element-plus/icons-vue";
import { useAppStore } from "../../store/app";

const router = useRouter();

/**
 * 退出登录
 */
const logout = () => {
  localStorage.removeItem("token");
  let appStore = useAppStore();
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
