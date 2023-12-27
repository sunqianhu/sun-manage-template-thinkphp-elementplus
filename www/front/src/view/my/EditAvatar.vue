<template>
  <el-dialog
    :model-value="open"
    title="修改头像"
    width="800"
    :draggable="true"
    align-center
    @close="close"
  >
    <div class="edit-avatar">
      <el-row>
        <el-col :span="16" class="left">
          <div class="cropper">
            <vue-cropper
              :img="option.img"
              :outputType="option.outputType"
              :info="option.info"
              :autoCrop="option.autoCrop"
              :fixed="option.fixed"
              :fixedNumber="option.fixedNumber"
              :limitMinSize="option.limitMinSize"
              :centerBox="option.centerBox"
              @realTime="realTimePreview"
              ref="cropperRef"
            ></vue-cropper>
          </div>
          <div class="operation">
            <el-upload
              :before-upload="uploadImageBefore"
              :show-file-list="false"
              class="upload-image"
            >
              <el-button type="primary" :icon="Upload">选择图片</el-button>
            </el-upload>
            <el-button :icon="ZoomIn" @click="scaleBig" />
            <el-button :icon="ZoomOut" @click="scaleSmall" />
            <el-button :icon="RefreshLeft" @click="rotateLeft" />
            <el-button :icon="RefreshRight" @click="rotateRight" />
          </div>
        </el-col>
        <el-col :span="8" class="right">
          <div class="title">预览头像</div>
          <div class="preview">
            <div class="show-preview">
              <div :style="preview.div">
                <img :src="preview.url" :style="preview.img" />
              </div>
            </div>
          </div>
          <div class="save-wrap">
            <el-button type="primary" @click="save" :loading="saveLoading"> 保存 </el-button>
          </div>
        </el-col>
      </el-row>
    </div>
  </el-dialog>
</template>

<script setup>
import { ref, onMounted } from "vue";
import axios from "@/helper/axios";
import { Upload, ZoomOut, ZoomIn, RefreshLeft, RefreshRight } from "@element-plus/icons-vue";
import "vue-cropper/dist/index.css";
import { VueCropper } from "vue-cropper";

const props = defineProps(["open"]);
const emits = defineEmits(["close", "saveed"]);
const cropperRef = ref();
const option = ref({
  img: "",
  outputType: "png",
  info: false,
  autoCrop: true,
  fixed: true,
  fixedNumber: [1, 1],
  limitMinSize: 100,
  centerBox: true
});
const preview = ref({});
const saveLoading = ref(false);

/**
 * 初始化
 */
const init = async () => {
  const response = await axios.get("manage/my/initEditAvatar");
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  option.value.img = response.data;
};

/**
 * 关闭
 */
const close = () => {
  emits("close", true);
};

/**
 * 上传图片前
 * @param {*} file
 */
const uploadImageBefore = (file) => {
  // 使用 FileReader 读取文件并设置给 selectedImage
  const reader = new FileReader();
  reader.onload = () => {
    option.value.img = reader.result;
  };
  reader.readAsDataURL(file);
  return false;
};

/**
 * 放大
 */
const scaleBig = () => {
  cropperRef.value.changeScale(1);
};

/**
 * 缩小
 */
const scaleSmall = () => {
  cropperRef.value.changeScale(-1);
};

/**
 * 向左旋转
 */
const rotateLeft = () => {
  cropperRef.value.rotateLeft();
};

/**
 * 向右旋转
 */
const rotateRight = () => {
  cropperRef.value.rotateRight();
};

/**
 * 实时预览
 * @param {*} data
 */
const realTimePreview = (data) => {
  preview.value = data;
  let zoom = 100 / data.w;
  preview.value.div.transform = "scale(" + zoom + ")";
};

/**
 * 保存
 */
const save = () => {
  cropperRef.value.getCropData(async (data) => {
    console.log(`output->data`, data);
    saveLoading.value = true;
    let response;
    try {
      response = await axios.post("manage/my/saveEditAvatar", { avatar_base64_content: data });
    } catch (error) {
      saveLoading.value = false;
      return;
    }
    saveLoading.value = false;
    if (response.code != 1) {
      ElMessage({
        message: response.message,
        type: "error"
      });
      return;
    }

    ElMessage({
      message: response.message,
      type: "success"
    });
    emits("saveed", true);
  });
};

onMounted(() => {
  init();
});
</script>

<style lang="scss" scoped>
.edit-avatar {
  .left {
    .cropper {
      height: 350px;
      background-color: #888888;
      .image {
        max-width: 100%;
        max-height: 100%;
      }
    }
    .operation {
      margin-top: var(--margin);
      .upload-image {
        display: inline-block;
        vertical-align: middle;
        margin-right: var(--margin);
      }
    }
  }
  .right {
    padding-left: 16px;
    .preview {
      height: 329px;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
      .show-preview {
        width: 100px;
        height: 100px;
        overflow: hidden;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
      }
    }
    .save-wrap {
      margin-top: var(--margin);
      text-align: center;
    }
  }
}
</style>
