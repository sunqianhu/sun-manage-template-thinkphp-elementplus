<?php
namespace app\helper;

use app\model\Runtime as RuntimeModel;

class Runtime
{
    /**
     * 得知值
     * @param $key 键
     * @return mixed
     */
    public function getValue($key)
    {
        return RuntimeModel::where('key', $key)->value('value');
    }

    /**
     * 设置值
     * @param $key 键
     * @param $value 值
     * @return void
     */
    public function setValue($key, $value){
        $configModel = RuntimeModel::where('key', $key)->find();
        if($configModel == null){
            $configModel = new RuntimeModel();
        }
        $configModel->key = $key;
        $configModel->value = $value;
        $configModel->save();
    }
}