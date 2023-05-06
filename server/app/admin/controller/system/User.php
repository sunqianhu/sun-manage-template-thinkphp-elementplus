<?php

namespace app\admin\controller\system;

use app\admin\controller\Base;
use app\model\User as UserModel;

/**
 * 用户管理
 */
class User extends Base
{
    /**
     * 首页
     */
    public function index()
    {
        $query = $this->request->get(['account', 'name', 'phone', 'pageSize' => 20, 'pageNumber' => 1]);

        $where = [];
        if (isset($query['account'])) {
            $where[] = ['account', 'LIKE', '%' . $query['account'] . '%'];
        }
        if (isset($query['name'])) {
            $where[] = ['name', 'LIKE', '%' . $query['name'] . '%'];
        }
        if (isset($query['phone'])) {
            $where[] = ['phone', 'LIKE', '%' . $query['phone'] . '%'];
        }

        $paginate = UserModel::field('id,account,name,phone,status_id,add_time')->where($where)->order('id', 'desc')->paginate([
            'list_rows' => $query['pageSize'],
            'page' => $query['pageNumber']
        ]);
        $data = $paginate->toArray();

        return $this->success('获取成功', $data);
    }
}
