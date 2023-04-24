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
                'name' => '首页',
                'url' => '/index',
                'icon'=>'House'
            ],
            [
                'id' => 2,
                'name' => '系统管理',
                'url'=>'',
                'icon'=>'Setting',
                'children' => [
                    [
                        'id' => 3,
                        'name' => '用户管理',
                        'url' => '/system/user',
                        'icon' => 'User'
                    ],
                    [
                        'id' => 4,
                        'name' => '部门管理',
                        'url' => '/system/department',
                        'icon' => 'Memo'
                    ],
                    [
                        'id' => 5,
                        'name' => '角色管理',
                        'url' => '/system/role',
                        'icon'=>'ChatSquare'
                    ],
                    [
                        'id' => 6,
                        'name' => '菜单管理',
                        'url' => '/system/menu',
                        'icon'=>'Reading'
                    ],
                    [
                        'id' => 6,
                        'name' => '字典管理',
                        'url' => '/system/dictionary',
                        'icon'=>'Document'
                    ]
                ]
            ]
        ];
        return $this->success('获取成功', $menus);
    }

}
