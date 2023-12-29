<?php

namespace app\helper;

use app\model\Department as DepartmentModel;

class Department
{
    /**
     * 得到名称串
     * @param $ids
     * @return string
     */
    public function getNameString($ids)
    {
         $names = DepartmentModel::where('id', 'in', $ids)->column('name');
         return implode(',', $names);
    }
}