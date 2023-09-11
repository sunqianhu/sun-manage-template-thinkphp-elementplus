<?php

namespace app\manage\controller;

use app\manage\validate\UploadFile as UploadFileValidate;
use app\helper\File;
use think\exception\ValidateException;
use think\facade\Filesystem;

class UploadFile extends Base
{
    private $allowModules = [''];

    /**
     * 上传
     * @return void
     */
    public function uploadFile()
    {
        $requestFile = $this->request->file();
        $module = $this->request->post('module', ''); // 模块

        // 验证
        try {
            validate(UploadFileValidate::class)->check($requestFile);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        if (!in_array($module, $this->allowModules)) {
            return $this->error('模块参数不允许');
        }

        $fileHelper = new File();
        $file = $requestFile['file'];
        $path = Filesystem::putFile($module, $file);
        $path = str_replace('\\', '/', $path);
        $url = $fileHelper->getUrl($path);

        $data = [
            'name' => $file->getOriginalName(),
            'type' => $file->getOriginalMime(),
            'ext' => $file->getOriginalExtension(),
            'size' => $file->getSize(),
            'path' => $path,
            'url' => $url
        ];
        return $this->success("上传成功", $data);
    }
}
