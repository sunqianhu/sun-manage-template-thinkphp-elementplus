<?php

namespace app\validate\system;

use think\Validate;

class Department extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'parent_id'  =>  'require|number',
        'name'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是个数字',
        'parent_id.require' => '请选择所属部门',
        'parent_id.number' => '所属部门必须是个数字',
        'name.require' => '请输入部门名称',
        'sort.require' => '请输入排序',
        'sort.number' => '排序必须是一个数字',
    ];
    protected $scene = [
        'add' => ['parent_id', 'name', 'sort'],
        'edit' => ['id', 'parent_id', 'name', 'sort'],
        'delete' => ['id']
    ];
}
