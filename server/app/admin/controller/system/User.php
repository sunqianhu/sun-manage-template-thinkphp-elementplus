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
     * 初始化首页
     */
    public function initIndex()
    {
    }

    /**
     * 加载首页数据
     */
    public function loadIndexData()
    {
        $get = $this->request->get(['account', 'name', 'phone', 'pageSize' => 50, 'pageNumber' => 1]);

        $where = [];
        if (isset($get['account'])) {
            $where[] = ['account', 'LIKE', '%' . $get['account'] . '%'];
        }
        if (isset($get['name'])) {
            $where[] = ['name', 'LIKE', '%' . $get['name'] . '%'];
        }
        if (isset($get['phone'])) {
            $where[] = ['phone', 'LIKE', '%' . $get['phone'] . '%'];
        }

        $paginate = UserModel::field('id,account,name,phone,status_id,add_time')->where($where)->order('id', 'desc')->paginate([
            'list_rows' => $get['pageSize'],
            'page' => $get['pageNumber']
        ]);
        $data = $paginate->toArray();

        return $this->success('获取成功', $data);
    }
}
