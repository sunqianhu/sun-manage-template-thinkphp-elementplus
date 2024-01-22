<?php

namespace app\manage\validate;

use think\Validate;

class Login extends Validate
{
    protected $rule = [
        'account'  =>  'require',
        'password' =>  'require|min:6'
    ];
    protected $message = [
        'account.require' => '账号不能为空',
        'password.require' => '密码不能为空',
        'password.min' => '密码长度最少6位'
    ];
    protected $scene = [
        'login' => ['account', 'password']
    ];
}