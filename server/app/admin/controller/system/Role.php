<?php

namespace app\admin\controller\system;

use app\admin\controller\Base;
use app\model\Role as RoleModel;
use app\validate\Role as RoleValidate;
use think\exception\ValidateException;

/**
 * 角色管理
 */
class Role extends Base
{

    /**
     * 得到首页角色
     */
    public function getIndexRoles()
    {
        $get = $this->request->get(['name' => '', 'size' => '30', 'page' => '1']);
        $wheres = [];
        if ($get['name'] !== '') {
            $wheres[] = ['name', 'LIKE', '%' . $get['name'] . '%'];
        }
        $roles = RoleModel::field('id,name')
            ->where($wheres)
            ->order('id', 'asc')
            ->paginate([
                'list_rows' => $get['size'],
                'page' => $get['page'],
            ]);
        return $this->success('获取成功', $roles);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['name']);

        // 验证
        try {
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        RoleModel::create($post);
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

        // 角色
        $roleModel = RoleModel::field('id,name')->find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $role = $roleModel->toArray();

        return $this->success('获取成功', $role);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'name']);

        // 验证
        try {
            validate(RoleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $roleModel = RoleModel::find($post['id']);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->save($post);

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

        $roleModel = RoleModel::find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->delete();

        return $this->success('删除成功');
    }
}
