<?php

namespace app\library;

/**
 * 用户助手
 */
class User
{
    public function getMenus($userId)
    {
        $roleIds = RoleModel::join('user_role', 'role.id = user_role.role_id')
            ->where('user_role.user_id', $userId)
            ->column('role_id');
        if (empty($roleIds)) {
            return [];
        }

        // 菜单
        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('api')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->select();
        if ($menuModels->isEmpty()) {
            return [];
        }
        return $menuModels->toArray();
    }
}
