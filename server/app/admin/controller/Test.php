<?php
namespace app\admin\controller;

class Test extends Base
{
    public function index()
    {

        echo $this->request->url();
    }

}
