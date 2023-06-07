<?php

namespace app\admin\controller;

use app\library\Captcha;

class Test extends Base
{
    public function index()
    {
        echo $this->request->ip();

    }
}
