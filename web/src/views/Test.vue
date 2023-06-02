<template>
  <div>测试</div>
</template>

<script setup>
import { useWebSocket } from "../util/websocket.js";

const onOpen = () => {
  console.log("ssssssssssssssss");
};

const webSocket = useWebSocket({
  url: "ws://localhost:9001",
  onOpen: onOpen
});

setTimeout(() => {
  const webSocket2 = useWebSocket({
    url: "ws://localhost:9001"
  });
}, 1500);
</script>

<style scoped></style>
