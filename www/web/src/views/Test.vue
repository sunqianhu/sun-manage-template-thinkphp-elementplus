<template>
  <div style="margin: 50px">
    <Panel title="信息详情" description="xxx">
      <template #button>
        <el-button text>按钮</el-button>
      </template>
      内容内容 内容内容 内容内容
    </Panel>

    <Panel title="内容回复">
      <template #button>
        <el-button text>按钮</el-button>
      </template>
      内容内容 内容内容 内容内容
    </Panel>
  </div>
</template>

<script setup>
import { ref } from "vue";
import Panel from "../component/Panel.vue";
import DescriptionItem from "../component/DescriptionItem.vue";
</script>

<style scoped></style>
