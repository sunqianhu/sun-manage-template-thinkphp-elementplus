<?php

namespace app\library;

use app\model\Menu as MenuModel;
use app\model\Role as RoleModel;
use think\facade\Request;

/**
 * 鉴权
 */
class Auth
{
    /**
     * @var Str[] 不登录网址
     */
    private $noLoginUrls = [
        '/admin/login/login',
        '/admin/test/index'
    ];

    /**
     * @var Str[] 不鉴权网址
     */
    private $noPermissionUrls = [
        '/admin/permission/getpermissions',
        '/admin/route/getroutes',
        '/admin/menu/getmenus'
    ];

    /**
     * @var 用户
     */
    public $user;

    /**
     * 在不需要登录的url中
     * @return bool
     */
    function inNoLoginUrl()
    {
        $url = Request::baseUrl();
        $url = strtolower($url);
        if (in_array($url, $this->noLoginUrls)) {
            return true;
        }
        return false;
    }

    /**
     * 得到用户
     * @return \app\library\entity\User
     */
    function getUser()
    {
        if (!empty($this->user)) {
            return $this->user;
        }

        $token = Request::header('token', '');
        if (empty($token)) {
            throw new \Exception('没有获取到token');
        }

        $jwt = new Jwt();
        $this->user = $jwt->resolverToken($token);

        return $this->user;
    }

    /**
     * 是登录
     * @return boolean 是否
     */
    function isLogin()
    {
        try {
            $this->getUser();
        } catch (\Exception $e) {
            return false;
        }

        return true;
    }

    /**
     * 有权限
     * @return boolean 是|否
     */
    function isPermission()
    {
        // 白名单
        $url = Request::baseUrl();
        $url = strtolower($url);
        if (in_array($url, $this->noPermissionUrls)) {
            return true;
        }

        // 用户
        $user = $this->user;
        if (empty($user) || empty($user->id)) {
            return false;
        }

        // 角色
        $roleIds = RoleModel::join('user_role', 'role.id = user_role.role_id')
            ->where('user_role.user_id', $user->id)
            ->column('role_id');
        if (empty($roleIds)) {
            return false;
        }

        // 菜单
        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('api')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->select();
        if ($menuModels->isEmpty()) {
            return false;
        }
        $menus = $menuModels->toArray();

        // 鉴权
        $has = false;
        foreach ($menus as $menu) {
            $api = $menu['api'];
            if ($api === '') {
                continue;
            }
            $api = strtolower($api);
            $api = str_replace("\r\n", "\n", $api);
            $apis = explode("\n", $api);
            if (in_array($url, $apis)) {
                $has = true;
                break;
            }
        }
        if($has){
            return true;
        }

        return false;
    }
}