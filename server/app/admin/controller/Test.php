<?php
namespace app\admin\controller;

use app\library\Message;

class Test extends Base
{
    public function index()
    {
        $message = new Message();
        $message->send('1', 'message');


    }

}
