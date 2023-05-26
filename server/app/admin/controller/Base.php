<?php

namespace app\admin\controller;

use app\BaseController;
use think\Response;
use app\model\Menu as MenuModel;
use app\model\Role as RoleModel;
use app\library\Jwt;
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
     * 初始化
     * @return void
     */
    function initialize()
    {
        parent::initialize();

        try {
            $this->auth();
        } catch (Exception $e) {
            $this->error($e->getMessage())->send();
            exit;
        }
    }

    /**
     * 鉴权
     * @return boolean 
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
            throw new \Exception('没有获取到token');
        }

        $jwt = new Jwt();
        $user = $jwt->resolverToken($token);

        // 权限
        if (in_array($url, $this->noPermissionUrls)) {
            return true;
        }

        $roleIds = RoleModel::join('user_role', 'role.id = user_role.role_id')
            ->where('user_role.user_id', $user->id)
            ->column('role_id');
        if (empty($roleIds)) {
            throw new \Exception('无权限');
        }

        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('api')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->select();
        if ($menuModels->isEmpty()) {
            throw new \Exception('无权限');
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
            throw new \Exception('无权限');
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
