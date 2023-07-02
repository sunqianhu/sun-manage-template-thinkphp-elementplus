<?php

namespace app\admin\controller;

use app\admin\validate\Dictionary as DictionaryValidate;
use app\model\Dictionary as DictionaryModel;
use think\exception\ValidateException;

/**
 * 字典管理
 */
class Dictionary extends Base
{

    /**
     * 得到首页字典
     */
    public function getIndexDictionarys()
    {
        $get = $this->request->get(['type' => '', 'key' => '', 'value' => '', 'size' => '30', 'page' => '1']);
        $wheres = [];
        if ($get['type'] !== '') {
            $wheres[] = ['type', 'LIKE', '%' . $get['type'] . '%'];
        }
        if ($get['key'] !== '') {
            $wheres[] = ['key', 'LIKE', '%' . $get['key'] . '%'];
        }
        if ($get['value'] !== '') {
            $wheres[] = ['value', 'LIKE', '%' . $get['value'] . '%'];
        }
        $dictionarys = DictionaryModel::field('id,type,key,value,sort')
            ->where($wheres)
            ->order([
                'type' => 'asc',
                'sort' => 'asc'
            ])
            ->paginate([
                'list_rows' => $get['size'],
                'page' => $get['page'],
            ]);
        return $this->success('获取成功', $dictionarys);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['type', 'key', 'value', 'sort']);

        // 验证
        try {
            validate(DictionaryValidate::class)->scene('add')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        DictionaryModel::create($post);
        return $this->success('添加成功');
    }

    /**
     * 初始化修改
     *
     * @return void
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        // 部门
        $dictionaryModel = DictionaryModel::field('id,type,key,value,sort')->find($id);
        if (empty($dictionaryModel)) {
            return $this->error('没有找到记录');
        }
        $dictionary = $dictionaryModel->toArray();

        return $this->success('获取成功', $dictionary);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'type', 'key', 'value', 'sort']);

        // 验证
        try {
            validate(DictionaryValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $dictionaryModel = DictionaryModel::find($post['id']);
        if (empty($dictionaryModel)) {
            return $this->error('没有找到记录');
        }
        $dictionaryModel->save($post);

        return $this->success('修改成功');
    }

    /**
     * 删除
     *
     * @return void
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $dictionaryModel = DictionaryModel::find($id);
        if (empty($dictionaryModel)) {
            return $this->error('没有找到记录');
        }
        $dictionaryModel->delete();

        return $this->success('删除成功');
    }
}
