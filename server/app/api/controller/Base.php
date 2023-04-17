<?php

namespace app\api\controller;

use think\Response;
use app\BaseController;

/**
 * 基控制器
 */
class Base extends BaseController
{
    /**
     * 响应成功
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
     * 响应失败
     * @param string $message 提示消息
     * @param mixed $data 返回数据
     */
    public function error(string $message, $data = null)
    {
        $result = [
            'code' => 0,
            'msg' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }
}
