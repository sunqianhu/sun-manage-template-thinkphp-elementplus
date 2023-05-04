<?php

namespace app\admin\controller;

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
        $permissions = ['home',
            'system',
            'system_user',
            'system_user_add',
            'system_user_edit',
            'system_role'
        ];
        return $this->success('获取成功', $permissions);
    }

}
