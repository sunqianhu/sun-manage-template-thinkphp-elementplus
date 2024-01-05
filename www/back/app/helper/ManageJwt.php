<?php
/**
 * 管理后台jwt
 */

namespace app\helper;

use app\model\Token as TokenModel;
use app\entity\User as UserEntity;
use Exception;
use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;

class ManageJwt
{
    private $key = 'axjeJXKlA836x7s@#';
    private $leeway = 180;

    /**
     * 得到token
     * @param UserEntity $user
     * @return StringHandler token
     */
    function getToken(UserEntity $user)
    {
        $payload = [
            'id' => $user->id,
            'name' => $user->name,
            'department_id' => $user->departmentId,
            'time' => microtime()
        ];
        $token = FirebaseJWT::encode($payload, $this->key, 'HS256');

        // 管理
        $data = [
            'token' => $token,
            'user_id' => $user->id,
            'expires_in' => time() + 3600 * 2
        ];
        $tokenModel = new TokenModel();
        $tokenModel->save($data);

        return $token;
    }

    /**
     * 解析token
     * @param $token token
     * @return UserEntity 用户对象
     */
    function resolverToken($token)
    {
        FirebaseJWT::$leeway = $this->leeway;
        $decoded = FirebaseJWT::decode($token, new Key($this->key, 'HS256'));

        // 验证
        $tokenModel = TokenModel::where('token', $token)->find();
        if (empty($tokenModel)) {
            throw new Exception('登录已失效，请重新登录');
        }
        if ($tokenModel->expires_in < time()) {
            throw new Exception('登录已失效，请重新登录');
        }
        if ($tokenModel->user_id != $decoded->id) {
            throw new Exception('登录已失效，请重新登录');
        }

        // 有效期
        $tokenModel->expires_in = time() + 3600 * 8;
        $tokenModel->save();

        $userEntity = new UserEntity();
        $userEntity->setId($decoded->id);
        $userEntity->setName($decoded->name);
        $userEntity->setDepartmentId($decoded->department_id);

        return $userEntity;
    }

    /**
     * 删除token
     * @param $userId 用户id
     * @return void
     */
    function deleteToken($userId)
    {
        $tokenModels = TokenModel::where('user_id', '=', $userId)->select();
        $tokenModels->delete();
        return true;
    }
}