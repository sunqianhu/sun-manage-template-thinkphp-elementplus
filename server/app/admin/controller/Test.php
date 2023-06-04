<?php
namespace app\admin\controller;

use app\library\Message;

class Test extends Base
{
    public function index()
    {
        $message = new Message();
        $clientMessage = [
            'type'=>'type',
            'data'=>['title'=>'标题','url'=>'http://www.baidu.com']
        ];
        $message->send('all', $clientMessage);
    }

}
