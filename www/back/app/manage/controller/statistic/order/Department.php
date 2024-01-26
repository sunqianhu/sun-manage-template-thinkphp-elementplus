<?php

namespace app\manage\controller\statistic\order;

use app\manage\controller\Base;
use app\manage\validate\Order as OrderValidate;
use app\model\Department as DepartmentModel;
use sunqianhu\helper\ArrayHandler;

class Department extends Base
{
    /**
     * 初始化
     * @return \think\Response
     */
    public function init()
    {
        $get = $this->request->get(['add_time' => []]);

        // 验证
        try {
            validate(OrderValidate::class)->scene('statistic_department')->check($get);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        if (count($get['add_time']) != 2) {
            return $this->error('添加时间参数错误');
        }

        //部门
        $streetModels = DepartmentModel::select();

        $streets = [];
        foreach($streetModels as $streetModel){
//            $number = InfoModel::alias('i')
//                ->leftJoin('local_opinion_info_street is', 'i.id=is.info_id')
//                ->whereBetween('i.add_time', $get['add_time'])
//                ->where('is.department_id', $streetModel->id)
//                ->group('i.id')
//                ->count();
            $number = rand(0,50);
            $street = [
                'name'=>$streetModel->name,
                'number'=>$number
            ];
            $streets[] = $street;
        }
        $arrayHandler = new ArrayHandler();
        $arrayHandler->rsortTwoDimensional($streets, 'number');

        return $this->success('获取成功', $streets);
    }
}