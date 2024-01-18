<?php

namespace app\job;

use Exception;
use think\queue\Job;
use app\helper\Message as MessageHelper;

class Message
{
    public function fire(Job $job, $data)
    {
        $job->delete();

        if (empty($data) || empty($data['user_ids']) || empty($data['title']) || !isset($data['url'])) {
            return;
        }

        $messageHelper = new MessageHelper();
        try {
            $messageHelper->send($data['user_ids'], $data['title'], $data['url']);
        } catch (Exception $exception) {
        }
    }

    public function failed($data)
    {

        // ...任务达到最大重试次数后，失败了
    }
}