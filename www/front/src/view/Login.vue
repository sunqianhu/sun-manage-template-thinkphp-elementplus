<template>
  <div class="login">
    <div class="wrap">
      <div class="header">
        <div class="title">
          <img src="@/asset/image/logo.png" class="logo" alt="logo" />
          <span class="name">通用后台管理系统</span>
        </div>
        <div class="subtitle">使用thinkphp vue element plus开发的通用后台管理系统</div>
      </div>
      <el-form :model="login" :rules="rules" ref="loginRef" class="form" @keyup.enter="submitForm">
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
        <el-form-item prop="captcha_code" class="captcha">
          <el-input
            type="text"
            placeholder="验证码"
            size="large"
            :prefix-icon="Monitor"
            v-model="login.captcha_code"
            maxlength="4"
            class="input"
          />
          <img
            :src="captchaImage"
            v-if="captchaImage"
            @click="getCaptcha()"
            title="点击更换验证码"
          />
        </el-form-item>
        <el-form-item class="submit">
          <el-button
            type="primary"
            size="large"
            @click="submitForm"
            class="button"
            :loading="loading"
            >登录</el-button
          >
        </el-form-item>
      </el-form>
    </div>

    <div class="footer">
      <div class="browser">浏览器支持：Edge ≥ 79 Firefox≥78 Chrome≥64 Safari≥12</div>
      <div class="copyright">Copyright &copy; 2023 asun</div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { User, Lock, Monitor } from "@element-plus/icons-vue";
import { useRouter } from "vue-router";
import axios from "@/util/axios";

const router = useRouter();
const login = ref({});
const loginRef = ref(null);
const rules = {
  account: [{ required: true, message: "请输入账号", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }],
  captcha_code: [{ required: true, message: "请输入验证码", trigger: "blur" }]
};
const loading = ref(false);
const captchaImage = ref("");

/**
 * 得到验证码
 */
const getCaptcha = async () => {
  const response = await axios.get("manage/login/getCaptcha");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }
  login.value.captcha_token = response.data.token;
  login.value.captcha_code = "";
  captchaImage.value = response.data.image;
};

/**
 * 提交表单
 */
const submitForm = () => {
  loginRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    loading.value = true;
    let response = await axios.post("manage/login/login", login.value);
    loading.value = false;
    if (response.code != 1) {
      ElMessage({
        message: response.message,
        type: "error"
      });
      if (response.message.indexOf("验证码") !== -1) {
        getCaptcha();
      }
      return;
    }

    localStorage.setItem("token", response.data.token);
    localStorage.setItem("user_id", response.data.user_id);
    router.push("/");
  });
};

onMounted(() => {
  getCaptcha();
});
</script>

<style lang="scss">
html {
  height: 100%;
  body {
    height: 100%;
    #app {
      height: 100%;
    }
  }
}
</style>

<style lang="scss" scoped>
.login {
  height: 100%;
  background-color: #f0f2f5;
  background-image: url(@/asset/image/login/background.svg);
  background-repeat: no-repeat;
  background-size: 100%;
  position: relative;

  .wrap {
    padding: 16px;
    left: 0px;
    right: 0px;
    position: absolute;
    z-index: 2;
    top: 50%;
    margin-top: -200px;

    .header {
      text-align: center;
      .title {
        line-height: 44px;
        .logo {
          height: 44px;
          vertical-align: top;
        }
        .name {
          margin-left: 16px;
          font-size: 30px;
          font-weight: bold;
        }
      }
      .subtitle {
        color: var(--font-color-light);
        margin-top: 12px;
      }
    }

    .form {
      width: 350px;
      margin-top: 50px;
      margin-left: auto;
      margin-right: auto;
      .captcha {
        .input {
          width: 200px;
        }
        img {
          margin-left: 16px;
          height: 35px;
          border-radius: 4px;
          cursor: pointer;
        }
      }
      .submit {
        margin-top: 30px;
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
    z-index: 1;
    text-align: center;
    font-size: var(--font-size-small);
    color: var(--font-color-light);
  }
}
</style>
