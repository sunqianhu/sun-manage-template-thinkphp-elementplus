<?php

namespace app\admin\controller\system;

use app\admin\controller\Base;
use app\validate\system\Department as DepartmentValidate;
use app\model\Department as DepartmentModel;
use think\exception\ValidateException;
use app\library\Tree;
use Error;
use Exception;

/**
 * 部门管理
 */
class Department extends Base
{

    /**
     * 首页
     *
     * @return void
     */
    public function index()
    {
        $get = $this->request->get(['name']);
        $where = [];
        if (isset($get['name'])) {
            $where[] = ['name', 'LIKE', '%' . $get['name'] . '%'];
        }

        $departmentModels = DepartmentModel::field('id,parent_id,name,sort')
            ->where($where)
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();

        $tree = new Tree();
        $treeDepartments = $tree->convertTree($departments, 'id', 'parent_id', 'children');

        return $this->success('获取成功', $treeDepartments);
    }

    /**
     * 初始化添加页面
     *
     * @return void
     */
    public function initAdd()
    {
        $departmentModels = DepartmentModel::field('id, id as value, parent_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();

        $tree = new Tree();
        $treeDepartments = $tree->convertTree($departments, 'id', 'parent_id', 'children');

        return $this->success('获取成功', $treeDepartments);
    }

    /**
     * 保存添加
     *
     * @return void
     */
    public function saveAdd()
    {
        $post = $this->request->post(['parent_id' => 0, 'name', 'sort']);

        // 验证
        try {
            validate(DepartmentValidate::class)->scene('add')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        DepartmentModel::create($post);
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
        $departmentModel = DepartmentModel::field('id,name,parent_id,sort')->find($id);
        if (empty($departmentModel)) {
            return $this->error('没有找到记录');
        }
        $department = $departmentModel->toArray();

        // 树形部门
        $departmentModels = DepartmentModel::field('id, id as value, parent_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $tree = new Tree();
        $treeDepartments = $tree->convertTree($departments, 'id', 'parent_id', 'children');

        $data = [
            'treeDepartments' => $treeDepartments,
            'department' => $department
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     *
     * @return void
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'parent_id' => 0, 'name', 'sort']);
        if (!$post['parent_id']) {
            $data['parent_id'] = 0;
        }

        // 验证
        try {
            validate(DepartmentValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        DepartmentModel::update($post);

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
        // 手机号码
        $departmentModel = DepartmentModel::where('parent_id', $id)->find();
        if (!empty($departmentModel)) {
            return $this->error('该部门下存在子部门，不能删除');
        }

        DepartmentModel::destroy($id);
        return $this->success('删除成功');
    }
}
