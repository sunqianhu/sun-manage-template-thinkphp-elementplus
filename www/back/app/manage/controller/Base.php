<?php

namespace app\manage\controller;

use app\BaseController;
use app\helper\ManageJwt;
use app\model\Menu as MenuModel;
use app\model\OperationLog as OperationLogModel;
use app\model\Role as RoleModel;
use Exception;
use think\Response;

/**
 * 基控制器
 */
class Base extends BaseController
{
    /**
     * @var string[] 不登录网址
     */
    private $noLoginUrls = [
        'manage/login/getcaptcha',
        'manage/login/login',
        'manage/test/index'
    ];

    /**
     * @var string[] 不判断权限网址
     */
    private $noPermissionUrls = [
        'manage/login/logout',
        'manage/main/getpermissions',
        'manage/main/getroutes',
        'manage/main/getmenus',
        'manage/main/getwatermark',
        'manage/message/readall',
        'manage/message/getnoreads',
        'manage/uploadfile/uploadfile',
        'manage/my/info',
        'manage/my/editpassword'
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

        $this->addOperationLog();
    }

    /**
     * 鉴权
     * @return void
     * @throws Exception
     */
    function auth()
    {
        $appName = app('http')->getName();
        $controller = $this->request->controller();
        $action = $this->request->action();
        $url = $appName . '/' . $controller . '/' . $action;
        $url = strtolower($url);

        // 登录
        if (in_array($url, $this->noLoginUrls)) {
            return;
        }

        $token = $this->request->header('token', '');
        if (empty($token)) {
            throw new Exception('token错误');
        }

        $manageJwt = new ManageJwt();
        $user = $manageJwt->resolverToken($token);
        $this->user = $user;

        // 权限
        if (in_array($url, $this->noPermissionUrls)) {
            return;
        }

        $roleIds = RoleModel::join('user_role', 'role.id = user_role.role_id')
            ->where('user_role.user_id', $user->id)
            ->column('role_id');
        if (empty($roleIds)) {
            throw new Exception('未设置角色');
        }

        $menuModels = MenuModel::join('role_menu', 'menu.id = role_menu.menu_id')
            ->field('menu.api')
            ->where('role_menu.role_id', 'in', $roleIds)
            ->where('menu.api', '<>', '')
            ->group('menu.id')
            ->select();
        if ($menuModels->isEmpty()) {
            throw new Exception('无权限');
        }

        $have = false;
        foreach ($menuModels as $menuModel) {
            $api = $menuModel->api;
            if ($api === '') {
                continue;
            }
            $api = strtolower($api);
            $api = str_replace("\r\n", "\n", $api);
            $apis = explode("\n", $api);
            if (in_array($url, $apis)) {
                $have = true;
                break;
            }
        }
        if (!$have) {
            throw new Exception('无权限');
        }
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

    /**
     * 新增操作日志
     * @return void
     */
    public function addOperationLog()
    {
        if (empty($this->user->id)) {
            return;
        }

        // 不记录公共页面
        $url = $this->request->baseUrl();
        $url = strtolower($url);
        if (in_array($url, $this->noLoginUrls)) {
            return;
        }
        if (in_array($url, $this->noPermissionUrls)) {
            return;
        }

        // 记录
        $data = [
            'user_id' => $this->user->id,
            'time' => time(),
            'ip' => $this->request->ip(),
            'url' => $url
        ];
        OperationLogModel::create($data);
    }
}