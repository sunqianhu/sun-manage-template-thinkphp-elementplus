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
        return ConfigModel::where('id', 1)->value($field);
    }

    /**
     * 设置配置
     * @param $field
     * @param $value
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function setValue($field, $value){
        $configModel = ConfigModel::find(1);
        $configModel->$field = $value;
        $configModel->save();
    }
}