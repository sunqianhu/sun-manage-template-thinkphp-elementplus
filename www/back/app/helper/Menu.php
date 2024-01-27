<?php

namespace app\helper;

class Menu
{
    /**
     * 得到主布局第一个页面菜单id
     * @param $treeMenus 树菜单数组
     * @return int|mixed
     */
    public function getMainFirstPageId($treeMenus)
    {
        foreach($treeMenus as $treeMenu){
            if($treeMenu['layout'] == "main" && $treeMenu['type_id'] == 2){
                return $treeMenu['id'];
            }
            if(empty($treeMenu['children'])){
                continue;
            }

            return $this->getMainFirstPageId($treeMenu['children']);
        }

        return 0;
    }

    /**
     * 得到空白布局第一个页面菜单id
     * @param $treeMenus 树菜单数组
     * @return int|mixed
     */
    public function getBlankFirstPageId($treeMenus)
    {
        foreach($treeMenus as $treeMenu){
            if($treeMenu['layout'] == "blank" && $treeMenu['type_id'] == 2){
                return $treeMenu['id'];
            }
            if(empty($treeMenu['children'])){
                continue;
            }

            return $this->getBlankFirstPageId($treeMenu['children']);
        }

        return 0;
    }
}