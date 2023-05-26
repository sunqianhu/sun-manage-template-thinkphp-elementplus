<?php

namespace app\admin\controller;

use app\BaseController;
use app\library\entity\User;
use think\Response;
use app\library\Jwt;
use app\model\Menu as MenuModel;
use app\model\Role as RoleModel;
use Exception;

/**
 * 基控制器
 */
class Base extends BaseController
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
     * @var string 鉴权错误
     */
    public $authError = '';

    /**
     * 初始化
     * @return void
     */
    function initialize()
    {
        parent::initialize();

        if (!$this->auth()) {
            $this->error($this->authError)->send();
            exit;
        }
    }

    /**
     * 鉴权
     * @return void
     */
    function auth()
    {
        // 登录
        $url = $this->request->baseUrl();
        $url = strtolower($url);
        if (in_array($url, $this->noLoginUrls)) {
            return true;
        }

        $token = $this->request->header('token', '');
        if (empty($token)) {
            $this->authError = 'token错误';
            return false;
        }

        $jwt = new Jwt();
        try {
            $user = $jwt->resolverToken($token);
        } catch (Exception $e) {
            $this->authError = $e->getMessage();
            return false;
        }
        $this->user = $user;

        // 权限
        if (in_array($url, $this->noPermissionUrls)) {
            return true;
        }

        $roleIds = RoleModel::join('user_role', 'role.id = user_role.role_id')
            ->where('user_role.user_id', $user->id)
            ->column('role_id');
        if (empty($roleIds)) {
            $this->authError = '无权限';
            return false;
        }

        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('api')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->select();
        if ($menuModels->isEmpty()) {
            $this->authError = '无权限';
            return false;
        }
        $menus = $menuModels->toArray();

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
        if (!$has) {
            $this->authError = '无权限';
            return false;
        }

        return true;
    }

    /**
     * 成功响应
     * @param string $message 提示消息
     * @param mixed $data 返回数据
     */
    public function success(string $message, $data = null)
    {
        $result = [
            'code' => 1,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }

    /**
     * 失败响应
     * @param string $message 提示消息
     * @param mixed $data 返回数据
     */
    public function error(string $message, $data = null)
    {
        $result = [
            'code' => 0,
            'message' => $message,
            'data' => $data
        ];
        return Response::create($result, 'json', 200);
    }
}
