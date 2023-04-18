<?php

namespace app\helper;

use think\Exception;
use think\facade\Request;

/**
 * 鉴权
 */
class Auth
{

    private $noLoginUrls = [
        '/admin/login/login',
        '/admin/test/index'
    ];
    public $jwtUser;

    /**
     * 得到jwt用户
     * @return \app\object\JwtUser
     */
    function getJwtUser(){
        if(!empty($this->jwtUser)){
            return $this->jwtUser;
        }

        $token = Request::header('token', '');
        if(empty($token)){
            throw new \Exception('没有获取到token');
        }

        $jwt = new Jwt();
        $this->jwtUser = $jwt->resolverToken($token);

        return $this->jwtUser;
    }

    /**
     * 是登录
     * @return boolean 是否
     */
    function isLogin()
    {
        $url = Request::baseUrl();
        $url = strtolower($url);
        if(in_array($url, $this->noLoginUrls)){
            return true;
        }

        try {
            $this->getJwtUser();
        } catch (\Exception $e) {
            return false;
        }

        return true;
    }

    /**
     * 有权限
     * @return boolean 是|否
     */
    function isPermission()
    {
        return true;
    }
}