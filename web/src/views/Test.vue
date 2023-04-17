<template>
  <div>
    <el-row class="mb-4">
      <el-button>Default</el-button>
      <el-button type="primary">Primary</el-button>
      <el-button type="success">Success</el-button>
      <el-button type="info">Info</el-button>
      <el-button type="warning">Warning</el-button>
      <el-button type="danger">Danger</el-button>
    </el-row>
    ddddd
  </div>
</template>

<script setup>
import { loginApi } from "../api/login";

const login = async () => {
  const res = await loginApi();
  console.log(res);
};

login();
</script>

<style scoped></style>
