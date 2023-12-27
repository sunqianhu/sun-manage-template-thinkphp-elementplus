<?php

return [
    // 默认磁盘
    'default' => env('filesystem.driver', 'public'),
    // 磁盘列表
    'disks'   => [
        'local'  => [
            'type' => 'local',
            'root' => app()->getRuntimePath() . 'storage',
        ],
        'public' => [
            // 磁盘类型
            'type'       => 'local',
            // 磁盘路径
            'root'       => app()->getRootPath() . 'public/storage',
            // 磁盘路径对应的外部URL路径
            'url'        => '/file',
            // 可见性
            'visibility' => 'public',
        ],
        // 更多的磁盘配置信息
    ],
    'root_dir'=>app()->getRootPath() . 'public/file/', // 根目录
    'access_prefix'=>'http://thinkphpvuemanagetemplate.sunqianhu123.cc/file/', // 访问前缀
    'front_access_prefix'=>'/api/file/', // 访问前缀
];
