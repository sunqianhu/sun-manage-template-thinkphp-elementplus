<?php

namespace app\admin\controller;

use app\library\Message;

class Test extends Base
{
    public function index()
    {
        $message = new Message();
        $data = [
            'type' => 'type',
            'title' => '标题',
            'url' => 'http://www.baidu.com'
        ];
        $message->send('1,2,3', $data);
    }

}
