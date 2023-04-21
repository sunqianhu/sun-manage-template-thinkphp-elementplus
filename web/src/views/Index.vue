<template><div>home</div></template>

<script setup>
import { loginApi } from "../api/login";

const login = async () => {
  const res = await loginApi();
  console.log(res);
};

login();
</script>

<style scoped></style>
