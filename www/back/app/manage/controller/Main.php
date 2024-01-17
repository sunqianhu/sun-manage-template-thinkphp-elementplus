<?php

namespace app\manage\controller;

use app\helper\ArrayHandler;
use app\model\Config as ConfigModel;
use app\model\Menu as MenuModel;
use app\model\Role as RoleModel;
use app\model\User as UserModel;

/**
 * 主页
 */
class Main extends Base
{
    /**
     * 初始化
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function init()
    {
        $configModel = ConfigModel::field('version')->find(1);
        $config = $configModel->toArray();

        $data = [
            'config' => $config
        ];
        return $this->success('获取成功', $data);
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
            return $this->success('获取成功', []);
        }

        //菜单
        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('menu.*')
            ->where('menu.type_id', 'in', '1,2,4')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->where('show', 1)
            ->order('menu.sort', 'asc')
            ->group('menu.id')
            ->select();
        if ($menuModels->isEmpty()) {
            return $this->success('获取成功', []);
        }

        $menus = [];
        foreach ($menuModels as $menuModel) {
            $menu = [];
            $menu['id'] = $menuModel->id;
            $menu['menu_id'] = $menuModel->menu_id;
            $menu['type_id'] = $menuModel->type_id;
            $menu['name'] = $menuModel->name;
            $menu['path'] = $menuModel->path;
            $menu['url'] = $menuModel->url;
            $menu['icon'] = $menuModel->icon;
            $menus[] = $menu;
        }
        $arrayHandler = new ArrayHandler();
        $treeMenus = $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');

        return $this->success('获取成功', $treeMenus);
    }

    /**
     * 得到头像
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getAvatar()
    {
        $userModel = UserModel::field('avatar')->find($this->user->id);
        $avatar = $userModel->avatar_url;
        return $this->success('获取成功', $avatar);
    }
}