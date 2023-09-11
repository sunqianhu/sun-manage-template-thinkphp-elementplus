<?php

namespace app\model;

use think\Model;

class Menu extends Model
{
    /**
     * 获取接口地址
     * @param $value
     * @return string
     */
    public function getApisAttr($value)
    {
        return explode("\r\n", $value);
    }
}
