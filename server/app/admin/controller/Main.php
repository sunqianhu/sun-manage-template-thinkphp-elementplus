<?php

namespace app\admin\controller;

use app\helper\Tree;
use app\model\Menu as MenuModel;
use app\model\Role as RoleModel;

/**
 * 主页
 */
class Main extends Base
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

    /**
     * 得到菜单
     * @return void
     */
    public function getMenus()
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
            ->where('menu.type_id', 'in', '1,2')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->where('show', 1)
            ->order('menu.sort', 'asc')
            ->group('menu.id')
            ->select();
        if ($menuModels->isEmpty()) {
            return [];
        }

        $menus = [];
        foreach ($menuModels as $menuModel) {
            $menu = [];
            $menu['id'] = $menuModel->id;
            $menu['menu_id'] = $menuModel->menu_id;
            $menu['name'] = $menuModel->name;
            $menu['url'] = $menuModel->path;
            $menu['icon'] = $menuModel->icon;
            $menus[] = $menu;
        }
        $tree = new Tree();
        $treeMenus = $tree->convertTree($menus, 'id', 'menu_id', 'children');

        return $this->success('获取成功', $treeMenus);
    }

    /**
     * 获取权限
     * @return void
     */
    public function getPermissions()
    {
        $roleIds = RoleModel::join('user_role', 'role.id = user_role.role_id')
            ->where('user_role.user_id', $this->user->id)
            ->column('role_id');
        if (empty($roleIds)) {
            return [];
        }

        // 菜单
        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('menu.key')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->order('menu.sort', 'asc')
            ->group('menu.id')
            ->select();
        if ($menuModels->isEmpty()) {
            return [];
        }

        $permissions = [];
        foreach ($menuModels as $menuModel) {
            $permissions[] = $menuModel->key;
        }

        return $this->success('获取成功', $permissions);
    }
}
