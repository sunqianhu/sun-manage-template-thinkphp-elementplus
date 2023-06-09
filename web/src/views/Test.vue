<template>
  <div style="margin: 20px; border: 1px solid #ff0000">
    <Description>
      <DescriptionItem label="姓名">孙乾户</DescriptionItem>
      <DescriptionItem label="性别">男</DescriptionItem>
      <DescriptionItem label="生日">2022-11-12</DescriptionItem>
      <DescriptionItem label="籍贯">四川</DescriptionItem>
      <DescriptionItem label="居住地">成都成都成都成都成都成都</DescriptionItem>

      <DescriptionItem sm="24" md="24" label="222222">成都成都成都成都成都成都</DescriptionItem>
      <DescriptionItem sm="24" md="24" label="网站网址">成都成都成都成都成都成都</DescriptionItem>
    </Description>
  </div>
</template>

<script setup>
import { ref } from "vue";
import Description from "../component/Description.vue";
import DescriptionItem from "../component/DescriptionItem.vue";
</script>

<style scoped></style>
