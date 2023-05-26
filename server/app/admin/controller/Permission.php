<?php

namespace app\admin\controller;

use app\library\Str;
use app\model\Menu as MenuModel;
use app\model\Role as RoleModel;

/**
 * 权限
 */
class Permission extends Base
{
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
