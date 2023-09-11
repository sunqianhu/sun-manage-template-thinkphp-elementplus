<?php

namespace app\helper;

use app\model\Dictionary as DictionaryModel;
use think\facade\Cache;

class Dictionary
{
    /**
     * @var int 缓存有效期
     */
    private $cacheExpire = 600;

    /**
     * 获取字典集合
     * @param $type
     * @return array
     */
    public function getList($type)
    {
        $cacheKey = 'dictionary_' . $type;
        $dictionarys = Cache::get($cacheKey);
        if (!empty($dictionarys)) {
            return $dictionarys;
        }

        $dictionaryModels = DictionaryModel::where('type', '=', $type)
            ->field('key,value')
            ->order('sort', 'asc')
            ->select();
        $dictionarys = $dictionaryModels->toArray();

        Cache::set($cacheKey, $dictionarys, $this->cacheExpire);

        return $dictionarys;
    }

    /**
     * 获取值
     * @param $type
     * @param $key
     * @return void
     */
    public function getValue($type, $key)
    {
        $cacheKey = 'dictionary_' . $type . '_' . $key;
        $value = Cache::get($cacheKey);
        if (!empty($value)) {
            return $value;
        }

        $value = DictionaryModel::where('type', '=', $type)
            ->where('key', '=', $key)
            ->field('value')
            ->order('sort', 'asc')
            ->value('value');
        Cache::set($cacheKey, $value, $this->cacheExpire);

        return $value;
    }

    /**
     * 获取值串
     * @param $type
     * @param $keyString
     * @return void
     */
    public function getValueString($type, $keyString, $glue = '，')
    {
        $cacheKey = 'dictionary_' . $type . '_' . $keyString;
        $valueString = Cache::get($cacheKey);
        if (!empty($valueString)) {
            return $valueString;
        }

        $values = DictionaryModel::where('type', '=', $type)
            ->where('key', 'in', $keyString)
            ->field('value')
            ->order('sort', 'asc')
            ->column('value');
        $valueString = implode($glue, $values);

        Cache::set($cacheKey, $valueString, $this->cacheExpire);
        return $valueString;
    }
}