<?php

namespace app\manage\controller\system;

use sunqianhu\helper\ArrayHandler;
use app\manage\controller\Base;
use app\manage\validate\Role as RoleValidate;
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
        //菜单
        $menuModels = MenuModel::field('id, id, menu_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $menus = $menuModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeMenus = $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');

        return $this->success('获取成功', $treeMenus);
    }

    /**
     * 保存添加
     */
    public function saveAdd()
    {
        $post = $this->request->post(['name', 'menu_ids' => []]);

        //验证
        try {
            validate(RoleValidate::class)->scene('add')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleModel = new RoleModel();
        $roleModel->save($post);

        if (!empty($post['menu_ids'])) {
            foreach($post['menu_ids'] as $menuId){
                $roleMenuModel = new RoleMenuModel();
                $roleMenuModel->save([
                    'role_id'=>$roleModel->id,
                    'menu_id'=>$menuId
                ]);
            }
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

        //角色
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

        //菜单
        $menuModels = MenuModel::field('id, id, menu_id, name, remark')
            ->order('sort', 'asc')
            ->append(['name_remark'])
            ->select();
        $menus = $menuModels->toArray();
        $arrayHandler = new ArrayHandler();
        $treeMenus = $arrayHandler->convertTree($menus, 'id', 'menu_id', 'children');

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

        //验证
        try {
            validate(RoleValidate::class)->scene('edit')->check($post);
        } catch (ValidateException $exception) {
            return $this->error($exception->getError());
        }

        $roleModel = RoleModel::find($post['id']);
        if (empty($roleModel)) {
            return $this->error('没有找到记录');
        }
        $roleModel->save($post);

        //关联
        $oldMenuIds = array_column($roleModel->menus->toArray(), 'id');
        $deleteMenuIds = array_unique(array_values(array_diff($oldMenuIds, $post['menu_ids'])));
        $addMenuIds = array_unique(array_values(array_diff($post['menu_ids'], $oldMenuIds)));
        if(!empty($deleteMenuIds)){
            foreach($deleteMenuIds as $deleteMenuId){
                $roleMenuModel = RoleMenuModel::where('role_id', $roleModel->id)
                    ->where('menu_id', $deleteMenuId)
                    ->findOrEmpty();
                $roleMenuModel->delete();
            }
        }
        if(!empty($addMenuIds)) {
            foreach($addMenuIds as $addMenuId){
                $roleMenuModel = new RoleMenuModel();
                $roleMenuModel->save([
                    'role_id'=>$roleModel->id,
                    'menu_id'=>$addMenuId
                ]);
            }
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

        $roleMenuModels = RoleMenuModel::where('role_id', $roleModel->id)->select();
        $roleMenuModels->delete();

        return $this->success('删除成功');
    }
}