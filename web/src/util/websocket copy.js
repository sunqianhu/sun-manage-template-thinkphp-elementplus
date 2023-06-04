
/**
 * 使用websocket
 */
export default class WebSocketClient {
  url = "";
  instance = null; // socket对象

  reconnetTimer = null; // 重连定时器
  reconnetNumber = 1000 * 5; // 重连间隔
  reconnetTag = false; // 重连标识

  pingTimer = null; // 心跳定时器
  pingNumber = 1000 * 40; // 心跳间隔

  onOpen (event) { }
  onError(event) { }
  onClose(event)  { }
  onMessage(event)  { }

  /**
   * 初始化
   */
  constructor(config) {
    console.log(1);
    this.url = config.url;
    if (config.onOpen) {
      this.onOpen = config.onOpen;
    }
    if (!config.onError) {
      this.onError = config.onError;
    }
    if (!config.onClose) {
      this.onClose = config.onClose;
    }
    if (!config.onMessage) {
      this.onMessage = config.onMessage;
    }
  };

  /**
   * 连接
   * @returns
   */
  connect = () => {
    const that = this;
    try {
      if (window.WebSocket) {
        that.instance = new WebSocket(that.url);
      } else if (window.MozwebSocket) {
        that.instance = new MozwebSocket(that.url);
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
    that.instance.onopen = function (event) {
      console.log("webSocket：onopen 连接成功");
      clearInterval(that.reconnetTimer);
      that.ping();
      that.onOpen(event);
    };

    /**
     * 发生错误事件，连接关闭
     */
    that.instance.addEventListener("error", function (event) {
      console.log("webSocket：onerror 遇到错误", event);
      clearInterval(that.pingTimer);
      that.reconnet();
      that.onError(event);
    });

    /**
     * 连接关闭
     */
    that.instance.onclose = function (event) {
      console.log("webSocket：onclose 连接关闭");
      clearInterval(that.pingTimer);
      that.reconnet();
      that.onClose(event);
    };

    /**
     * 接收到新消息时
     * @param {*} event
     */
    that.instance.addEventListener("message", function (event) {
      console.log("webSocket：onmessage 收到消息");
      console.log(event);
      that.onMessage(event);
    });

    return true;
  };

  /**
   * 重连
   * @returns
   */
  reconnet = () => {
    const that = this;
    if (that.reconnetTag) {
      return;
    }
    that.reconnetTag = true;

    // 重连
    clearInterval(that.reconnetTimer);
    that.reconnetTimer = setInterval(() => {
      console.log("webSocket：断线重连");
      that.connect();
      that.reconnetTag = false;
    }, that.reconnetNumber);
  };

  /**
   * 心跳
   */
  ping = () => {
    const that = this;
    clearInterval(that.pingTimer);
    that.pingTimer = setInterval(() => {
      console.log("webSocket：发送心跳");
      that.instance.send('{"type":"ping"}');
    }, that.pingNumber);
  };

  /**
   * 发送
   * @param {string} payload 
   */
  send = (payload) => {
    this.instance.send(payload);
  }
}
