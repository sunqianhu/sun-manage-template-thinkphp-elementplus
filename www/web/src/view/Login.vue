<template>
  <div class="login">
    <div class="wrap">
      <div class="header">
        <div class="title">
          <img src="@/assets/image/logo.png" class="logo" alt="logo" />
          <span class="name">管理后台</span>
        </div>
        <div class="subtitle">基于thinkphp和vue的组件化管理后台框架</div>
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
  const response = await axios.get("admin/login/getCaptcha");
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

    let response;
    loading.value = true;
    try {
      response = await axios.post("admin/login/login", login.value);
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
      if (response.message.indexOf("验证码错误") !== -1) {
        getCaptcha();
      }
      return;
    }

    // 存储
    localStorage.setItem("token", response.data.token);
    localStorage.setItem("user_id", response.data.user_id);

    // 导航
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
  background-image: url(@/assets/image/login/background.svg);
  background-repeat: no-repeat;
  background-size: 100%;
  position: relative;

  .wrap {
    width: 330px;
    position: absolute;
    left: 50%;
    top: 50%;
    z-index: 2;
    margin-left: -175px;
    margin-top: -200px;

    .header {
      text-align: center;
      .title {
        line-height: 44px;
        .logo {
          height: 44px;
          vertical-align: top;
          margin-right: 16px;
        }
        .name {
          font-size: 30px;
          font-weight: bold;
        }
      }
      .subtitle {
        color: rgba(0, 0, 0, 0.45);
        margin-top: 12px;
        margin-bottom: 40px;
      }
    }

    .form {
      margin-top: 30px;
      .captcha {
        .input {
          width: 190px;
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
    width: 100%;
    bottom: 10px;
    z-index: 1;
    text-align: center;
    font-size: 12px;
    color: var(--font-color-light);
  }
}
</style>
