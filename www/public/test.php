<?php

use Workerman\Connection\TcpConnection;
use Workerman\Worker;

require __DIR__ . '/../vendor/autoload.php';

$worker = new Worker("websocket://0.0.0.0:9001");
$worker->name = 'message';
$worker->count = 1;
$worker->onMessage = function (TcpConnection $connection, $data) {
    echo $data;
};

Worker::runAll();