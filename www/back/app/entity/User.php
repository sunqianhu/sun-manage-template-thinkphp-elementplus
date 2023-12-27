<?php

namespace app\entity;

/**
 * 用户对象
 */
class User
{
    /**
     * @var int 用户id
     */
    public $id = 0;

    /**
     * @var string 姓名
     */
    public $name = '';

    /**
     * @var int 部门id
     */
    public $departmentId = 0;

    /**
     * 设置id
     * @param int $id
     */
    public function setId(int $id): void
    {
        $this->id = $id;
    }

    /**
     * 设置姓名
     * @param string $name
     */
    public function setName(string $name): void
    {
        $this->name = $name;
    }

    /**
     * 设置部门
     * @param int $departmentId
     */
    public function setDepartmentId(int $departmentId): void
    {
        $this->departmentId = $departmentId;
    }
}