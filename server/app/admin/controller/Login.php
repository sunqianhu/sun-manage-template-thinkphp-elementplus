<?php

namespace app\admin\controller;

use think\Exception;
use think\exception\ValidateException;
use app\validate\Login as LoginValidate;
use app\model\User as UserModel;
use app\library\Jwt;

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
        throw new Exception('ssss');
        exit;
        $wheres = [
            ['account', '=', $post['account']],
            ['password', '=', md5($post['password'])]
        ];
        $userModel = UserModel::where($wheres)->field('id,status_id,name,phone,avatar')->find();
        if (empty($userModel)) {
            return $this->error('账号或密码错误');
        }
        if ($userModel->status_id == 2) {
            return $this->error("账号已停用");
        }

        $jwt = new Jwt();
        $payload = [
            'id' => $userModel->id,
            'name' => $userModel->name,
            'time' => time()
        ];
        $token = $jwt->getToken($payload);

        $data = [
            'token' => $token
        ];
        return $this->success("登录成功", $data);
    }
}
