/**
 * 使用websocket
 */
const useWebSocket = (config) => {
  let webSocket = null; // socket对象

  let reconnetTimer = null; // 重连定时器
  let reconnetNumber = 1000 * 10; // 重连间隔
  let reconnetTag = false; // 重连标识

  let pingTimer = null; // 心跳定时器
  let pingNumber = 1000 * 40; // 心跳间隔

  /**
   * 初始化
   */
  const init = () => {
    if (!config || !config.url) {
      throw new Error("websocket配置错误");
    }

    if (!config.onOpen) {
      config.onOpen = (event) => {};
    }
    if (!config.onError) {
      config.onError = (event) => {};
    }
    if (!config.onClose) {
      config.onClose = (event) => {};
    }
    if (!config.onMessage) {
      config.onMessage = (event) => {};
    }

    connect();
  };

  /**
   * 连接
   * @returns
   */
  const connect = () => {
    try {
      if (window.WebSocket) {
        webSocket = new WebSocket(config.url);
      } else if (window.MozwebSocket) {
        webSocket = new MozwebSocket(config.url);
      } else {
        console.error("webSocket：您的浏览器不支持websokect");
        ElMessage({
          message: "您的浏览器不支持websokect，推荐使用新版chrome浏览器",
          type: "error"
        });
        return false;
      }
    } catch (e) {
      console.error("webSocket：" + e.message);
      ElMessage({
        message: e.message,
        type: "error"
      });
      return false;
    }

    /**
     * 连接成功
     * @param {object} event
     */
    webSocket.onopen = function (event) {
      console.log("webSocket：onopen 连接成功");
      clearInterval(reconnetTimer);
      ping();
      config.onOpen(event);
    };

    /**
     * 发生错误事件，连接关闭
     */
    webSocket.addEventListener("error", function (event) {
      console.log("webSocket：onerror 遇到错误", event);
      clearInterval(pingTimer);
      reconnet();
      config.onError(event);
    });

    /**
     * 连接关闭
     */
    webSocket.onclose = function (event) {
      console.log("webSocket：onclose 连接关闭");
      clearInterval(pingTimer);
      reconnet();
      config.onClose(event);
    };

    /**
     * 接收到新消息时
     * @param {*} event
     */
    webSocket.addEventListener("message", function (event) {
      console.log("webSocket：onmessage 收到消息");
      console.log(event);
      config.onMessage(event);
    });

    return true;
  };

  /**
   * 重连
   * @returns
   */
  const reconnet = () => {
    if (reconnetTag) {
      return;
    }
    reconnetTag = true;

    // 重连
    clearInterval(reconnetTimer);
    reconnetTimer = setInterval(() => {
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
      webSocket.send('{"type":"ping"}');
    }, pingNumber);
  };

  init(); // 初始化

  return this;
};

export { useWebSocket };
