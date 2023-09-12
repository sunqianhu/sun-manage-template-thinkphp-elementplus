<?php

namespace app\manage\controller;

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
        $get = $this->request->get(['time_start' => '', 'time_end' => '', 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        $query = OperationLogModel::alias('ol')
            ->field('ol.*,u.name')
            ->leftJoin("user u", "ol.user_id = u.id");
        if ($get['time_start'] !== '') {
            $query = $query->where('ol.time', '>', $get['time_start']);
        }
        if ($get['time_end'] !== '') {
            $query = $query->where('ol.time', '<', $get['time_end']);
        }
        if ($get['name'] !== '') {
            $query = $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['phone'] !== '') {
            $query = $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query = $query->order('ol.id', 'desc');
        $loginLogs = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        return $this->success('获取成功', $loginLogs);
    }
}
