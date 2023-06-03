<?php

/**
 * 消息
 */

namespace app\library;

use think\facade\Config;
use WebSocket\Client;
use \app\entity\Message as MessageEntity;

class Message
{

    /**
     * 发送
     * @param $user 用户
     * @param $data 数据
     * @return void
     */
    public function send($user, $data)
    {
        $config = Config::get('message');
        $payload = json_encode([
            'type'=>'send',
            'data'=>[
                'user' => $user,
                'data' => $data
            ]
        ]);

        $uri = 'ws://' . $config['client_ip'] . ':' . $config['port'];
        $client = new Client($uri);
        $client->text($payload);
        $client->close();
    }
}
