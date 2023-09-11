<?php
declare (strict_types=1);

namespace app\command;

use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;
use think\facade\Config;
use Workerman\Worker;
use Workerman\Connection\TcpConnection;
use Workerman\Timer;

/**
 * 消息服务
 */
class Message extends Command
{
    
    protected function configure()
    {
        // 指令配置
        $this->setName('test')
            ->setDescription('测试命令');
    }

    protected function execute(Input $input, Output $output)
    {
        $message = new Message();
		$message->send('all', '消息标题'.time(), '/system/user');
    }
}
