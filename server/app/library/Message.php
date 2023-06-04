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
     * @param $data 数据
     * @return void
     */
    public function send($user, $data)
    {
        $config = Config::get('message');
        $serverData = [
            'type' => 'send',
            'user' => $user,
            'data' => $data
        ];
        $payload = json_encode($serverData);

        $url = 'ws://' . $config['client_ip'] . ':' . $config['port'];
        $client = new Client($url);
        $client->text($payload);
        $client->close();
    }
}
