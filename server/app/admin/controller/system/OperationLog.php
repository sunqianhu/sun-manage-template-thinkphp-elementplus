<?php

namespace app\admin\controller\system;

use app\admin\controller\Base;
use app\model\OperationLog as OperationLogModel;

/**
 * 登录日志
 */
class OperationLog extends Base
{

    /**
     * 得到首页操作日志
     */
    public function getIndexOperationLogs()
    {
        $get = $this->request->get(['time_start' => '', 'time_end' => '', 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);
        $wheres = [];
        if ($get['time_start'] !== '') {
            $wheres[] = ['a.time', '>', $get['time_start']];
        }
        if ($get['time_end'] !== '') {
            $wheres[] = ['a.time', '<', $get['time_end']];
        }
        if ($get['name'] !== '') {
            $wheres[] = ['b.name', 'LIKE', '%' . $get['name'] . '%'];
        }
        if ($get['phone'] !== '') {
            $wheres[] = ['b.phone', 'LIKE', '%' . $get['phone'] . '%'];
        }
        $loginLogs = OperationLogModel::alias('a')
            ->field('a.*,b.name')
            ->leftJoin("user b", "a.user_id = b.id")
            ->where($wheres)
            ->order('a.id', 'desc')
            ->paginate([
                'list_rows' => $get['size'],
                'page' => $get['page'],
            ]);
        return $this->success('获取成功', $loginLogs);
    }

}
