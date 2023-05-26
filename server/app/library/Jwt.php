<?php

namespace app\library;

use app\library\entity\User;
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
            'department_id' => $user->departmentId
        ];
        return FirebaseJWT::encode($payload, $this->key, 'HS256');
    }

    /**
     * 解析token
     * @param $token token
     * @return User 用户对象
     */
    function resolverToken($token){
        FirebaseJWT::$leeway = $this->leeway;
        $decoded = FirebaseJWT::decode($token, new Key($this->key, 'HS256'));

        $user = new User();
        $user->setId($decoded->id);
        $user->setName($decoded->name);
        $user->setDepartmentId($decoded->department_id);

        return $user;
    }
}