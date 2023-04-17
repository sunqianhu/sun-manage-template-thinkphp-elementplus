<?php
namespace app\api\controller;

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
        return $this->error("账号已停用");
    }

}
