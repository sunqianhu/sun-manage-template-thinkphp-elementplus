<template>
  <div>测试</div>
</template>

<script setup>
import { useWebSocket } from "../util/websocket.js";

let webSocket;

const onOpen = () => {
  const message = {
    type: "bind",
    data: {
      token: "token1"
    }
  };
  const payload = JSON.stringify(message);
  webSocket.webSocket.send(payload);
};

webSocket = useWebSocket({
  url: "ws://localhost:9001",
  onOpen: onOpen
});
console.log(webSocket)
</script>

<style scoped></style>
