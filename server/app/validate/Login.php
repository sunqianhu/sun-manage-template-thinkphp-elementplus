<?php

namespace app\validate;

use think\Validate;

class Login extends Validate
{
    protected $rule = [
        'account'  =>  'require',
        'password' =>  'require|min:6'
    ];
    protected $message = [
        'account.require' => '请输入账号',
        'password.require' => '请输入密码',
        'password.min' => '密码长度最少6位'
    ];
    protected $scene = [
        'add' => ['login']
    ];
}
