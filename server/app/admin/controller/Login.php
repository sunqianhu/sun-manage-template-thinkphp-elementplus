<?php

namespace app\admin\controller;

use app\admin\library\Jwt;
use app\entity\User as UserEntity;
use app\model\User as UserModel;
use app\validate\Login as LoginValidate;
use think\exception\ValidateException;

/**
 * 登录
 */
class Login extends Base
{
    /**
     * 登录
     * @return string
     */
    public function login()
    {
        $post = $this->request->post(['account' => '', 'password' => '']);

        // 验证
        try {
            validate(LoginValidate::class)->scene('login')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $wheres = [
            ['account', '=', $post['account']],
            ['password', '=', md5($post['password'])]
        ];
        $userModel = UserModel::where($wheres)
            ->field('id,department_id,status_id,name,phone,avatar')
            ->find();
        if (empty($userModel)) {
            return $this->error('账号或密码错误');
        }
        if ($userModel->status_id == 2) {
            return $this->error("账号已停用");
        }

        $jwt = new Jwt();
        $userEntity = new UserEntity();
        $userEntity->setId($userModel->id);
        $userEntity->setName($userModel->name);
        $userEntity->setDepartmentId($userModel->department_id);
        $token = $jwt->getToken($userEntity);

        $data = [
            'token' => $token,
            'user_id' => $userModel->id
        ];
        return $this->success("登录成功", $data);
    }
}
