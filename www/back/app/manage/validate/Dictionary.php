<?php

namespace app\manage\validate;

use think\Validate;

class Dictionary extends Validate
{
    protected $rule = [
        'id' => 'require|number',
        'type' => 'require',
        'key' => 'require',
        'value' => 'require',
        'sort' => 'require|number',
    ];
    protected $message = [
        'id.require' => 'id不能为空',
        'id.number' => 'id必须是数字',
        'type.require' => '字典类型不能为空',
        'key.require' => '字典键不能为空',
        'value.require' => '字典值不能为空',
        'sort.require' => '排序不能为空',
        'sort.number' => '排序必须是数字',
    ];
    protected $scene = [
        'add' => ['type', 'key', 'value', 'sort'],
        'edit' => ['id', 'type', 'key', 'value', 'sort'],
        'delete' => ['id']
    ];
}