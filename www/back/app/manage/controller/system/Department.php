<?php

namespace app\manage\controller\system;

use app\helper\ArrayHandler;
use app\helper\Dictionary as DictionaryHelper;
use app\manage\controller\Base;
use app\manage\validate\Department as DepartmentValidate;
use app\model\Department as DepartmentModel;
use think\exception\ValidateException;

/**
 * 部门管理
 */
class Department extends Base
{

    /**
     * 得到首页部门
     */
    public function getIndexDepartments()
    {
        $get = $this->request->get(['name']);

        $query = DepartmentModel::field('id,department_id,type_id,name,sort');
        if (isset($get['name'])) {
            $query = $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query = $query->order('sort', 'asc');
        $query->append(['type_name']);
        $departmentModels = $query->select();
        $departments = $departmentModels->toArray();

        $arr = new ArrayHandler();
        $treeDepartments = $arr->convertTree($departments, 'id', 'department_id', 'children');

        return $this->success('获取成功', $treeDepartments);
    }

    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        $departmentModels = DepartmentModel::field('id, id as value, department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();

        $arr = new ArrayHandler();
        $treeDepartments = $arr->convertTree($departments, 'id', 'department_id', 'children');

        $dictionaryHelper = new DictionaryHelper();
        $types = $dictionaryHelper->getList('department_type');

        $data = [
            'tree_departments'=>$treeDepartments,
            'types'=>$types
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['department_id' => 0, 'type_id', 'name', 'sort']);

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
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        // 部门
        $departmentModel = DepartmentModel::field('id,name,department_id,type_id,sort')->find($id);
        if (empty($departmentModel)) {
            return $this->error('没有找到记录');
        }
        $department = $departmentModel->toArray();

        // 树形部门
        $departmentModels = DepartmentModel::field('id, id as value, department_id, type_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arr = new ArrayHandler();
        $treeDepartments = $arr->convertTree($departments, 'id', 'department_id', 'children');

        $dictionaryHelper = new DictionaryHelper();
        $types = $dictionaryHelper->getList('department_type');

        $data = [
            'tree_departments' => $treeDepartments,
            'department' => $department,
            'types'=>$types
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'department_id' => 0, 'type_id', 'name', 'sort']);
        if (!$post['department_id']) {
            $data['department_id'] = 0;
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

        // 子部门
        $departmentModel = DepartmentModel::where('department_id', $id)->find();
        if (!empty($departmentModel)) {
            return $this->error('该部门下存在子部门，不能删除');
        }

        $departmentModel = DepartmentModel::find($id);
        if(empty($departmentModel)){
            return $this->error('没有找到记录');
        }
        $departmentModel->delete();

        return $this->success('删除成功');
    }
}
