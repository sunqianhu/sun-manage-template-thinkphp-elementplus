<template>
  <div class="login">
    <div class="background">
      <video src="@/asset/login/background.mp4" autoplay loop muted></video>
    </div>
    <div class="form-wrap">
      <div class="header">
        <div class="title">
          <img src="@/asset/logo.png" class="logo" alt="logo" />
          <span class="name">vue管理系统模板</span>
        </div>
      </div>
      <el-form
        :model="login"
        :rules="rules"
        scroll-to-error
        ref="loginRef"
        class="form"
        @keyup.enter="submitForm"
      >
        <el-form-item prop="account">
          <el-input
            :prefix-icon="User"
            placeholder="请输入账号"
            size="large"
            v-model="login.account"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            type="password"
            placeholder="请输入密码"
            show-password
            size="large"
            :prefix-icon="Lock"
            v-model="login.password"
          />
        </el-form-item>
        <el-form-item class="submit">
          <el-button type="primary" size="large" @click="verify" class="button" :loading="loading"
            >登录</el-button
          >
        </el-form-item>
      </el-form>
    </div>
    <div class="footer">
      <div class="browser">浏览器支持：Edge ≥ 79 Firefox≥78 Chrome≥64 Safari≥12</div>
      <div class="copyright">Copyright &copy; 2023 asun</div>
    </div>
    <Vcode
      :show="vCodeFlag"
      @success="
        vCodeFlag = false;
        submitForm();
      "
      @close="vCodeFlag = false"
    />
  </div>
</template>

<script setup>
import { ref } from "vue";
import { User, Lock } from "@element-plus/icons-vue";
import { useRouter } from "vue-router";
import axios from "@/helper/axios";
import Vcode from "vue3-puzzle-vcode";

const router = useRouter();
const login = ref({});
const loginRef = ref(null);
const rules = {
  account: [{ required: true, message: "账号不能为空", trigger: "blur" }],
  password: [{ required: true, message: "密码不能为空", trigger: "blur" }]
};
const loading = ref(false);
const vCodeFlag = ref(false);

/**
 * 验证
 */
const verify = async () => {
  await loginRef.value.validate();
  vCodeFlag.value = true;
};

/**
 * 提交表单
 */
const submitForm = async () => {
  loading.value = true;
  let response;
  try {
    response = await axios.post("manage/login/login", login.value);
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

  localStorage.setItem("token", response.data.token);
  localStorage.setItem("user_id", response.data.user_id);
  router.push("/");
};
</script>

<style lang="scss">
html {
  height: 100%;
  body {
    height: 100%;
    #app {
      height: 100%;
      overflow: hidden;
    }
  }
}
</style>

<style lang="scss" scoped>
.login {
  height: 100%;
  background-color: var(--background-color-page);
  position: relative;
  .background {
    position: absolute;
    left: 0px;
    right: 0px;
    top: 0px;
    bottom: 0px;
    z-index: 1;
    video {
      width: 100%;
      height: 100%;
      object-fit: fill;
    }
  }
  .form-wrap {
    padding: 32px;
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    z-index: 3;
    background: rgba(255, 255, 255, 0.9);
    border-radius: var(--border-radius-big);
    box-shadow: 0px 0px 32px rgba(0, 0, 0, 0.12);
    .header {
      text-align: center;
      .title {
        line-height: 44px;
        .logo {
          height: 30px;
          vertical-align: -4px;
        }
        .name {
          margin-left: 12px;
          font-size: 24px;
          font-weight: bold;
        }
      }
    }

    .form {
      margin-top: 50px;
      width: 300px;
      .submit {
        margin-top: 50px;
        .button {
          width: 100%;
        }
      }
    }
  }

  .footer {
    position: absolute;
    left: 16px;
    right: 16px;
    bottom: 16px;
    z-index: 2;
    text-align: center;
    font-size: var(--font-size-small);
    color: var(--font-color-secondary);
  }
}
</style>
