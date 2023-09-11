<?php

namespace app\manage\controller;

use app\manage\validate\User as UserValidate;
use app\model\User as UserModel;
use think\exception\ValidateException;

/**
 * 个人中心
 */
class My extends Base
{
    /**
     * 账号信息
     */
    public function info()
    {
        $userModel = UserModel::field('id,account,name,phone,login_time,login_ip,department_id')
            ->find($this->user->id);
        $user = $userModel->toArray();
        $user['department_name'] = $userModel->department->name;
        return $this->success('获取成功', $user);
    }

    /**
     * 修改密码
     */
    public function editPassword()
    {

        $post = $this->request->post(['password1', 'password2']);
        $post['id'] = $this->user->id;

        try {
            validate(UserValidate::class)->scene('editPassword')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $post['password'] = md5($post['password1']);
        unset($post['password1']);
        unset($post['password2']);
        UserModel::update($post);

        return $this->success('修改成功');
    }
}
