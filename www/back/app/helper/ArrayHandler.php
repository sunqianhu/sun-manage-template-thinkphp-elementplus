<?php
/**
 * 数组
 */

namespace app\helper;

class ArrayHandler
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
}
