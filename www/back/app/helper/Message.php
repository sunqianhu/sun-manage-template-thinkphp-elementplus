<?php

namespace app\helper;

use app\helper\User as UserHelper;
use app\model\Message as MessageModel;
use think\Exception;
use think\facade\Config;
use WebSocket\Client;

class Message
{
    /**
     * 推送消息
     * @param $userIds 接收用户id
     * @param $title 标题
     * @param $url 网址
     * @return void
     * @throws Exception
     */
    public function send($userIds, $title, $url)
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
}