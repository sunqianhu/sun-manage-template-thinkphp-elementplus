<template>
  <div>测试</div>
</template>

<script setup>
const socket = new WebSocket("ws://localhost:9001");
socket.onopen = function (event) {
  socket.send("测试发送数据");
};
socket.onmessage = function (event) {
  console.log("收到服务器端数据：", event.data);
};
</script>

<style scoped></style>
