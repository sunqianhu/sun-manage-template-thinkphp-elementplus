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
            // 主模板路由
            'main'=>[
                [
                    'path'=>'/index',
                    'name'=>'index',
                    'component'=>'Index.vue',
                    'meta'=>[
                        'name'=>'首页'
                    ]
                ],
                [
                    'path'=>'/system/user',
                    'name'=>'system_user',
                    'component'=>'system/user/Index.vue',
                    'meta'=>[
                        'name'=>'用户管理'
                    ]
                ],
                [
                    'path'=>'/system/role',
                    //'name'=>'system_role',
                    'component'=>'Index.vue',
                    'meta'=>[
                        'name'=>'角色管理'
                    ]
                ]
            ],
            // 空白路由
            'blank'=>[
                [
                    'path'=>'/test',
                    'name'=>'test',
                    'component'=>'Test.vue',
                    'meta'=>[
                        'name'=>'测试'
                    ]
                ]
            ]
        ];
        return $this->success('获取成功', $routes);
    }

}
