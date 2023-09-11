<?php

namespace app\manage\validate;

use think\Validate;

class Menu extends Validate
{
    protected $rule = [
        'id'  =>  'require|number',
        'menu_id'  =>  'require|number',
        'type_id'  =>  'require|number',
        'name'  =>  'require',
        'key'  =>  'require',
        'sort'  =>  'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'menu_id.require' => '上级菜单不能为空',
        'menu_id.number' => '上级菜单必须是数字',
        'type_id.require' => '菜单类型不能为空',
        'type_id.number' => '菜单类型必须是数字',
        'name.require' => '菜单名称不能为空',
        'key.require' => '菜单key不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['type_id', 'name', 'key', 'sort'],
        'edit' => ['id', 'type_id', 'name', 'key', 'sort'],
        'delete' => ['id']
    ];
}