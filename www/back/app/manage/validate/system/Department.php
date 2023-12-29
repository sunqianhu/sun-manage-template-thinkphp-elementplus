<?php

namespace app\manage\validate\system;

use think\Validate;

class Department extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'department_id'  =>  'require|number',
        'type_id'  =>  'require|number',
        'name'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'department_id.require' => '所属部门不能为空',
        'department_id.number' => '所属部门必须是数字',
        'type_id.require' => '部门类型不能为空',
        'type_id.number' => '部门类型必须是数字',
        'name.require' => '部门名称不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['type_id', 'name', 'sort'],
        'edit' => ['id', 'type_id', 'name', 'sort'],
        'delete' => ['id']
    ];
}
