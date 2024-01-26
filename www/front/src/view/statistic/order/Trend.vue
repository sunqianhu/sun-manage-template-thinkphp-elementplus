<template>
  <div class="trend">
    <div class="page-header">
      <span class="name">订单趋势统计</span>
      <span class="description">统计每天订单数量</span>
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
      <el-table :data="order" row-key="name" class="table">
        <el-table-column prop="full_name" label="日期" />
        <el-table-column prop="number" label="订单数量" />
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
const order = ref([]);
const loading = ref(true);

/**
 * 初始化
 */
const init = async () => {
  loading.value = true;
  const response = await axios.get("manage/statistic.order.Trend/init", {
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

  order.value = response.data;
  drawChart();
};

/**
 * 画图
 */
const drawChart = () => {
  let chartElement = document.getElementById("chart");
  let chart;
  let option = {
    tooltip: {},
    grid: {
      left: "0",
      right: "10",
      top: "10",
      bottom: "0",
      containLabel: true
    },
    xAxis: {
      type: "category",
      boundaryGap: false, // 坐标轴两边留白策略
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
        name: "信息数量",
        type: "line",
        areaStyle: {
          color: {
            type: "linear",
            x: 0,
            y: 0,
            x2: 0,
            y2: 1,
            colorStops: [
              {
                offset: 0,
                color: "#3fb1e3" // 0% 处的颜色
              },
              {
                offset: 1,
                color: "rgba(255,255,255,0)" // 100% 处的颜色
              }
            ]
          }
        }, // 区域填充样式
        data: []
      }
    ]
  };
  let data = order.value;

  //数据
  data.forEach((item) => {
    option.xAxis.data.push(item.name);
    option.series[0].data.push(item.number);
  });

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
.trend {
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
