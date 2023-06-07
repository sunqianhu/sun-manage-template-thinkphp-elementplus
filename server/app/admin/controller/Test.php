<?php

namespace app\admin\controller;

use app\library\Captcha;

class Test extends Base
{
    public function index()
    {
        $captcha = new Captcha();
        $image = $captcha->create('1ade',100, 35);
        $base64Image = $captcha->getBase64($image);


    }
}
