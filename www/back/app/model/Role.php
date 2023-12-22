<?php
namespace app\model;

class Role extends Base
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