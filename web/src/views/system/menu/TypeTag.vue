<template>
  <el-tag :type="type">{{ label }}</el-tag>
</template>

<script setup>
const props = defineProps(["type"]);
const types = [];
types[1] = {
  label: "目录",
  type: "warning",
};
types[2] = {
  label: "页面",
  type: "success",
};
types[3] = {
  label: "按钮",
  type: "info",
};

const label = types[props.type].label;
const type = types[props.type].type;
</script>
