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

class Message extends Command
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
            if (!in_array($action, $this->actions)) {
                echo 'action参数错误';
                exit;
            }
            $argv[0] = 'message';
            $argv[1] = $action;
            if ($input->hasOption('daemon')) {
                $argv[2] = '-d';
            }
        }

        // 容器
        $config = Config::get('message');
        $uri = 'websocket://' . $config['server_ip'] . ':' . $config['port'];
        $worker = new Worker($uri);
        $worker->name = 'message';
        $worker->count = 1;

        // 事件
        $worker->onWorkerStart = [$this, 'onWorkerStart'];
        $worker->onMessage = [$this, 'onMessage'];

        Worker::runAll();
    }

    /**
     * 子进程启动
     * @param $worker
     * @return void
     */
    public function onWorkerStart($worker)
    {
        // 清理连接
        Timer::add(5, function () use ($worker) {
            $time = time();
            echo count($worker->connections);
            foreach ($worker->connections as $connection) {
//echo $connection->token;
                if (empty($connection->lastMessageTime)) {
                    $connection->lastMessageTime = $time;
                    continue;
                }
                if ($time - $connection->lastMessageTime > 60 * 60) {
                    $connection->close();
                }
            }
        });
    }

    /**
     * 收到数据
     * @param TcpConnection $connection
     * @param $payload 传输中的数据
     * @return void
     */
    public function onMessage(TcpConnection $connection, string $payload)
    {
        echo $payload.PHP_EOL;
        // 消息
        $message = json_decode($payload, true);
        if(empty($message) || empty($message['type'])){
            return;
        }

        switch ($message['type']){
            case 'bind':
                $this->bind($connection, $message['data']['token']);
                break;
            // 发送
            case 'send':
                $this->send($message['data']['user'], $message['data']['data']);
                break;
        }
    }

    /**
     * @param $connection
     * @param $token
     * @return void
     */
    public function bind(&$connection, $token){
        $connection->token = $token;
    }

    /**
     * 发送
     * @param $user
     * @param $data
     * @return void
     */
    public function send($user, $data){
        $message = [
            'type'=>'send',
            'data'=>[
                'data'=>$data
            ]
        ];
        $payload = json_encode($message);
    }

}
