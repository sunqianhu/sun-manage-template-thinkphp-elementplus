<?php

namespace app\manage\controller\system;

use app\manage\controller\Base;
use app\model\OperationLog as OperationLogModel;

/**
 * 操作日志
 */
class OperationLog extends Base
{

    /**
     * 得到首页操作日志
     */
    public function getIndexOperationLogs()
    {
        $get = $this->request->get(['time' => [], 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        $query = OperationLogModel::alias('ol')
            ->field('ol.*,u.name')
            ->leftJoin("user u", "ol.user_id = u.id");
        if (!empty($get['time']) && count($get['time']) == 2) {
            $query = $query->where('ol.time', '>', $get['time'][0]);
            $query = $query->where('ol.time', '<', $get['time'][1]);
        }
        if ($get['name'] !== '') {
            $query = $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['phone'] !== '') {
            $query = $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query = $query->order('ol.id', 'desc');
        $operationLogs = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        return $this->success('获取成功', $operationLogs);
    }
}