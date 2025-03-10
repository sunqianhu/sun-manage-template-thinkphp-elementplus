<?php

namespace app\manage\controller\system;

use app\manage\controller\Base;
use app\manage\validate\Config as ConfigValidate;
use app\helper\Config as ConfigHelper;
use think\exception\ValidateException;

/**
 * 系统设置
 */
class Config extends Base
{
    /**
     * 初始化
     * @return mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function init()
    {
        $configHelper = new ConfigHelper();
        $config = [
            'version'=>$configHelper->getValue('version')
        ];
        $data = [
            'config' => $config
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存
     */
    public function save()
    {
        $post = $this->request->post(['version']);

        //验证
        try {
            validate(ConfigValidate::class)->scene('save')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $configHelper = new ConfigHelper();
        foreach($post as $key => $value){
            $configHelper->setValue($key, $value);
        }

        return $this->success('保存成功');
    }
}