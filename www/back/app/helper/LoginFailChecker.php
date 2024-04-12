<?php

namespace app\helper;

use app\model\LoginFailChecker as LoginFailCheckerModel;
use sunqianhu\helper\Time as TimeHelper;
use think\facade\Cache;
use think\facade\Db;

class LoginFailChecker
{
    /**
     * @var string 缓存键
     */
    public $cacheKey = '';

    /**
     * @var int 次数
     */
    public $number = 5;
    /**
     * @var int 时间
     */
    public $time = 60 * 60;

    /**
     * 构造
     * @param $account 账号
     */
    public function __construct($account)
    {
        $this->cacheKey = 'login_'.$account;
    }

    /**
     * 设置失败
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function setFail()
    {
        $number = Cache::get($this->cacheKey) ?? 0;
        $number ++;
        Cache::set($this->cacheKey, $number, $this->time);
    }

    /**
     * 重设失败
     * @return void
     */
    public function resetFail(){
        Cache::delete($this->cacheKey);
    }

    /**
     * 检查
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function check()
    {
        $number = Cache::get($this->cacheKey) ?? 0;
        if($number < $this->number){
            return true;
        }

        return false;
    }

    /**
     * 得到可用次数
     * @return true|void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getAvailableNumber()
    {
        $number = Cache::get($this->cacheKey) ?? 0;
        return $this->number - $number;
    }

    /**
     * 得到重置可读时间
     * @return string|null
     */
    public function getResetReadableTime(){
        $timeHelper = new TimeHelper();
        return $timeHelper->getSecondToReadableTime($this->time);
    }
}