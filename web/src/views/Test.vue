<template>
  <div>测试</div>
</template>

<script setup>
let url = "ws://127.0.0.1:9001";
let ws; // websocket对象
let reconnetNumber = 1000 * 10; // 重连间隔
let reconnetTag = false; // 重连标识
let pingTimer = null; // 心跳定时器
let pingNumber = 1000 * 40; // 心跳间隔

/**
 * 连接websocket
 * @param {string} url 
 * @returns 
 */
const connect = () => {
  if (window.WebSocket) {
    ws = new WebSocket(url);
  } else if (window.MozwebSocket) {
    ws = new MozwebSocket(url);
  } else {
    return false;
  }

  ws.onopen = (event) => {
    console.log("webSocket：onopen 连接成功");
    ping();
    onOpen(event);
  };
  ws.addEventListener("error", function (event) {
    console.log("webSocket：onerror 遇到错误", event);
    clearInterval(pingTimer);
    reconnet();
  });
  ws.onclose = function (event) {
    console.log("webSocket：onclose 连接关闭");
    clearInterval(pingTimer);
    reconnet();
  };
  ws.addEventListener("message", function (event) {
    console.log("webSocket：onmessage 收到消息", event);
    onMessage(event);
  });

  return ws;
}

/**
 * 重连
 * @returns
 */
const reconnet = () => {
  if (reconnetTag) {
    return;
  }
  reconnetTag = true;

  setTimeout(() => {
    console.log("webSocket：断线重连");
    connect();
    reconnetTag = false;
  }, reconnetNumber);
};

/**
 * 心跳
 */
const ping = () => {
  clearInterval(pingTimer);
  pingTimer = setInterval(() => {
    console.log("webSocket：发送心跳");
    ws.send('{"type":"ping"}');
  }, pingNumber);
};

/**
 * 连接成功
 * @param {object} event 
 */
const onOpen = (event) => {
  console.log("openopen")
}

/**
 * 收到消息
 * @param {object} event 
 */
const onMessage = (event) => {
  console.log("onMessageonMessageonMessageonMessage")
}

if (!connect()) {
  ElMessage({
    message: "您的浏览器不支持websokect，推荐使用新版chrome浏览器",
    type: "error"
  });
}
</script>

<style scoped></style>
