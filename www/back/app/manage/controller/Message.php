<?php

namespace app\manage\controller;

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
            ->where('read', 0)
            ->field('id')
            ->select();
        if ($messageModels->isEmpty()) {
            return $this->success('设置成功');
        }

        MessageModel::where("user_id", $this->user->id)
            ->where("read", 0)
            ->update([
                'read' => 1
            ]);
        return $this->success('设置成功');
    }

    /**
     * 获取未读消息
     * @return void
     */
    public function getNoReads()
    {
        // 数据
        $messageModels = MessageModel::where("user_id", $this->user->id)
            ->where("read", 0)
            ->order('id', 'desc')
            ->limit(0,50)
            ->select();
        $messages = $messageModels->toArray();

        // 设为已读
        if (!$messageModels->isEmpty()) {
            MessageModel::where("user_id", $this->user->id)
                ->where("read", 0)
                ->update([
                    'read' => 1
                ]);
        }

        return $this->success('获取成功', $messages);
    }

}
