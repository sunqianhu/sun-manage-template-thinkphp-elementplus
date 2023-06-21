<?php

namespace app\helper;

use think\facade\Config;

class File
{
    /**
     * 得到访问url
     * @param string $path 路径
     */
    public function getUrl($path)
    {
        return Config::get('filesystem.access_prefix').$path;
    }
}