<?php

namespace app\helper;

use app\model\Menu as MenuModel;
use app\model\User as UserModel;
use think\facade\Config;

class User
{
    /**
     * 用户id转用户账号
     * @param $use
     * @param $exclude
     * @return mixed|string
     */
    public function idToAccount($idString, $fromDecollator = ',', $toDecollator = ',')
    {
        $ids = explode($fromDecollator, $idString);
        $idString = implode(',', $ids);
        if (empty($idString)) {
            return '';
        }

        $accounts = UserModel::where('id', 'in', $idString)->column('account');
        if (empty($accounts)) {
            return '';
        }
        return implode($toDecollator, $accounts);
    }

    /**
     * 字符串转id
     * @param $user
     * @return void
     */
    public function stringToIds($user)
    {
        if ($user === 'all') {
            return UserModel::where('status_id', 1)
                ->column('id');
        }

        return explode(',', $user);
    }

    /**
     * 得到姓名
     * @param $id
     * @return mixed
     */
    public function getName($id)
    {
        return UserModel::where('id', $id)->value('name');
    }

    /**
     * 得到角色名串
     * @param $roleModels
     * @param $split
     * @return void
     */
    public function getRoleNameString($roleModels, $split = '，')
    {
        if ($roleModels->isEmpty()) {
            return '';
        }

        $names = [];
        foreach ($roleModels as $roleModel) {
            $names[] = $roleModel->name;
        }

        return implode($split, $names);
    }

    /**
     * 通过菜单key得到用户ids
     * @param $menuKey
     * @param $departmentIds
     * @return array
     */
    public function getUserIdsByMenuKey($menuKey, $departmentIds = []){
        $userIds = [];

        //角色id
        $roleIds = MenuModel::alias('m')
            ->leftJoin('role_menu rm', 'm.id = rm.menu_id')
            ->where('m.key', $menuKey)
            ->group('rm.role_id')
            ->column('rm.role_id');
        if(empty($roleIds)){
            return $userIds;
        }

        //用户id
        $query = UserModel::alias('u')
            ->leftJoin('user_role ur', 'u.id = ur.user_id')
            ->where('ur.role_id', 'in', $roleIds)
            ->where('u.status_id', 1)
            ->group('u.id');
        if(!empty($departmentIds)){
            $query = $query->where('u.department_id', 'in', $departmentIds);
        }
        $userIds = $query->column('u.id');

        return $userIds;
    }

    /**
     * 得到头像url
     * @param $path
     * @return string
     */
    public function getAvatarUrl($path)
    {
        if($path === ''){
            $path = 'avatar.png';
        }
        return Config::get('filesystem.access_prefix') . $path;
    }

    /**
     * 得到前端头像url
     * @param $path
     * @return string
     */
    public function getFrontAvatarUrl($path)
    {
        if($path === ''){
            $path = 'avatar.png';
        }
        return Config::get('filesystem.front_access_prefix') . $path;
    }
}