<?php

namespace app\admin\controller;

/**
 * 菜单
 */
class Menu extends Base
{
    /**
     * 得到菜单
     * @return void
     */
    public function getMenus()
    {
        $menus = [
            [
                'id' => 1,
                'name' => '首页'
            ],
            [
                'id' => 2,
                'name' => '系统管理'
            ]
        ];
        return $this->success('获取成功', $menus);
    }

}
