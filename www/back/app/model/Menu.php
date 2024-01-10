<?php

namespace app\model;

use app\helper\Dictionary as DictionaryHelper;

class Menu extends Base
{
    /**
     * 获取接口地址
     * @param $value
     * @return string
     */
    public function getApisAttr($value, $data)
    {
        if(!isset($data['api'])){
            return '';
        }
        return explode("\r\n", $data['api']);
    }

    /**
     * 得到类型名称
     * @param $value
     * @return string
     */
    public function getTypeNameAttr($value, $data)
    {
        $dictionaryHelper = new DictionaryHelper();
        return $dictionaryHelper->getValue('menu_type', $data['type_id']);
    }

    /**
     * 得到类型名称
     * @param $value
     * @return string
     */
    public function getTypeTagTypeAttr($value, $data)
    {
        $type = '';
        switch ($data['type_id']){
            case 1:
                $type = 'warning';
                break;
            case 2:
                $type = '';
                break;
            case 3:
                $type = 'warning';
                break;
            case 4:
                $type = 'info';
                break;
        }
        return $type;
    }

    /**
     * 得到菜单名称和备注
     * @param $value
     * @return string
     */
    public function getNameRemarkAttr($value, $data)
    {
        $nameRemark = '';
        if(!empty($data['name'])){
            $nameRemark .= $data['name'];
        }
        if(!empty($data['remark'])){
            $nameRemark .= '（'.$data['remark'].'）';
        }
        return $nameRemark;
    }
}
