<?php

namespace app\admin\controller;

use app\validate\UploadFile as UploadValidate;
use think\exception\ValidateException;
use think\facade\Filesystem;

class UploadFile extends Base
{
    /**
     * 上传
     * @return void
     */
    public function uploadfile()
    {
        $requestFile = $this->request->file();

        // 验证
        try {
            validate(UploadValidate::class)->check($requestFile);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }
        $file = $requestFile['file'];

        $path = Filesystem::putFile('', $file);

        $data = [
            'name' => $file->getOriginalName(),
            'type' => $file->getOriginalMime(),
            'ext' => $file->getOriginalExtension(),
            'size' => $file->getSize(),
            'path' => $path
        ];
        return $this->success("上传成功", $data);
    }
}
