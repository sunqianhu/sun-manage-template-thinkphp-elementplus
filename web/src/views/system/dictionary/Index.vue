<template>
  <div class="index">
    <div class="page-name">字典管理</div>
    <div class="search">
      <el-form :model="query" :inline="true">
        <el-form-item label="字典类型">
          <el-input v-model="query.type" />
        </el-form-item>
        <el-form-item label="字典名称">
          <el-input v-model="query.name" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" :icon="Search" @click="search">搜索</el-button>
        </el-form-item>
      </el-form>
    </div>

    <div class="toolbar">
      <el-button type="primary" :icon="Plus" @click="openAdd">添加</el-button>
    </div>

    <div class="list">
      <el-table :data="dictionarys" v-loading="loading" row-key="id" style="width: 100%">
        <el-table-column prop="type" label="字典类型" />
        <el-table-column prop="name" label="字典名称" />
        <el-table-column prop="value" label="字典值" />
        <el-table-column prop="sort" label="排序" width="100" />
        <el-table-column v-slot="{ row }" label="操作" fixed="right" width="140">
          <el-button size="small" @click="openEdit(row.id)">修改</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="del(row.id)">
            <template #reference>
              <el-button size="small">删除</el-button>
            </template>
          </el-popconfirm>
        </el-table-column>
      </el-table>
    </div>

    <div class="pagination">
      <el-pagination
        background
        layout="total,->,sizes,jumper,prev, pager, next"
        :page-sizes="[10, 30, 50, 100, 200, 300]"
        :page-size="query.size"
        :total="total"
        @size-change="changePageSize"
        @current-change="changePageCurrent"
      />
    </div>

    <Add :show="addTag" @hide="addTag = false" @refresh="getDictionarys" v-if="addTag"></Add>
    <Edit
      :show="editTag"
      @hide="editTag = false"
      @refresh="getDictionarys"
      :id="rowId"
      v-if="editTag"
    ></Edit>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { Search, Plus } from "@element-plus/icons-vue";
import axios from "@/util/axios";
import Add from "./Add.vue";
import Edit from "./Edit.vue";

const rowId = ref(0);
const query = ref({
  size: 30,
  page: 1
});
const dictionarys = ref([]);
const loading = ref(true);
const addTag = ref(false);
const editTag = ref(false);
const total = ref(0);

/**
 * 加载数据
 */
const getDictionarys = async () => {
  loading.value = true;
  const res = await axios.get("admin/Dictionary/getIndexDictionarys", {
    params: query.value
  });
  if (res.code != 1) {
    ElMessage({
      message: res.message,
      type: "error"
    });
    loading.value = false;
    return;
  }

  total.value = res.data.total;
  dictionarys.value = res.data.data;
  loading.value = false;
};

/**
 * 搜索
 */
const search = () => {
  getDictionarys();
};

/**
 * 打开添加页面
 */
const openAdd = () => {
  addTag.value = true;
};

/**
 * 打开修改
 */
const openEdit = (id) => {
  editTag.value = true;
  rowId.value = id;
};

/**
 * 删除
 * @param {number} id
 */
const del = async (id) => {
  const res = await axios.post("admin/Dictionary/delete", {
    id: id
  });
  if (res.code != 1) {
    ElMessage({
      message: res.message,
      type: "error"
    });
    return;
  }

  ElMessage({
    message: res.message,
    type: "success"
  });
  getDictionarys();
};

/**
 * 切换页面显示条目数
 * @param {number} size
 */
const changePageSize = (size) => {
  query.value.size = size;
  query.value.number = 1;
  getDictionarys();
};

/**
 * 切换页面页码
 * @param {number} page
 */
const changePageCurrent = (page) => {
  query.value.page = page;
  getDictionarys();
};

onMounted(() => {
  getDictionarys();
});
</script>

<style lang="scss" scoped>
.index {
  background-color: #ffffff;
  padding: 16px;
  .page-name {
    font-size: 20px;
    font-weight: bold;
  }
  .search {
    margin-top: 16px;
  }
  .toolbar {
  }
  .list {
    margin-top: 16px;
  }
  .pagination {
    margin-top: 16px;
  }
}
</style>
