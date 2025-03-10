<?php

namespace app\manage\controller;

use app\entity\User as UserEntity;
use app\helper\LoginFailChecker;
use app\helper\manage\Jwt;
use app\manage\validate\Login as LoginValidate;
use app\model\LoginLog as LoginLogModel;
use app\model\User as UserModel;
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

        //验证
        try {
            validate(LoginValidate::class)->scene('login')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        //登录次数
        $loginFailChecker = new LoginFailChecker($post['account']);
        if(!$loginFailChecker->check()){
            return $this->error('连续登录失败'.$loginFailChecker->number.'次，请'.$loginFailChecker->getResetReadableTime().'后再试');
        }

        $userModel = UserModel::where('account', $post['account'])
            ->where('password', md5($post['password']))
            ->field('id,department_id,status_id,name,phone,avatar')
            ->find();
        if (empty($userModel)) {
            $loginFailChecker->setFail();
            $availableNumber = $loginFailChecker->getAvailableNumber();
            if($availableNumber > 0){
                return $this->error('账号或密码错误，还能再试'.$availableNumber.'次');
            }else{
                return $this->error('账号或密码错误，连续登录失败'.$loginFailChecker->number.'次，请'.$loginFailChecker->getResetReadableTime().'后再试');
            }
        }
        $loginFailChecker->resetFail();

        if ($userModel->status_id == 2) {
            return $this->error("账号已停用");
        }

        $jwt = new Jwt();
        $userEntity = new UserEntity();
        $userEntity->setId($userModel->id);
        $userEntity->setName($userModel->name);
        $userEntity->setDepartmentId($userModel->department_id);
        $token = $jwt->getToken($userEntity);

        $userModel->login_time = time();
        $userModel->login_ip = $this->request->ip();
        $userModel->save();

        $data = [
            'user_id' => $userModel->id,
            'time' => time(),
            'ip' => $this->request->ip()
        ];
        $loginLogModel = new LoginLogModel();
        $loginLogModel->save($data);

        $data = [
            'token' => $token,
            'user_id' => $userModel->id
        ];
        return $this->success("登录成功", $data);
    }

    /**
     * 退出
     * @return void
     */
    public function logout()
    {
        $userModel = UserModel::find($this->user->id);
        $jwt = new Jwt();
        $jwt->deleteToken($userModel->id);

        return $this->success("退出成功");
    }
}