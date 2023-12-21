<?php

namespace app\helper;

use app\model\User as UserModel;

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
            return UserModel::where('status_id', '=', 1)->column('id');
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
        if($roleModels->isEmpty()){
            return '';
        }

        $names = [];
        foreach($roleModels as $roleModel){
            $names[] = $roleModel->name;
        }
        
        return implode($split, $names);
    }
}