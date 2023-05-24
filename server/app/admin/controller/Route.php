<?php

namespace app\admin\controller;

/**
 * 路由
 */
class Route extends Base
{
    /**
     * 获取路由
     * @return void
     */
    public function getRoutes()
    {
        $routes = [
            [
                'path' => '/index',
                'name' => 'index',
                'component' => 'Index.vue',
                'meta' => [
                    'name' => '首页'
                ]
            ],
            [
                'path' => '/system/department',
                'name' => 'systemDepartment',
                'component' => 'system/department/Index.vue',
                'meta' => [
                    'name' => '部门管理'
                ]
            ],
            [
                'path' => '/system/user',
                'name' => 'systemUser',
                'component' => 'system/user/Index.vue',
                'meta' => [
                    'name' => '用户管理'
                ]
            ],
            [
                'path' => '/system/role',
                'name' => 'systemRole',
                'component' => 'system/role/Index.vue',
                'meta' => [
                    'name' => '角色管理'
                ]
            ],
            [
                'path' => '/system/menu',
                'name' => 'systemMenu',
                'component' => 'system/menu/Index.vue',
                'meta' => [
                    'name' => '菜单管理'
                ]
            ],
            [
                'path' => '/system/dictionary',
                'name' => 'systemDictionary',
                'component' => 'system/dictionary/Index.vue',
                'meta' => [
                    'name' => '字典管理'
                ]
            ]
        ];
        return $this->success('获取成功', $routes);
    }
}
