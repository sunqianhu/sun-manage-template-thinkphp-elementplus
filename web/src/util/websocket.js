let pingTimer;
let pingNumber = 40 * 1000;

let reconnetTag = false;
let reconnetTimer;
let reconnetNumber = 5 * 1000;

/**
 * 创建
 * @param {*} url
 * @returns
 */
export const create = (url) => {
  if (!window.WebSocket) {
    console.log("websocket：您的浏览器不支持websokect");
    ElMessage({
      message: "浏览器不支持websokect，推荐使用chrome浏览器",
      type: "error"
    });
    return;
  }
  return new window.WebSocket(url);
};

/**
 * 心跳
 */
export const ping = () => {
  clearInterval(pingTimer);
  pingTimer = setInterval(function () {
    console.log("websocket：发送心跳");
    socket.send('{"type":"ping", "msg":""}');
  }, pingNumber);
};

/**
 * 重连
 * @param {string} url
 * @returns
 */
export const reconnet = (url) => {
  const that = this;
  if (reconnetTag) {
    return;
  }
  reconnetTag = true;

  //重连
  clearInterval(reconnetTimer);
  reconnetTimer = setInterval(function () {
    console.log("websocket：断线重连");
    create(url);
    reconnetTag = false;
  }, reconnetNumber);
};
