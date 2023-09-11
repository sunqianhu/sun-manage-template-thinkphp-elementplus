<?php

namespace app\manage\validate;

use think\Validate;

class UploadFile extends Validate
{
    protected $rule = [
        'file' => 'file|fileExt:png,jpg,jpeg,gif,doc,docx,xls,xlsx,ppt,pptx,zip,gz,rar,mp3,mp4|fileSize:'.(1024 * 1024 * 50)
    ];
    protected $message = [
        'file.file' => '上传不是一个文件',
        'file.fileExt' => '此类型的文件不支持上传',
        'file.fileSize' => '上传文件大小超出限制'
    ];
}
