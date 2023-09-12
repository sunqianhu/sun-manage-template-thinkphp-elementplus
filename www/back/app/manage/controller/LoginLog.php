<?php

namespace app\manage\controller;

use app\model\LoginLog as LoginLogModel;

/**
 * 登录日志
 */
class LoginLog extends Base
{

    /**
     * 得到首页登录日志
     */
    public function getIndexLoginLogs()
    {
        $get = $this->request->get(['time_start' => '', 'time_end' => '', 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        $query = LoginLogModel::alias('ll')
            ->field('ll.*,u.name')
            ->leftJoin("user u", "ll.user_id = u.id");
        if ($get['time_start'] !== '') {
            $query = $query->where('ll.time', '>', $get['time_start']);
        }
        if ($get['time_end'] !== '') {
            $query = $query->where('ll.time', '<', $get['time_end']);
        }
        if ($get['name'] !== '') {
            $query = $query->where('u.name', 'LIKE', '%' . $get['name'] . '%');
        }
        if ($get['phone'] !== '') {
            $query = $query->where('u.phone', 'LIKE', '%' . $get['phone'] . '%');
        }
        $query = $query->order('ll.id', 'desc');

        $loginLogs = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);
        return $this->success('获取成功', $loginLogs);
    }
}
