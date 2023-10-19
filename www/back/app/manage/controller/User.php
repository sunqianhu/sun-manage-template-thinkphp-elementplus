<?php

namespace app\manage\controller;

use app\manage\validate\User as UserValidate;
use app\helper\ArrayHandler;
use app\model\Department as DepartmentModel;
use app\model\Role as RoleModel;
use app\model\Token as TokenModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use think\exception\ValidateException;

/**
 * 用户管理
 */
class User extends Base
{

    /**
     * 初始化首页
     */
    public function initIndex()
    {
        // 部门
        $departmentModels = DepartmentModel::field('id, id as value,department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arr = new ArrayHandler();
        $treeDepartments = $arr->convertTree($departments, 'id', 'department_id', 'children');

        // 角色
        $roleModels = RoleModel::field('id,name')->select();
        $roles = $roleModels->toArray();

        $data = [
            'departments' => $treeDepartments,
            'roles' => $roles
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 获取首页用户
     */
    public function getIndexUsers()
    {
        $get = $this->request->get(['department_id', 'role_id', 'account', 'name', 'phone', 'size' => 30, 'page' => 1]);

        $query = UserModel::field('u.id,u.account,u.name,u.phone,u.status_id,u.add_time,u.department_id')
            ->with('department')
            ->alias('u')
            ->leftJoin('user_role ur', 'u.id = ur.user_id');
        if (!empty($get['department_id'])) {
            $query = $query->where('u.department_id', '=', $get['department_id']);
        }
        if (!empty($get['role_id'])) {
            $query = $query->where('ur.role_id', '=', $get['role_id']);
        }
        if (isset($get['account']) && $get['account'] !== '') {
            $query = $query->where('u.account', 'LIKE', '%' . $get['account'] . '%');
        }
        if (isset($get['name']) && $get['name'] !== '') {
            $query = $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if (isset($get['phone']) && $get['phone'] !== '') {
            $query = $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query = $query->group('u.id')
            ->order('u.id', 'desc');
        $paginate = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page']
        ]);
        $data = $paginate->toArray();

        return $this->success('获取成功', $data);
    }

    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        // 部门
        $departmentModels = DepartmentModel::field('id, id as value,department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arr = new ArrayHandler();
        $treeDepartments = $arr->convertTree($departments, 'id', 'department_id', 'children');

        // 角色
        $roleModels = RoleModel::field('id,name')->select();
        $roles = $roleModels->toArray();

        $data = [
            'departments' => $treeDepartments,
            'roles' => $roles
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['account', 'password', 'name', 'phone', 'department_id', 'role_ids', 'status_id']);

        // 验证
        try {
            validate(UserValidate::class)->scene('add')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        // 账号
        $userModel = UserModel::where('account', $post['account'])->find();
        if (!empty($userModel)) {
            return $this->error('账号已经存在');
        }

        // 手机号码
        $userModel = UserModel::where('phone', $post['phone'])->find();
        if (!empty($userModel)) {
            return $this->error('手机号码已经存在');
        }

        $post['password'] = md5($post['password']);
        $post['add_time'] = time();
        $userModel = UserModel::create($post);

        if (!empty($post['role_ids'])) {
            $userRoleBelongsToMany = $userModel->roles();
            $userRoleBelongsToMany->attach($post['role_ids']);
        }

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

        $userModel = UserModel::field('id,name,phone,department_id')
            ->with('roles')
            //->fetchSql(true)
            ->find($id);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }
        $user = $userModel->toArray();
        $user['role_ids'] = [];
        if (!empty($user['roles'])) {
            $user['role_ids'] = array_column($user['roles'], 'id');
        }

        // 部门
        $departmentModels = DepartmentModel::field('id, id as value,department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arr = new ArrayHandler();
        $treeDepartments = $arr->convertTree($departments, 'id', 'department_id', 'children');

        // 角色
        $roleModels = RoleModel::field('id,name')->select();
        $roles = $roleModels->toArray();

        $data = [
            'user' => $user,
            'departments' => $treeDepartments,
            'roles' => $roles
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'name', 'phone', 'department_id', 'role_ids']);

        // 验证
        try {
            validate(UserValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        // 手机号码
        $wheres = [
            ['id', '<>', $post['id']],
            ['phone', '=', $post['phone']],
        ];
        $userModel = UserModel::where($wheres)->find();
        if (!empty($userModel)) {
            return $this->error('手机号码已经存在');
        }

        // 账号
        $userModel = UserModel::find($post['id']);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }

        $post['edit_time'] = time();
        $userModel->save($post);

        UserRoleModel::where('user_id', $userModel->id)->delete();
        if (!empty($post['role_ids'])) {
            $userRoleBelongsToMany = $userModel->roles();
            $userRoleBelongsToMany->attach($post['role_ids']);
        }

        return $this->success('修改成功');
    }

    /**
     * 修改状态
     */
    function editStatus()
    {
        $post = $this->request->post(['id', 'status_id' => 0]);

        // 验证
        try {
            validate(UserValidate::class)->scene('editStatus')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        UserModel::update($post);
        return $this->success('修改成功');
    }

    /**
     * 修改密码
     */
    public function editPassword()
    {

        $post = $this->request->post(['id', 'password1', 'password2']);

        try {
            validate(UserValidate::class)->scene('editPassword')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $post['password'] = md5($post['password1']);
        unset($post['password1']);
        unset($post['password2']);
        UserModel::update($post);

        return $this->success('修改成功');
    }

    /**
     * 踢下线
     */
    function offLine()
    {
        $post = $this->request->post(['id']);

        // 验证
        try {
            validate(UserValidate::class)->scene('offLine')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        TokenModel::where('user_id', $post['id'])->delete();
        return $this->success('操作成功');
    }
}
