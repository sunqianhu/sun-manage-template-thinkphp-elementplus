<?php

namespace app\manage\validate;

use think\Validate;

class User extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'account'  =>  'require',
        'password' =>  'require|min:6',
        'name' =>  'require',
        'phone' =>  'require|mobile',
        'department_id'=>'require|number',
        'role_ids'=>'array',
        'status_id' =>  'require',
        'password1' =>  'require|min:6',
        'password2' =>  'require|confirm:password1',
    ];
    protected $message = [
        'id.require' => 'id参数错误',
        'id.number' => 'id必须是数字',
        'account.require' => '账号不能为空',
        'password.require' => '密码不能为空',
        'password.min' => '密码最少6位',
        'name.require' => '姓名不能为空',
        'phone.require' => '手机号码不能为空',
        'phone.mobile' => '手机号码无效',
        'department_id.require' => '所属部门不能为空',
        'department_id.number' => '所属部门必须是数字',
        'role_ids.array' => '角色必须是数组',
        'status_id.require' => '请选择状态',
        'password1.require' => '新密码不能为空',
        'password1.min' => '新密码最少6位',
        'password2.require' => '确认新密码不能为空',
        'password2.confirm' => '两次输入密码不相同',
    ];
    protected $scene = [
        'add' => ['account', 'password', 'name', 'phone', 'department_id', 'role_ids', 'status_id'],
        'edit' => ['id', 'name', 'phone', 'department_id', 'role_ids'],
        'editStatus' => ['id', 'status_id'],
        'editPassword' => ['id', 'password1', 'password2'],
        'offLine' => ['id']
    ];
}
