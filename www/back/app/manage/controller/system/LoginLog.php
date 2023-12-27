<?php

namespace app\manage\controller\system;

use app\manage\controller\Base;
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
        $get = $this->request->get(['time' =>[], 'name' => '', 'phone' => '', 'size' => '30', 'page' => '1']);

        $query = LoginLogModel::alias('ll')
            ->field('ll.*,u.name')
            ->leftJoin("user u", "ll.user_id = u.id");
        if (!empty($get['time']) && count($get['time']) == 2) {
            $query = $query->where('ll.time', '>', $get['time'][0]);
            $query = $query->where('ll.time', '<', $get['time'][1]);
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
