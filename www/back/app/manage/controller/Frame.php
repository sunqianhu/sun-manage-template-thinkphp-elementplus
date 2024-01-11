<?php

namespace app\manage\controller;

use app\helper\ArrayHelper;
use app\helper\Menu as MenuHelper;
use app\model\Menu as MenuModel;
use app\model\Role as RoleModel;
use app\model\User as UserModel;

/**
 * 框架
 */
class Frame extends Base
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
            return $this->success('获取成功', []);
        }

        //页面
        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('menu.id,menu.menu_id,menu.type_id,menu.name,menu.path,menu.key,menu.component,menu.keep_alive,menu.layout')
            ->where('menu.network_terminal_id', 2)
            ->where('menu.type_id', 'in', '1,2')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->order('menu.sort','asc')
            ->group('menu.id')
            ->select();
        if ($menuModels->isEmpty()) {
            return $this->success('获取成功', []);
        }

        $menus = $menuModels->toArray();
        $arrayHelper = new ArrayHelper();
        $treeMenus = $arrayHelper->convertTree($menus, 'id', 'menu_id', 'children');
        $menuHelper = new MenuHelper();
        $mainFirstPageId = $menuHelper->getMainFirstPageId($treeMenus);
        $blankFirstPageId = $menuHelper->getBlankFirstPageId($treeMenus);

        $routes = [];
        foreach ($menuModels as $menuModel) {
            if (
                $menuModel->type_id != 2 ||
                $menuModel->path === '' ||
                $menuModel->name === '' ||
                $menuModel->component === ''
            ) {
                continue;
            }

            //父页面跳转
            $parentRedirect = '';
            if($menuModel->id == $mainFirstPageId){
                $parentRedirect = 'main';
            }
            if($menuModel->id == $blankFirstPageId){
                $parentRedirect = 'blank';
            }

            $route = [];
            $route['path'] = $menuModel->path;
            $route['name'] = $menuModel->key;
            $route['component'] = $menuModel->component;
            $route['layout'] = $menuModel->layout;
            $route['parent_redirect'] = $parentRedirect;
            $route['meta']['name'] = $menuModel->name;
            $route['meta']['keep_alive'] = $menuModel->keep_alive == 1;
            $routes[] = $route;
        }

        return $this->success('获取成功', $routes);
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
            return $this->success('获取成功', []);
        }

        //菜单
        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('menu.key')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->order('menu.sort', 'asc')
            ->group('menu.id')
            ->select();
        if ($menuModels->isEmpty()) {
            return $this->success('获取成功', []);
        }

        $permissions = [];
        foreach ($menuModels as $menuModel) {
            $permissions[] = $menuModel->key;
        }

        return $this->success('获取成功', $permissions);
    }

    /**
     * 获取水印
     * @return void
     */
    public function getWatermark(){
        $userModel = UserModel::field('id,name')->find($this->user->id);
        if(empty($userModel)){
            return $this->error('没有找到用户记录');
        }
        $data = [
            'id'=>$userModel->id,
            'name'=>$userModel->name,
            'time'=>date('Y-m-d H:i:s')
        ];
        return $this->success('获取成功', $data);
    }
}