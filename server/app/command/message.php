<?php
declare (strict_types=1);

namespace app\command;

use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;
use Workerman\Worker;
use Workerman\Connection\TcpConnection;

class message extends Command
{
    protected function configure()
    {
        // 指令配置
        $this->setName('message')
            ->addArgument('action', Argument::OPTIONAL, "操作选项[start|stop|reload|restart|status]", 'start')
            ->addOption('daemon', 'd', Option::VALUE_OPTIONAL, '以守护进程运行workerman')
            ->setDescription('消息提醒websocket服务');
    }

    protected function execute(Input $input, Output $output)
    {
        global $argv;
        $action = trim($input->getArgument('action'));
        array_unshift($argv, 'message.php', $action);


        $worker = new Worker("websocket://0.0.0.0:9001");
        $worker->name = 'message';
        $worker->count = 1;

        $worker->onMessage = function (TcpConnection $connection, $data) {
            $this->onMessage($connection, $data);
        };

        Worker::runAll();
    }

    public function onMessage(TcpConnection $connection, $data)
    {
        $connection->send($data);
    }

}
