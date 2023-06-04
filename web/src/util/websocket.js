
/**
 * 创建websocket
 * @param {string} url 
 * @returns 
 */
export const createWebsocket = (option) => {
  let webSocket;
  if (window.WebSocket) {
    webSocket = new WebSocket(option.url);
  } else if (window.MozwebSocket) {
    webSocket = new MozwebSocket(option.url);
  } else {
    return false;
  }

  /**
   * 连接成功
   * @param {object} event 
   */
  webSocket.onopen = function (event) {
    console.log("webSocket：onopen 连接成功");
    if (option.onOpen) {
      option.onOpen(event);
    }
  };

  /**
   * 连接错误
   */
  webSocket.addEventListener("error", function (event) {
    console.log("webSocket：onerror 遇到错误", event);
    if (option.onError) {
      option.onError(event);
    }
  });

  /**
     * 连接关闭
     */
  webSocket.onclose = function (event) {
    console.log("webSocket：onclose 连接关闭");
    if (option.onClose) {
      option.onClose(event);
    }
  };

  /**
   * 收到消息
   * @param {object} event
   */
  webSocket.addEventListener("message", function (event) {
    console.log("webSocket：onmessage 收到消息");
    if (option.onMessage) {
      option.onMessage(event);
    }
  });

  return webSocket;
}

