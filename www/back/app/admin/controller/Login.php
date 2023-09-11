<?php

namespace app\admin\controller;

use app\admin\validate\Login as LoginValidate;
use app\entity\User as UserEntity;
use app\helper\AdminJwt;
use app\helper\Captcha;
use app\model\LoginLog as LoginLogModel;
use app\model\User as UserModel;
use think\exception\ValidateException;
use think\facade\Cache;

/**
 * 登录
 */
class Login extends Base
{
    /**
     * 得到验证码
     * @return void
     */
    public function getCaptcha()
    {
        $token = time() . rand(10000, 99999);

        $captcha = new Captcha();
        $image = $captcha->createBase64Image();
        $code = $captcha->getCode();

        Cache::set('captcha_' . $token, $code, 600);

        $data = [
            'token' => $token,
            'image' => $image
        ];
        return $this->success("获取成功", $data);
    }

    /**
     * 登录
     * @return string
     */
    public function login()
    {
        $post = $this->request->post(['account' => '', 'password' => '', 'captcha_token' => '', 'captcha_code' => '']);

        // 验证
        try {
            validate(LoginValidate::class)->scene('login')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $cacheCaptchaCode = Cache::get('captcha_' . $post['captcha_token']);
        if (strtolower($post['captcha_code']) != strtolower($cacheCaptchaCode)) {
            Cache::delete('captcha_' . $post['captcha_token']);
            return $this->error('验证码错误');
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

        $adminJwt = new AdminJwt();
        $userEntity = new UserEntity();
        $userEntity->setId($userModel->id);
        $userEntity->setName($userModel->name);
        $userEntity->setDepartmentId($userModel->department_id);
        $token = $adminJwt->getToken($userEntity);

        Cache::delete('captcha_' . $post['captcha_token']);
        $data = [
            'user_id'=>$userModel->id,
            'time'=>time(),
            'ip'=>$this->request->ip()
        ];
        LoginLogModel::create($data);

        $data = [
            'token' => $token,
            'user_id' => $userModel->id
        ];
        return $this->success("登录成功", $data);
    }
}
