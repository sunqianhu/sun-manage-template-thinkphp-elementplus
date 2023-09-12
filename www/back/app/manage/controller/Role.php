<?php

namespace app\manage\controller;

use app\manage\validate\Role as RoleValidate;
use app\helper\Arr;
use app\model\Menu as MenuModel;
use app\model\Role as RoleModel;
use app\model\RoleMenu as RoleMenuModel;
use think\exception\ValidateException;

/**
 * 角色管理
 */
class Role extends Base
{

    /**
     * 得到首页角色
     */
    public function getIndexRoles()
    {
        $get = $this->request->get(['name' => '', 'size' => '30', 'page' => '1']);

        $query = RoleModel::field('id,name');
        if ($get['name'] !== '') {
            $query = $query->where('name', 'LIKE', '%' . $get['name'] . '%');
        }
        $query = $query->order('id', 'asc');
        $roles = $query->paginate([
            'list_rows' => $get['size'],
            'page' => $get['page'],
        ]);

        return $this->success('获取成功', $roles);
    }

    /**
     * 初始化添加页面
     */
    public function initAdd()
    {
        // 菜单
        $menuModels = MenuModel::field('id, id, menu_id, name')
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();
        $arr = new Arr();
        $treeMenus = $arr->convertTree($menus, 'id', 'menu_id', 'children');

        return $this->success('获取成功', $treeMenus);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['name', 'menu_ids' => []]);

        // 验证
        try {
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $roleModel = RoleModel::create($post);
        if (!empty($post['menu_ids'])) {
            $roleMenuBelongsToMany = $roleModel->menus();
            $roleMenuBelongsToMany->attach($post['menu_ids']);
        }

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

        // 角色
        $roleModel = RoleModel::with('menus')
            ->field('id,name')
            ->find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $role = $roleModel->toArray();
        $role['menu_ids'] = [];
        if (!empty($role['menus'])) {
            $role['menu_ids'] = array_column($role['menus'], 'id');
        }

        // 菜单
        $menuModels = MenuModel::field('id, id, menu_id, name')
            ->order('sort', 'asc')
            ->select();
        $menus = $menuModels->toArray();
        $arr = new Arr();
        $treeMenus = $arr->convertTree($menus, 'id', 'menu_id', 'children');

        $data = [
            'role' => $role,
            'menus' => $treeMenus
        ];
        return $this->success('获取成功', $data);
    }

    /**
     * 保存修改
     */
    public function saveEdit()
    {
        $post = $this->request->post(['id', 'name', 'menu_ids' => []]);

        // 验证
        try {
            validate(RoleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $roleModel = RoleModel::find($post['id']);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->save($post);

        RoleMenuModel::where('role_id', $roleModel->id)->delete();
        if (!empty($post['menu_ids'])) {
            $roleModel->menus()->attach($post['menu_ids']);
        }

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

        $roleModel = RoleModel::find($id);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->delete();
        RoleMenuModel::where('role_id', $roleModel->id)->delete();

        return $this->success('删除成功');
    }
}
