<?php

namespace app\manage\controller\system;

use app\helper\manage\Jwt;
use app\helper\User as UserHelper;
use app\manage\controller\Base;
use app\manage\validate\User as UserValidate;
use app\model\Department as DepartmentModel;
use app\model\LoginLog as LoginLogModel;
use app\model\OperationLog as OperationLogModel;
use app\model\Role as RoleModel;
use app\model\User as UserModel;
use app\model\UserRole as UserRoleModel;
use sunqianhu\helper\ArrayHandler;
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
        //部门
        $departmentModels = DepartmentModel::field('id, id as value,department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDepartments = $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');

        //角色
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

        $query = UserModel::alias('u')
            ->leftJoin('user_role ur', 'u.id = ur.user_id')
            ->field('u.id,u.account,u.name,u.phone,u.status_id,u.add_time,u.department_id')
            ->with('department');
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
        $user = $paginate->toArray();

        return $this->success('获取成功', $user);
    }

    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        //部门
        $departmentModels = DepartmentModel::field('id, id as value,department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDepartments = $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');

        //角色
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

        //验证
        try {
            validate(UserValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        //账号
        $userModel = UserModel::where('account', $post['account'])->find();
        if (!empty($userModel)) {
            return $this->error('账号已经存在');
        }

        //手机号码
        $userModel = UserModel::where('phone', $post['phone'])->find();
        if (!empty($userModel)) {
            return $this->error('手机号码已经存在');
        }

        $post['password'] = md5($post['password']);
        $post['add_time'] = time();
        $userModel = new UserModel();
        $userModel->save($post);

        if (!empty($post['role_ids'])) {
            foreach($post['role_ids'] as $roleId){
                $userRoleModel = new UserRoleModel();
                $userRoleModel->save([
                    'user_id'=>$userModel->id,
                    'role_id'=>$roleId
                ]);
            }
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
            ->find($id);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }
        $user = $userModel->toArray();
        $user['role_ids'] = [];
        if (!empty($user['roles'])) {
            $user['role_ids'] = array_column($user['roles'], 'id');
        }

        //部门
        $departmentModels = DepartmentModel::field('id, id as value,department_id, name as label')
            ->order('sort', 'asc')
            ->select();
        $departments = $departmentModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeDepartments = $arrayHandler->convertTree($departments, 'id', 'department_id', 'children');

        //角色
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

        //验证
        try {
            validate(UserValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        //手机号码
        $userModel = UserModel::where('id', '<>', $post['id'])
            ->where('phone', '=', $post['phone'])
            ->find();
        if (!empty($userModel)) {
            return $this->error('手机号码已经存在');
        }

        //账号
        $userModel = UserModel::find($post['id']);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }

        $post['edit_time'] = time();
        $userModel->save($post);

        $oldRoleIds = array_column($userModel->roles->toArray(), 'id');
        $deleteRoleIds = array_unique(array_values(array_diff($oldRoleIds, $post['role_ids'])));
        $addRoleIds = array_unique(array_values(array_diff($post['role_ids'], $oldRoleIds)));
        if(!empty($deleteRoleIds)){
            foreach($deleteRoleIds as $deleteRoleId){
                $userRoleModel = UserRoleModel::where('user_id', $userModel->id)
                    ->where('role_id', $deleteRoleId)
                    ->findOrEmpty();
                $userRoleModel->delete();
            }
        }
        if(!empty($addRoleIds)) {
            foreach($addRoleIds as $addRoleId){
                $userRoleModel = new UserRoleModel();
                $userRoleModel->save([
                    'user_id'=>$userModel->id,
                    'role_id'=>$addRoleId
                ]);
            }
        }

        return $this->success('修改成功');
    }

    /**
     * 详情
     */
    public function detail()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $userModel = UserModel::field('id,account,name,phone,department_id,add_time,status_id,edit_time,login_time,login_ip')
            ->with(['roles', 'department'])
            ->find($id);
        $userModel->append(['status_name']);
        if (empty($userModel)) {
            return $this->error('没有找到记录');
        }

        $user = $userModel->toArray();
        $userHelper = new UserHelper();
        $user['role_name_string'] = $userHelper->getRoleNameString($userModel->roles, '，');

        //登录日志
        $loginLogModels = LoginLogModel::alias('ll')
            ->field('ll.*,u.name')
            ->leftJoin("user u", "ll.user_id = u.id")
            ->where('u.id', $userModel->id)
            ->order('ll.id', 'desc')
            ->limit(10)
            ->select();
        $loginLogs = $loginLogModels->toArray();

        //操作日志
        $operationLogModels = OperationLogModel::alias('ol')
            ->field('ol.*,u.name')
            ->leftJoin("user u", "ol.user_id = u.id")
            ->where('u.id', $userModel->id)
            ->order('ol.id', 'desc')
            ->limit(10)
            ->select();
        $operationLogs = $operationLogModels->toArray();

        $data = [
            'user' => $user,
            'login_logs'=>$loginLogs,
            'operation_logs'=>$operationLogs
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 修改状态
     */
    function editStatus()
    {
        $post = $this->request->post(['id', 'status_id' => 0]);

        //验证
        try {
            validate(UserValidate::class)->scene('edit_status')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $userModel = UserModel::find($post['id']);
        if(empty($userModel)){
            return $this->error('没有找到用户记录');
        }
        $userModel->save($post);

        return $this->success('修改成功');
    }

    /**
     * 修改密码
     */
    public function editPassword()
    {

        $post = $this->request->post(['id', 'password1', 'password2']);

        try {
            validate(UserValidate::class)->scene('edit_password')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $userModel = UserModel::find($post['id']);
        if(empty($userModel)){
            return $this->error('没有找到用户记录');
        }
        $userModel->password = md5($post['password1']);
        $userModel->save();

        return $this->success('修改成功');
    }

    /**
     * 踢下线
     */
    function offLine()
    {
        $post = $this->request->post(['id']);

        //验证
        try {
            validate(UserValidate::class)->scene('offline')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $jwt = new Jwt();
        $jwt->deleteToken($post['id']);

        return $this->success('操作成功');
    }
}