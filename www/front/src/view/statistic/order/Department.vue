<template>
  <div class="department">
    <div class="page-header">
      <span class="name">订单部门统计</span>
      <span class="description">统计每个部门订单量</span>
    </div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="订单时间">
          <el-date-picker
            v-model="query.add_time"
            type="datetimerange"
            format="YYYY-MM-DD HH:mm:ss"
            value-format="X"
            range-separator="至"
            start-placeholder="开始时间"
            end-placeholder="结束时间"
            editable
            unlink-panels
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search">搜索</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="chart" id="chart" v-loading="loading"></div>

    <panel title="订单明细" class="list">
      <el-table :data="orders" row-key="name" class="table">
        <el-table-column prop="name" label="部门" />
        <el-table-column prop="number" label="订单量" />
      </el-table>
    </panel>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search } from "@element-plus/icons-vue";
import axios from "@/helper/axios";
import dayjs from "dayjs";
import * as echarts from "echarts";
import blueTheme from "@/extend/echarts_theme/blue.json";
import Panel from "@/component/Panel.vue";

const query = ref({
  add_time: [
    dayjs(dayjs().subtract(1, "month").format("YYYY-MM-DD") + " 00:00:00").unix(),
    dayjs(dayjs().add(1, "day").format("YYYY-MM-DD") + " 00:00:00").unix()
  ]
});
const orders = ref([]);
const loading = ref(true);

/**
 * 初始化
 */
const init = async () => {
  loading.value = true;
  const response = await axios.get("manage/statistic.order.Department/init", {
    params: query.value
  });
  loading.value = false;
  if (response.code != 1) {
    ElMessage({
      message: response.message,
      type: "error"
    });
    return;
  }

  orders.value = response.data;
  drawChart();
};

/**
 * 画图
 */
const drawChart = () => {
  let chartElement = document.getElementById("chart");
  let chart;

  let option = {
    grid: {
      left: "0",
      right: "10",
      top: "10",
      bottom: "0",
      containLabel: true
    },
    xAxis: {
      type: "category",
      data: []
    },
    yAxis: {
      type: "value",
      axisLabel: {
        formatter: "{value}条"
      }
    },
    series: [
      {
        name: "订单数量",
        type: "bar",
        label: {
          show: true,
          color: "#ffffff"
        },
        data: []
      }
    ]
  };
  let data = orders.value;
  let length = data.length;
  let item;

  //数据
  for (let index = 0; index < length; index++) {
    item = data[index];
    if (index >= 10) {
      break;
    }
    option.xAxis.data.push(item.name);
    option.series[0].data.push(item.number);
  }

  //画
  chart = echarts.init(chartElement, "blue_theme");
  chart.setOption(option);
};

/**
 * 搜索
 */
const search = () => {
  init();
};

onMounted(() => {
  echarts.registerTheme("blue_theme", blueTheme);
  init();
});
</script>

<style lang="scss" scoped>
.department {
  background-color: var(--background-color-panel);
  padding: var(--padding);
  border-radius: var(--border-radius);
  box-shadow: var(--box-shadow);
  .page-header {
    .name {
      font-size: 20px;
      font-weight: bold;
    }
    .description {
      color: var(--font-color-secondary);
      margin-left: var(--margin);
      font-size: var(--font-size-small);
    }
  }
  .search {
    margin-top: var(--margin);
  }
  .chart {
    margin-top: var(--margin);
    height: 200px;
  }
  .list {
    margin-top: var(--margin);
    ::v-deep(th.el-table__cell) {
      background-color: var(--background-color-table-header);
    }
    .table {
      width: 100%;
    }
  }
}
</style>
