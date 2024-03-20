<?php
namespace app\model;

use think\facade\Config;

class User extends Base
{
    /**
     * 部门
     * @return \think\model\relation\BelongsToMany
     */
    public function department()
    {
        return $this->belongsTo(Department::class, 'department_id', 'id');
    }

    /**
     * 角色
     * @return \think\model\relation\BelongsToMany
     */
    public function roles()
    {
        return $this->belongsToMany(Role::class, 'user_role', 'role_id', 'user_id');
    }

    /**
     * 得到状态名
     * @param $value
     * @param $data
     * @return null
     */
    public function getStatusNameAttr($value, $data)
    {
        $name = '启用';
        if($data['status_id'] != 1){
            $name = '停用';
        }

        return $name;
    }

    /**
     * 得到头像url
     * @param $path
     * @return string
     */
    public function getAvatarUrlAttr($value, $data)
    {
        $path = $data['avatar']??'';
        if($path === ''){
            $path = 'avatar.png';
        }
        return Config::get('filesystem.access_prefix') . $path;
    }

    /**
     * 得到前端头像url
     * @param $path
     * @return string
     */
    public function getFrontAvatarUrlAttr($value, $data)
    {
        $path = $data['avatar']??'';
        if($path === ''){
            $path = 'avatar.png';
        }
        return Config::get('filesystem.access_prefix') . $path;
    }
}