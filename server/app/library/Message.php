<?php

/**
 * 消息
 */

namespace app\library;

use app\model\User as UserModel;
use \app\model\Message as MessageModel;
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
        $userIds = $this->getUserId($user);
        if(empty($userIds)){
            throw new Exception('没有找到消息接收用户');
        }

        // 入库
        foreach($userIds as $userId){
            $messageData = [];
            $messageData['user_id'] = $userId;
            $messageData['title'] = $title;
            $messageData['url'] = $url;
            $messageData['add_time'] = time();
            MessageModel::create($messageData);
        }

        // 发送
        $config = Config::get('message');
        $serverData = [
            'type' => 'send',
            'user' => $user,
            'data' => [
                'type'=>'send',
                'title'=>$title,
                'url'=>$url
            ]
        ];
        $payload = json_encode($serverData);
        $url = 'ws://' . $config['client_ip'] . ':' . $config['port'];
        $client = new Client($url);
        $client->text($payload);
        $client->close();
    }

    /**
     * 得到用户id
     * @param $user
     * @return void
     */
    public function getUserId($user){
        if($user === 'all'){
            return UserModel::column('id');
        }

        return explode(',', $user);
    }


}
