<?php

namespace app\helper;

class Str
{
    /**
     * 字符串长度
     * @param string $string 字符串
     * @return int 字符串长度
     */
    function length($string)
    {
        $matchs = array();
        $length = 0;

        if ($string === '') {
            return $length;
        }

        if (function_exists('mb_utf8length')) {
            $length = mb_utf8length($string, 'utf-8');
        } else {
            preg_match_all('/./u', $string, $matchs);
            $length = count($matchs[0]);
        }

        return $length;
    }

    /**
     * 截取字符串
     * @param string $string 字符串
     * @param int $start 开始位置
     * @param int $end 结束位置
     * @return string 截取后的字符串
     */
    function sub($string, $start, $end)
    {
        $new = '';
        $matchs = array();

        if ($string === '') {
            return $new;
        }

        if (function_exists('mb_substr')) {
            $new = mb_substr($string, $start, $end, 'utf-8');
        } else {
            preg_match_all('/./u', $string, $matchs);
            $new = join('', array_slice($matchs[0], $start, $end));
        }

        return $new;
    }

    /**
     * 截取字符串返回节点
     * @param string $string 字符串
     * @param int $length 截取长度
     * @return string 截取后的字符串
     */
    function subNode($string, $length)
    {
        $node = '';
        $total = 0; // 字符串总长度

        if ($string === '') {
            return $node;
        }

        $total = $this->length($string);
        if ($total <= $length) {
            return $string;
        }

        $node = '<span title="' . $string . '">' . $this->sub($string, 0, $length) . '...</span>';
        return $node;
    }

    /**
     * 转小帕斯卡
     * @param $word
     * @param $split
     * @return void
     */
    function toSmallPascal($word, $delimiters = '/'){
        if($word === ''){
            return $word;
        }

        $word = str_replace('_', ' ', $word);
        $word = ucwords($word, $delimiters);
        $word = str_replace($delimiters, '', $word);
        $word = lcfirst($word);

        return $word;
    }
}