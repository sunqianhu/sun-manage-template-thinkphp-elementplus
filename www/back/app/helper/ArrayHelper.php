<?php
/**
 * 数组
 */

namespace app\helper;

class ArrayHelper
{
    /**
     * 转换为树数组
     * @param array $datas 数据
     * @return array
     */
    function convertTree($datas, $id = 'id', $parentId = 'parent_id', $children = 'children')
    {
        $middle = array(); // 中间数组
        $tree = array(); // 树形结构数组

        // 重构索引
        foreach ($datas as $data) {
            $middle[$data[$id]] = $data;
        }
        $datas = $middle;
        unset($middle);

        // 数组重构
        foreach ($datas as $data) {
            if (isset($datas[$data[$parentId]])) {
                // 存在上级
                $datas[$data[$parentId]][$children][] = &$datas[$data[$id]]; // 传地址，保证子项也跟到动。
            } else {
                // 不存在上级
                $tree[] = &$datas[$data[$id]]; // 传地址，保证后续更新datas，tree也被更新。
            }
        }

        return $tree;
    }

    /**
     * 二维数组按某字段降序排序
     * @param $array
     * @param $field
     * @return void
     */
    function twoDimensionalRsort(&$array, $field){
        usort($array, function($item1, $item2) use($field) {
            return $item2[$field] - $item1[$field];
        });
    }
}