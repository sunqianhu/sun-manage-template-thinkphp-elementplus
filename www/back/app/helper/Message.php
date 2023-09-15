<?php
/**
 * 消息
 */

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
     * @param $user 接收用户
     * @param $title 标题
     * @param $url 网址
     * @return void
     */
    public function send($user, $title, $url)
    {
        $userHelper = new UserHelper();
        $userIds = $userHelper->stringToIds($user);
        if (empty($userIds)) {
            throw new Exception('没有找到消息接收用户');
        }

        // 入库
        foreach ($userIds as $userId) {
            $messageData = [];
            $messageData['user_id'] = $userId;
            $messageData['title'] = $title;
            $messageData['url'] = $url;
            $messageData['add_time'] = time();
            MessageModel::create($messageData);
        }

        // 消息
        $config = Config::get('message');
        $data = [
            'type' => 'send',
            'user' => $user,
            'data' => [
                'type' => 'send',
                'title' => $title,
                'url' => $url
            ]
        ];
        $payload = json_encode($data);
        $url = 'ws://' . $config['client_ip'] . ':' . $config['port'];
        $client = new Client($url);
        $client->text($payload);
        $client->close();
    }
}
