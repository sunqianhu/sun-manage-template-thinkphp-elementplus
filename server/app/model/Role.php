<?php
namespace app\model;

use think\Model;

class Role extends Model
{
    /**
     * 菜单
     * @return \think\model\relation\BelongsToMany
     */
    public function menus()
    {
        return $this->belongsToMany(Menu::class, 'role_menu', 'menu_id', 'role_id');
    }
}