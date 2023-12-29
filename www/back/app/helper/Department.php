<?php

namespace app\helper;

use app\model\Department as DepartmentModel;

class Department
{
    /**
     * 得到名称字符串
     * @param $ids
     * @param $separator
     * @return string
     */
    public function getNameString($ids, $separator = '，')
    {
        if(empty($ids)){
            return '';
        }
         $names = DepartmentModel::where('id', 'in', $ids)->column('name');
         return implode($separator, $names);
    }
}