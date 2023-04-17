<template>
  <div class="page-login">
    <div class="main">
      <div class="header">
        <div class="title">
          <img src="@/asset/image/logo.svg" class="logo" alt="logo" />
          <span class="name">管理后台</span>
        </div>
        <div class="desc">基于thinkphp和vue的组件化管理后台框架</div>
      </div>
      <el-form :model="form" :rules="rules" ref="formRef" class="form">
        <el-form-item prop="account">
          <el-input
            :prefix-icon="User"
            placeholder="请输入账号"
            size="large"
            v-model="form.account"
          />
        </el-form-item>
        <el-form-item prop="password">
          <el-input
            type="password"
            placeholder="请输入密码"
            show-password
            size="large"
            :prefix-icon="Lock"
            v-model="form.password"
          />
        </el-form-item>
        <el-form-item class="button-wrap">
          <el-button type="primary" size="large" @click="onSubmit" class="button">登录</el-button>
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
import { ref } from "vue";
import { User, Lock } from "@element-plus/icons-vue";
import { useRouter } from "vue-router";
import { loginApi } from "@/api/login";

const router = useRouter();
const form = ref({});
const formRef = ref(null);
const rules = {
  account: [{ required: true, message: "请输入账号", trigger: "blur" }],
  password: [{ required: true, message: "请输入密码", trigger: "blur" }]
};

// 提交
const onSubmit = () => {
  formRef.value.validate(async (valid) => {
    if (!valid) {
      return;
    }

    const res = await loginApi(form.value);
    if (res.code != 1) {
      ElMessage({
        message: res.message,
        type: "warning"
      });
      return;
    }

    // 存储
    //store.commit("setToken", res.data.token);
    //store.commit("setExpiresIn", res.data.expires_in);

    // 导航
    router.push("/home");
  });
};
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
.page-login {
  height: 100%;
  background-color: #f0f2f5;
  background-image: url(@/asset/image/login/background.svg);
  background-repeat: no-repeat;
  background-size: 100%;
  position: relative;

  .main {
    width: 350px;
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
      .desc {
        font-size: 14px;
        color: rgba(0, 0, 0, 0.45);
        margin-top: 12px;
        margin-bottom: 40px;
      }
    }

    .form {
      margin-top: 50px;

      .button-wrap {
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
    color: var(--text-color-gray);
  }
}
</style>
