<?php
namespace app\api\controller;

use app\helper\Jwt;

class Test extends Base
{
    public function index()
    {
        $jwt = new Jwt();
        $aa = $jwt->resolverToken('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6OCwibmFtZSI6ImZkc2YiLCJwaG9uZSI6IjE1MTA4MjczNTc2In0.GXynGWKXe3OeSr4BkbktSnTvvvP1RVB35PqoRgEmJ50');

        var_dump($aa);
    }

}
