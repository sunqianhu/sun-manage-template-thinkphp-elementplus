<?php

namespace app\library;

use Firebase\JWT\JWT as FirebaseJWT;
use Firebase\JWT\Key;

/**
 * jwt
 */
class Jwt
{
    private $key = 'axjeJXKlA836x7s@#';
    private $leeway = 180;

    /**
     * 得到token
     * @param array $payload 载荷
     * @return string token
     */
    function getToken($payload)
    {
        return FirebaseJWT::encode($payload, $this->key, 'HS256');
    }


    /**
     * 解析token
     * @param string $token jwt token
     * @return JwtUser jwtUser对象
     * @expectedException
     */
    function resolverToken($token){
        $jwtUser = new JwtUser();
        FirebaseJWT::$leeway = $this->leeway;
        $decoded = FirebaseJWT::decode($token, new Key($this->key, 'HS256'));

        $jwtUser->id = $decoded->id;
        $jwtUser->name = $decoded->name;

        return $jwtUser;
    }
}