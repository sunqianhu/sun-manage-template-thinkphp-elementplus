<?php
namespace app\admin\controller;

use app\BaseController;

class Index extends BaseController
{
    public function index()
    {
        return 'index';
    }

    public function test()
    {
//return json(["xxxx"],1);
  //throw new \think\Exception('异常消息', 10006);
  abort(404, "sss");
    }
}
