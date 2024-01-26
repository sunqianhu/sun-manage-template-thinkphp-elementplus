<?php

namespace app\manage\validate;

use think\Validate;

class Order extends Validate
{
    protected $rule = [
        'add_time'=>'require|array'
    ];
    protected $message = [
        'add_time.require' => '订单时间不能为空',
        'add_time.array' => '订单时间必须是个数组'
    ];
    protected $scene = [
        'statistic_trend'=>['add_time'],
        'statistic_department'=>['add_time'],
        'statistic_trend_export_excel'=>['add_time']
    ];
}