<?php

namespace app\admin\controller\system;

use app\admin\controller\Base;
use app\validate\system\Menu as MenuValidate;
use app\model\Menu as MenuModel;
use think\exception\ValidateException;
use app\library\Tree;

/**
 * 菜单管理
 */
class Menu extends Base
{

    /**
     * 首页
     *
     * @return void
     */
    public function index()
    {
        $get = $this->request->get(['name']);
        $where = [];
        if (isset($get['name'])) {
            $where[] = ['name', 'LIKE', '%' . $get['name'] . '%'];
        }

        $menuModels = MenuModel::field('id,parent_id,type_id,name,sort')
            ->where($where)
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();

        $tree = new Tree();
        $treeMenus = $tree->convertTree($menus, 'id', 'parent_id', 'children');

        return $this->success('获取成功', $treeMenus);
    }

    /**
     * 初始化添加页面
     *
     * @return void
     */
    public function initAdd()
    {
        $menuModels = MenuModel::field('id, id as value,parent_id,name as label')->order('sort', 'asc')->select();
        $menus = $menuModels->toArray();

        $tree = new Tree();
        $treeMenus = $tree->convertTree($menus, 'id', 'parent_id', 'children');

        $data = [
            'treeMenus' => $treeMenus
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存添加
     *
     * @return void
     */
    public function saveAdd()
    {
        $post = $this->request->post(['parent_id' => 0, 'type_id' => 0, 'name', 'icon', 'path', 'component', 'show', 'sort']);

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
     *
     * @return void
     */
    public function initEdit()
    {
        $id = $this->request->get('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $menuModel = MenuModel::field('id,name,type_id,parent_id,icon,path,component,show,sort')->find($id);
        if (empty($menuModel)) {
            return $this->error('没有找到记录');
        }
        $menu = $menuModel->toArray();

        $menuModels = MenuModel::field('id, id as value,parent_id,name as label')->order('sort', 'asc')->select();
        $menus = $menuModels->toArray();
        $tree = new Tree();
        $treeMenus = $tree->convertTree($menus, 'id', 'parent_id', 'children');

        $data = [
            'treeMenus' => $treeMenus,
            'menu' => $menu
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     *
     * @return void
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'parent_id' => 0, 'type_id' => 0, 'name', 'icon', 'path', 'component', 'show', 'sort']);

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
     *
     * @return void
     */
    public function delete()
    {
        $id = $this->request->post('id', 0);
        if ($id <= 0 || !is_numeric($id)) {
            return $this->error('id参数错误');
        }

        $menuModel = MenuModel::where('parent_id', $id)->find();
        if (!empty($menuModel)) {
            return $this->error('存在子菜单，不能删除');
        }

        MenuModel::destroy($id);
        return $this->success('删除成功');
    }
}
