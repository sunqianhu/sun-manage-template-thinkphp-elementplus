<?php

namespace app\validate\system;

use think\Validate;

class Menu extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'parent_id'  =>  'require|number',
        'type_id'  =>  'require|number',
        'name'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是个数字',
        'parent_id.require' => '请选择所属部门',
        'parent_id.number' => '所属部门参数必须是个数字',
        'type_id.require' => '请选择菜单类型',
        'type_id.number' => '菜单类型必须是个数字',
        'name.require' => '请输入菜单名称',
        'sort.require' => '请输入排序',
        'sort.number' => '排序必须是一个数字',
    ];
    protected $scene = [
        'add' => ['type_id', 'name', 'sort'],
        'edit' => ['id', 'type_id', 'name', 'sort'],
        'delete' => ['id']
    ];
}
