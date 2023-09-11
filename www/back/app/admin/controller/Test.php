<?php

namespace app\admin\controller;

use app\helper\Captcha;

class Test extends Base
{
    public function index()
    {
        $message = new \app\helper\Message();
        $message->send('all', '消息提醒标题', '/system/loginLog');
        $message->send('all', '消息提醒标题', '/system/user');

    }
}
