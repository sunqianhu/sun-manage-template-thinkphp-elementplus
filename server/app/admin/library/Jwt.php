<?php

namespace app\admin\library;

use app\admin\model\Token as TokenModel;
use app\entity\User;
use app\library\Str;
use app\library\token;
use Exception;
use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;

/**
 * json web token
 */
class Jwt
{
    private $key = 'axjeJXKlA836x7s@#';
    private $leeway = 180;

    /**
     * 得到token
     * @param User $user
     * @return Str token
     */
    function getToken(User $user)
    {
        $payload = [
            'id' => $user->id,
            'name' => $user->name,
            'department_id' => $user->departmentId,
            'time'=>microtime()
        ];
        $token = FirebaseJWT::encode($payload, $this->key, 'HS256');

        // 管理
        $tokenData = [
            'token'=>$token,
            'user_id'=>$user->id,
            'expires_in'=> time() + 3600 * 2
        ];
        TokenModel::create($tokenData);

        return $token;
    }

    /**
     * 解析token
     * @param $token token
     * @return User 用户对象
     */
    function resolverToken($token){
        FirebaseJWT::$leeway = $this->leeway;
        $decoded = FirebaseJWT::decode($token, new Key($this->key, 'HS256'));

        // 验证
        $tokenModel = TokenModel::where('token', $token)->find();
        if(empty($tokenModel)){
            throw new Exception('登录已失效，请重新登录');
        }
        if($tokenModel->expires_in < time()){
            throw new Exception('登录已失效，请重新登录');
        }
        if($tokenModel->user_id != $decoded->id) {
            throw new Exception('登录已失效，请重新登录');
        }

        // 有效期
        $tokenModel->expires_in = time() + 3600 * 2;
        $tokenModel->save();

        $user = new User();
        $user->setId($decoded->id);
        $user->setName($decoded->name);
        $user->setDepartmentId($decoded->department_id);

        return $user;
    }
}