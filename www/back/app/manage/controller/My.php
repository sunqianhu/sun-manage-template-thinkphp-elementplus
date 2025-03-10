<?php

namespace app\manage\controller;

use app\helper\File;
use sunqianhu\helper\Image;
use app\manage\validate\User as UserValidate;
use app\model\User as UserModel;
use Exception;
use think\exception\ValidateException;
use think\facade\Config;

/**
 * 个人中心
 */
class My extends Base
{
    /**
     * 账号信息
     */
    public function info()
    {
        $userModel = UserModel::field('id,account,name,phone,login_time,login_ip,department_id')
            ->find($this->user->id);
        $user = $userModel->toArray();
        $user['department_name'] = $userModel->department->name ?? '';
        return $this->success('获取成功', $user);
    }

    /**
     * 初始化修改头像
     * @return \think\Response
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function initEditAvatar()
    {
        $userModel = UserModel::field('avatar')->find($this->user->id);
        $avatar = $userModel->front_avatar_url;
        return $this->success('获取成功', $avatar);
    }

    /**
     * 保存修改头像
     * @return \think\Response
     */
    public function saveEditAvatar()
    {
        $post = $this->request->post(['avatar_base64_content']);

        try {
            validate(UserValidate::class)->scene('edit_avatar')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $file = new File();
        $path = '';
        try {
            $path = $file->saveBase64ContentToFile('avatar', $post['avatar_base64_content']);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }
        $url = $file->getUrl($path);

        $rootPath = Config::get('filesystem.root_path');
        $fullPath = $rootPath . $path;
        $image = new Image();
        try {
            $image->thumbnail($fullPath, $fullPath, 100, 100);
        } catch (Exception $exception) {
            return $this->error($exception->getMessage());
        }

        $userModel = UserModel::find($this->user->id);
        $userModel->avatar = $path;
        $userModel->save();

        return $this->success('修改成功', $url);
    }

    /**
     * 修改密码
     */
    public function editPassword()
    {
        $post = $this->request->post(['password1', 'password2']);

        try {
            validate(UserValidate::class)->scene('edit_password')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $userModel = UserModel::find($this->user->id);
        $userModel->password = md5($post['password1']);
        $userModel->save();

        return $this->success('修改成功');
    }
}