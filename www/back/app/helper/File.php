<?php
/**
 * 文件
 */

namespace app\helper;

use think\facade\Config;
use Exception;

class File
{
    /**
     * 得到访问url
     * @param string $path 路径
     */
    public function getUrl($path)
    {
        return Config::get('filesystem.access_prefix') . $path;
    }

    /**
     * 创建目录
     * @param $module
     * @return string
     * @throws Exception
     */
    public function mkdir($module = ''){
        $rootDir = Config::get('filesystem.root_dir'); // 磁盘根目录
        if (empty($rootDir)) {
            throw new Exception('没有配置文件目录');
        }

        if ($module != '') {
            $relativeDir = $module . '/';
        }
        $relativeDir .= date('Y/m/d') . '/'; // 目录
        $fullDir = $rootDir . $relativeDir;
        if (!file_exists($fullDir)) {
            if (!@mkdir($fullDir, 0755, true)) {
                throw new Exception('目录创建失败');
            }
        }

        return $relativeDir;
    }

    /**
     * 保存base64内容到文件
     * @param $module
     * @param $content
     * @return string
     * @throws Exception
     */
    public function saveBase64ContentToFile($module, $content)
    {
        $allowMimeTypes = [
            'image/jpg',
            'image/jpeg',
            'image/png',
            'image/gif',
            'text/plain'
        ];
        $extMap = [
            'image/jpg'=>'jpg',
            'image/jpeg'=>'jpeg',
            'image/png'=>'png',
            'image/gif'=>'gif',
            'text/plain'=>'txt'
        ];
        $rootDir = ''; // 文件根目录
        $relativeDir = ''; // 相对目录
        $fullDir = ''; // 全路径目录
        $path = ''; // 文件相对路径
        $fullPath = ''; // 文件全路径

        if (empty($content)) {
            throw new Exception('base64内容不能为空');
        }
        $contents = explode(';base64,', $content);
        $mimeType = $contents[0];
        $mimeType = str_replace('data:', '', $mimeType);
        if(empty($mimeType)){
            throw new Exception('没有获取到图片mime类型');
        }
        if(!in_array($mimeType, $allowMimeTypes)){
            throw new Exception('内容的mime类型不允许');
        }
        $ext = $extMap[$mimeType];
        $base64Content = $contents[1] ?? '';
        if(empty($base64Content)){
            throw new Exception('没有得到文件内容');
        }
        $base64ContentDecode = base64_decode($base64Content);

        $rootDir = Config::get('filesystem.root_dir'); // 磁盘根目录
        if (empty($rootDir)) {
            throw new Exception('没有配置文件目录');
        }
        $relativeDir = $this->mkdir($module);
        $fileName = md5(time() . rand(1000, 9999)) . '.' . $ext;
        $path = $relativeDir . $fileName; // 文件相对路径
        $fullPath = $rootDir . '/' . $path; // 全文件路径

        if (!file_put_contents($fullPath, $base64ContentDecode)) {
            throw new Exception('文件保存失败');
        }

        return $path;
    }
}