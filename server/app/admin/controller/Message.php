<?php

namespace app\admin\controller;

use \app\model\Message as MessageModel;

/**
 * 消息提醒
 */
class Message extends Base
{
    /**
     * 全部已读
     * @return void
     */
    public function readAll()
    {
        $messageModels = MessageModel::where('user_id', $this->user->id)
            ->field('id')
            ->where('read', 0)
            ->select();
        if($messageModels->isEmpty()){
            return $this->success('设置成功');
        }

        return $this->success('设置成功');
    }

    
}
