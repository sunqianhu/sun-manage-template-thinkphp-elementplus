<?php

namespace app\manage\validate;

use think\Validate;

class Login extends Validate
{
    protected $rule = [
        'account'  =>  'require',
        'password' =>  'require|min:6',
        'captcha_token'=>'require',
        'captcha_code'=>'require'
    ];
    protected $message = [
        'account.require' => '账号不能为空',
        'password.require' => '密码不能为空',
        'password.min' => '密码长度最少6位',
        'captcha_token.require' => '请初始化验证码',
        'captcha_code.require' => '验证码不能为空'
    ];
    protected $scene = [
        'login' => ['account', 'password', 'captcha_token', 'captcha_code']
    ];
}
