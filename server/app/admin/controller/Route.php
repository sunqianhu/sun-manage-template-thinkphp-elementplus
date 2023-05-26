<?php

namespace app\admin\controller;

use app\model\Role as RoleModel;
use app\model\Menu as MenuModel;

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
        $roleIds = RoleModel::join('user_role', 'role.id = user_role.role_id')
            ->where('user_role.user_id', $this->user->id)
            ->column('role_id');
        if (empty($roleIds)) {
            return [];
        }

        // 菜单
        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('menu.*')
            ->where('menu.type_id', 2)
            ->where('role_menu.role_id', 'in', $roleIds)
            ->order('menu.sort', 'asc')
            ->group('menu.id')
        ->select();
        if ($menuModels->isEmpty()) {
            return [];
        }

        $routes = [];
        foreach ($menuModels as $menuModel) {
            if (
                empty($menuModel) ||
                $menuModel->path === '' ||
                $menuModel->name === '' ||
                $menuModel->component === ''
            ) {
                continue;
            }

            $route = [];
            $route['path'] = $menuModel->path;
            $route['name'] = $menuModel->key;
            $route['component'] = $menuModel->component;
            $route['meta']['name'] = $menuModel->name;
            $routes[] = $route;
        }

        return $this->success('获取成功', $routes);
    }
}
