<template>
  <div class="rich-editor">
    <Toolbar :editor="editorRef" :defaultConfig="toolbarConfig" :mode="mode" class="toolbar" />
    <Editor
      v-model="html"
      :defaultConfig="editorConfig"
      :mode="mode"
      @onCreated="setEditRef"
      :style="'height: ' + height + 'px'"
    />
  </div>
</template>

<script setup>
import "@wangeditor/editor/dist/css/style.css"; // 引入 css

import { onBeforeUnmount, ref, shallowRef, watch } from "vue";
import { Editor, Toolbar } from "@wangeditor/editor-for-vue";
import { config } from "../../config.js";

const props = defineProps({
  modelValue: {
    type: String,
    default: ""
  },
  mode: {
    type: String,
    default: "default"
  },
  height: {
    type: Number,
    default: 350
  },
  toolbarConfig: {
    type: Object,
    default: {}
  },
  editorConfig: {
    type: Object,
    default: {}
  }
});
const emits = defineEmits(["update:modelValue"]);
const editorRef = shallowRef(); // 编辑器实例，必须用 shallowRef
const mode = props.mode;
const html = ref(props.modelValue); // 内容 HTML
const token = localStorage.getItem("token") || "";
const toolbarConfig = Object.assign(
  {},
  {
    //toolbarKeys: ["bold"]
    //excludeKeys: []
  },
  props.editorConfig
);
const editorConfig = Object.assign(
  {},
  {
    placeholder: "请输入...",
    MENU_CONF: {
      uploadImage: {
        server: config.proxyPrefix + "manage/UploadFile/upload",
        fieldName: "file",
        maxFileSize: 1024 * 1024 * 20,
        headers: {
          token: token
        },
        meta: {
          module: "rich_editor"
        },
        timeout: 1000 * 15,
        customInsert(response, insertFn) {
          if (response.code != 1) {
            ElMessage({
              message: response.message,
              type: "error"
            });
            return;
          }

          let responseData = response.data;
          insertFn(responseData.url, responseData.name, responseData.url);
        }
      },
      uploadVideo: {
        server: config.proxyPrefix + "manage/UploadFile/upload",
        fieldName: "file",
        maxFileSize: 1024 * 1024 * 200,
        headers: {
          token: token
        },
        meta: {
          module: "rich_editor"
        },
        timeout: 1000 * 60,
        customInsert(response, insertFn) {
          if (response.code != 1) {
            ElMessage({
              message: response.message,
              type: "error"
            });
            return;
          }

          let responseData = response.data;
          insertFn(responseData.url, responseData.name, responseData.url);
        }
      }
    }
  },
  props.editorConfig
);

/**
 * 设置html
 * @param {*} newHtml
 */
const setHtml = (newHtml) => {
  html.value = newHtml;
};

/**
 * 设置编辑器模板引用
 * @param {*} editor
 */
const setEditRef = (editor) => {
  editorRef.value = editor; // 记录 editor 实例，重要！
};

/**
 * 侦听props
 */
watch(
  () => props.modelValue,
  (newModelValue) => {
    setHtml(newModelValue);
  },
  {
    deep: true
  }
);

/**
 * 侦听数据
 */
watch(
  () => html.value,
  (newHtml) => {
    emits("update:modelValue", newHtml);
  },
  {
    deep: true
  }
);

onBeforeUnmount(() => {
  const editor = editorRef.value;
  if (editor == null) return;
  editor.destroy();
});
</script>

<style lang="scss" scoped>
.rich-editor {
  border: 1px solid var(--border-color);
  .toolbar {
    border-bottom: 1px solid var(--border-color);
  }
}
</style>
