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

    private $actions = ['start', 'stop', 'reload', 'restart', 'status'];

    protected function configure()
    {
        // 指令配置
        $this->setName('message')
            ->addArgument('action', Argument::OPTIONAL, "操作参数[start|stop|reload|restart|status]", 'start')
            ->addOption('daemon', 'd', Option::VALUE_OPTIONAL, '以守护进程运行workerman')
            ->setDescription('消息提醒websocket服务');
    }

    protected function execute(Input $input, Output $output)
    {
        if (strtolower(PHP_OS) == "linux") {
            global $argv;
            $action = trim($input->getArgument('action'));
            $argv[0] = 'message';
            $argv[1] = $action;
            if ($input->hasOption('daemon')) {
                $argv[2] = '-d';
            }
        }

        $worker = new Worker("websocket://0.0.0.0:9002");
        $worker::$daemonize = true;
        $worker->name = 'message';
        $worker->count = 1;
        $worker->onMessage = function (TcpConnection $connection, $data) {
            $this->onMessage($connection, $data);
        };

        Worker::runAll();
    }

    /**
     * 收到数据
     * @param TcpConnection $connection
     * @param $data
     * @return void
     */
    public function onMessage(TcpConnection $connection, $data)
    {
        $connection->send($data);
    }

}
