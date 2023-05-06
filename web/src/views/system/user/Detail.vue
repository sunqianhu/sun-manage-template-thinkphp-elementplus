<template>
  <div class="page-detail">
    <el-card class="user">
      <template #header> 用户信息 </template>
      <el-row gutter="8">
        <el-col :md="8" :sm="24">
          <FieldView label="用户id">1001</FieldView>
        </el-col>
        <el-col :md="8" :sm="24">
          <FieldView label="账号">15108273576</FieldView>
        </el-col>
        <el-col :md="8" :sm="24">
          <FieldView label="姓名">孙乾户</FieldView>
        </el-col>
        <el-col :md="8" :sm="24">
          <FieldView label="手机号码">15108273576</FieldView>
        </el-col>
        <el-col :md="8" :sm="24">
          <FieldView label="部门">研发部</FieldView>
        </el-col>
        <el-col :md="8" :sm="24">
          <FieldView label="角色">信息审核人员</FieldView>
        </el-col>
        <el-col :md="8" :sm="24">
          <FieldView label="状态">启用</FieldView>
        </el-col>
        <el-col :md="8" :sm="24">
          <FieldView label="添加时间">2023-01-24 13:33:22</FieldView>
        </el-col>
        <el-col :md="8" :sm="24">
          <FieldView label="最后修改时间">2023-01-26 16:23:15</FieldView>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script setup>
import FieldView from "@/components/FieldView.vue";
</script>

<style lang="scss" scoped>
.page-detail {
}
</style>
