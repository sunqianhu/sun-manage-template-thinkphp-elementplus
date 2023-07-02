<?php

namespace app\admin\validate;

use think\Validate;

class Dictionary extends Validate
{
    protected $rule = [
        'id' => 'require|number',
        'type' => 'require',
        'name' => 'require',
        'value' => 'require',
        'sort' => 'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'type.require' => '字典类型不能为空',
        'name.require' => '字典名称不能为空',
        'value.require' => '字典值不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['type', 'name', 'value', 'sort'],
        'edit' => ['id', 'type', 'name', 'value', 'sort'],
        'delete' => ['id']
    ];
}
