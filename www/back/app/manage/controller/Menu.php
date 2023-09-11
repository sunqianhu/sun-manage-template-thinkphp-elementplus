<?php

namespace app\manage\controller;

use app\manage\validate\Menu as MenuValidate;
use app\helper\Arr;
use app\model\Menu as MenuModel;
use think\exception\ValidateException;

/**
 * 菜单管理
 */
class Menu extends Base
{

    /**
     * 得到首页菜单
     */
    public function getIndexMenus()
    {
        $get = $this->request->get(['name']);
        $wheres = [];
        if (isset($get['name'])) {
            $wheres[] = ['name', 'LIKE', '%' . $get['name'] . '%'];
        }

        $menuModels = MenuModel::field('id,menu_id,type_id,name,key,sort')
            ->where($wheres)
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $arr = new Arr();
        $treeMenus = $arr->convertTree($menus, 'id', 'menu_id', 'children');

        return $this->success('获取成功', $treeMenus);
    }

    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        $menuModels = MenuModel::field('id, id as value, menu_id, name as label')
            ->where("type_id", '<>', 3)
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $arr = new Arr();
        $treeMenus = $arr->convertTree($menus, 'id', 'menu_id', 'children');

        $data = [
            'treeMenus' => $treeMenus
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['menu_id' => 0, 'type_id' => 0, 'name', 'key', 'path', 'component', 'icon', 'api'=>'', 'show', 'sort']);

        // 验证
        try {
            validate(MenuValidate::class)->scene('add')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        MenuModel::create($post);
        return $this->success('添加成功');
    }

    /**
     * 初始化修改
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $menuModel = MenuModel::field('id,name,key,type_id,menu_id,icon,path,component,api,show,sort')->find($id);
        if (empty($menuModel)) {
            return $this->error('没有找到记录');
        }
        $menuModel->append(['apis']);
        $menu = $menuModel->toArray();

        $menuModels = MenuModel::field('id, id as value,menu_id,name as label')->order('sort', 'asc')->select();
        $menus = $menuModels->toArray();
        $arr = new Arr();
        $treeMenus = $arr->convertTree($menus, 'id', 'menu_id', 'children');

        $data = [
            'treeMenus' => $treeMenus,
            'menu' => $menu
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'menu_id' => 0, 'type_id' => 0, 'name', 'key', 'icon', 'path', 'component', 'api'=>'', 'show', 'sort']);

        // 验证
        try {
            validate(MenuValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        MenuModel::update($post);

        return $this->success('修改成功');
    }

    /**
     * 删除
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $menuModel = MenuModel::where('menu_id', $id)->find();
        if (!empty($menuModel)) {
            return $this->error('存在子菜单，不能删除');
        }

        MenuModel::destroy($id);
        return $this->success('删除成功');
    }
}
