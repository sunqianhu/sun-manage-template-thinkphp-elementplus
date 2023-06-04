<?php

/**
 * 消息
 */

namespace app\library;

use think\facade\Config;
use WebSocket\Client;

class Message
{

    /**
     * 发送
     * @param $user 接收用户
     * @param $clientMessage 客户端消息
     * @return void
     */
    public function send($user, $clientMessage)
    {
        $config = Config::get('message');
        $serverMessage = [
            'type' => 'send',
            'user' => $user,
            'message' => $clientMessage
        ];
        $payload = json_encode($serverMessage);

        $url = 'ws://' . $config['client_ip'] . ':' . $config['port'];
        $client = new Client($url);
        $client->text($payload);
        $client->close();
    }
}
