<?php

namespace app\helper;

use app\model\Message as MessageModel;
use think\Exception;
use think\facade\Config;
use think\facade\Queue;
use WebSocket\Client;

class Message
{
    /**
     * 发送消息
     * @param $userIds 接收用户id
     * @param $title 标题
     * @param $url 网址
     * @return void
     * @throws Exception
     */
    public function send($userIds, $title, $url = '')
    {
        if (empty($userIds)) {
            return;
        }

        //入库
        foreach ($userIds as $userId) {
            $data = [
                'user_id' => $userId,
                'title' => $title,
                'url' => $userId,
                'add_time' => time()
            ];
            $messageModel = new MessageModel();
            $messageModel->save($data);
        }

        //消息
        $config = Config::get('message');
        $data = [
            'type' => 'send',
            'user_ids' => $userIds,
            'data' => [
                'type' => 'message',
                'title' => $title,
                'url' => $url
            ]
        ];
        $dataEncode = json_encode($data);
        $url = 'ws://' . $config['client_ip'] . ':' . $config['port'];
        $client = new Client($url);
        $client->text($dataEncode);
        $client->close();
    }

    /**
     * 通过队列发送消息
     * @param $userIds 接收用户id
     * @param $title 标题
     * @param $url 网址
     * @return void
     */
    public function sendByQueue($userIds, $title, $url = ''){
        $data = [
            'user_ids'=>$userIds,
            'title'=>$title,
            'url'=>$url
        ];
        Queue::push('app\job\Message', $data, 'message');
    }
}