<?php

namespace app\manage\controller\system;

use app\manage\controller\Base;
use app\manage\validate\system\Config as ConfigValidate;
use app\model\Config as ConfigModel;

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
        $configModel = ConfigModel::field('*')
            ->find(1);
        $config = $configModel->toArray();

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

        // 验证
        try {
            validate(ConfigValidate::class)->scene('save')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $configModel = ConfigModel::find(1);
        if (empty($configModel)) {
            return $this->error('没有找到记录');
        }

        $configModel->save($post);
        return $this->success('保存成功');
    }
}
