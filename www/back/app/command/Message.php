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
    /**
     * @var object 容器类
     */
    public $worker;

    /**
     * @var string[] 命令参数
     */
    private $actions = ['start', 'stop', 'reload', 'restart', 'status'];

    /**
     * 配置
     * @return void
     */
    protected function configure()
    {
        //指令配置
        $this->setName('message')
            ->addArgument('action', Argument::OPTIONAL, "操作参数[start|stop|reload|restart|status]", 'start')
            ->addOption('daemon', null, Option::VALUE_OPTIONAL, '以守护进程运行')
            ->setDescription('websocket消息服务端，windows启动命令：php think message，linux启动命令：php think message start --daemon true');
    }

    /**
     * 执行
     * @param Input $input
     * @param Output $output
     * @return int|void|null
     */
    protected function execute(Input $input, Output $output)
    {
        //linux系统命令参数
        if (strtolower(PHP_OS) == 'linux') {
            /**
             * 参数
             * 0：文件名（随意）
             * 1：参数
             * 2：选项
             */
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
            if (isset($argv[3])) {
                unset($argv[3]);
            }
            if (isset($argv[4])) {
                unset($argv[4]);
            }
        } else {
            //window不支持命令参数
        }

        //容器
        $config = Config::get('message');
        if(!isset($config['server_ip']) || !isset($config['port'])){
            echo '还未配置服务器端监听ip或监听端口';
            exit;
        }
        $url = 'websocket://' . $config['server_ip'] . ':' . $config['port'];
        $this->worker = new Worker($url);
        $this->worker->name = 'message';
        $this->worker->count = 1;

        //事件
        $this->worker->onWorkerStart = [$this, 'onWorkerStart'];
        $this->worker->onMessage = [$this, 'onMessage'];

        Worker::runAll();
    }

    /**
     * 子进程启动
     * @param $worker
     * @return void
     */
    public function onWorkerStart($worker)
    {
        $this->clear($worker);
    }

    /**
     * 收到数据
     * @param TcpConnection $connection
     * @param $data 传输中的数据
     * @return void
     */
    public function onMessage(TcpConnection $connection, $data)
    {
        //活跃时间
        $connection->activeTime = time();

        //消息
        $dataDecode = json_decode($data, true);
        if (empty($dataDecode) || empty($dataDecode['type'])) {
            return;
        }

        //处理
        switch ($dataDecode['type']) {
            //绑定
            case 'bind':
                $this->bind($connection, $dataDecode['user_id']);
                break;
            //发送
            case 'send':
                $this->send($dataDecode['user_ids'], $dataDecode['data']);
                break;
        }
    }

    /**
     * 清理连接
     * @param $worker
     * @return void
     */
    public function clear($worker)
    {
        Timer::add(3600, function () use ($worker) {
            $time = time();
            foreach ($worker->connections as $connection) {
                if (empty($connection->activeTime)) {
                    $connection->activeTime = $time;
                    continue;
                }
                if ($time - $connection->activeTime > 3600) {
                    $connection->close();
                }
            }
        });
    }

    /**
     * 绑定
     * @param $connection
     * @param $userId
     * @return void
     */
    public function bind(&$connection, $userId)
    {
        if (empty($userId) && !is_numeric($userId)) {
            return;
        }
        $connection->userId = $userId;
    }

    /**
     * 发送
     * @param $userIds
     * @param $data
     * @return void
     */
    public function send($userIds, $data)
    {
        if(empty($userIds)){
            return;
        }

        //消息
        $dataEncode = json_encode($data);

        //指定
        foreach ($this->worker->connections as $connection) {
            if (empty($connection->userId)) {
                continue;
            }
            if (in_array($connection->userId, $userIds)) {
                $connection->send($dataEncode);
            }
        }
    }
}