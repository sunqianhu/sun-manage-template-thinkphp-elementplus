<template>
  <div>测试</div>
</template>

<script setup>
import { useWs } from "@/util/ws.js";

const ws = useWs("ws://localhost:9001");
ws.onOpen = () => {
  ws.send("sssss");
};
ws.connect();
</script>

<style scoped></style>
