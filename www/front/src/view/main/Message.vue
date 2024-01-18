<template>
  <el-collapse-transition>
    <div class="message" v-if="show">
      <div class="title">
        <div class="name">消息提醒</div>
        <el-icon class="close" @click="close"><Close /></el-icon>
      </div>
      <div class="content">
        <el-scrollbar max-height="250px" class="scrollbar">
          <div class="item" v-for="(message, index) in messages" :key="message.id">
            <a href="javascript:;" @click="navigateTo(index, message.url)"> {{ message.title }} </a>
          </div>
        </el-scrollbar>
      </div>
    </div>
  </el-collapse-transition>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";
import { Close } from "@element-plus/icons-vue";
import { useWebSocketClient } from "@/helper/web_socket_client.js";
import { config } from "@/../config.js";
import axios from "@/helper/axios";
import audioPath from "@/asset/message.mp3";

const router = useRouter();
const messages = ref([]); //消息
const show = ref(false); //显示

//websocket客户端
const webSocketClient = useWebSocketClient(config.messageWebSocketServerUrl);
webSocketClient.onOpen = () => {
  bind();
};
webSocketClient.onMessage = (event) => {
  const data = JSON.parse(event.data);
  if (!data) {
    return;
  }
  if (data.type == "message") {
    showMessage(data);
  }
};
webSocketClient.connect();

/**
 * 获取未读消息
 */
const getNoReadMessages = async () => {
  const response = await axios.get("manage/message/getNoReads");
  if (response.data.length == 0) {
    return;
  }
  messages.value = response.data;
  show.value = true;
};

/**
 * 绑定用户
 */
const bind = () => {
  const data = {
    type: "bind",
    user_id: localStorage.getItem("user_id")
  };
  const dataString = JSON.stringify(data);
  webSocketClient.send(dataString);
};

/**
 * 显示消息
 */
const showMessage = async (data) => {
  show.value = true;
  const message = {
    title: data.title,
    url: data.url
  };
  messages.value.unshift(message);
  playAudio();

  await axios.get("manage/message/readAll");
};

/**
 * 关闭
 */
const close = async () => {
  messages.value = [];
  show.value = false;
  await axios.get("manage/message/readAll");
};

/**
 * 导航
 * @param {string} url 路由地址
 */
const navigateTo = (index, url) => {
  messages.value.splice(index, 1);
  if (messages.value.length <= 0) {
    show.value = false;
  }

  if (!url) {
    return;
  }
  router.push(url);
};

/**
 * 播放声音
 */
function playAudio() {
  let audio = new Audio(audioPath);
  audio.play();
}

onMounted(() => {
  getNoReadMessages();
});
</script>

<style lang="scss" scoped>
.message {
  background-color: #ffffff;
  width: 330px;
  position: absolute;
  right: 10px;
  bottom: 10px;
  z-index: 3001;
  box-shadow: var(--box-shadow);
  border-radius: var(--border-radius);

  .title {
    display: flex;
    justify-content: space-between;
    align-items: center;

    padding: 16px 16px 0px 16px;
    .close {
      cursor: pointer;
      color: var(--font-color-secondary);
      &:hover {
        color: var(--font-color);
      }
    }
  }
  .content {
    .scrollbar {
      padding: 16px;
      .item {
        border-bottom: 1px solid var(--border-color-light);
        padding: 8px 0px;
        &:last-child {
          border-bottom: none;
        }
      }
    }
  }
}
</style>
