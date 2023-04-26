<?php

namespace app\admin\controller;

use think\App;
use think\Response;
use app\BaseController;
use app\library\Auth;
use app\library\Jwt;

/**
 * 基控制器
 */
class Base extends BaseController
{
    public $userId = 0; // 用户id

    /**
     * 初始化
     * @return void
     */
    function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub

        $auth = new Auth();

        // 登录
        if (!$auth->isLogin()) {
            $this->error('请登录系统')->send();
            exit;
        }

        // 权限
        if (!$auth->isPermission()) {
            $this->error('无权限')->send();
            exit;
        }

        try {
            $jwtUser = $auth->getJwtUser();
            $this->userId = $jwtUser->id;
        } catch (\Exception $e) {

        }
    }

    /**
     * 成功响应
     * @param string $message 提示消息
     * @param mixed $data 返回数据
     */
    public function success(string $message, $data = null)
    {
        $result = [
            'code' => 1,
            'msg' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }

    /**
     * 失败响应
     * @param string $message 提示消息
     * @param mixed $data 返回数据
     */
    public function error(string $message, $data = null)
    {
        $result = [
            'code' => 0,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }
}
