<?php
namespace app\helper;

use app\model\Config as ConfigModel;

class Config
{
    /**
     * 获取配置
     * @return array
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getValue($field)
    {
        return ConfigModel::where('id', 1)->column($field);
    }
}