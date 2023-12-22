<?php

namespace app\model;

use app\helper\Dictionary as DictionaryHelper;

class Department extends Base
{
    /**
     * 得到类型名称
     * @param $value
     * @return string
     */
    public function getTypeNameAttr($value, $data)
    {
        $dictionaryHelper = new DictionaryHelper();
        return $dictionaryHelper->getValue('department_type', $data['type_id']);
    }
}
