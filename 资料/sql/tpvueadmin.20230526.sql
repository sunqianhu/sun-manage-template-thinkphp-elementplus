/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : tpvueadmin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2023-05-26 16:19:57
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级部门id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '部门名称',
  `sort` int(255) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COMMENT='部门';

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '0', '部门1', '1');
INSERT INTO `department` VALUES ('2', '1', '部门1-1', '1');
INSERT INTO `department` VALUES ('7', '0', '部门2', '2');
INSERT INTO `department` VALUES ('8', '7', '部门2-1', '1');
INSERT INTO `department` VALUES ('13', '0', '部门3', '3');

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT '字典类型',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '字典名称',
  `value` varchar(64) NOT NULL DEFAULT '' COMMENT '字典值',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='字典';

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('1', 'menu_type', '目录', '1', '1');
INSERT INTO `dictionary` VALUES ('2', 'menu_type', '页面', '2', '2');
INSERT INTO `dictionary` VALUES ('3', 'menu_type', '按钮', '3', '3');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级菜单id',
  `type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '菜单类型id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `key` varchar(64) DEFAULT '' COMMENT '菜单key',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路由路径',
  `component` varchar(255) NOT NULL DEFAULT '' COMMENT '组件路径',
  `icon` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `api` varchar(1024) NOT NULL DEFAULT '' COMMENT '接口地址',
  `show` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '菜单显示',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COMMENT='菜单';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '0', '1', '系统管理', 'system', '', '', 'Setting', '', '1', '2');
INSERT INTO `menu` VALUES ('2', '1', '2', '用户管理', 'user', '/system/user', 'system/user/Index.vue', 'User', '/admin/system.User/getIndexUsers', '1', '1');
INSERT INTO `menu` VALUES ('3', '2', '3', '添加', 'userAdd', '', '', '', '/admin/system.User/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('4', '2', '3', '修改', 'userEdit', '', '', '', '/admin/system.User/initEdit\n/admin/system.User/saveEdit', '1', '2');
INSERT INTO `menu` VALUES ('5', '1', '2', '部门管理', 'department', '/system/department', 'system/department/Index.vue', 'Memo', '/admin/system.Department/getIndexDepartments', '1', '2');
INSERT INTO `menu` VALUES ('6', '2', '3', '修改状态', 'userEditStatus', '', '', '', '/admin/system.User/editStatus', '1', '3');
INSERT INTO `menu` VALUES ('7', '2', '3', '修改密码', 'userEditPassword', '', '', '', '/admin/system.User/editPassword', '1', '5');
INSERT INTO `menu` VALUES ('8', '5', '3', '添加', 'departmentAdd', '', '', '', '/admin/system.Department/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('9', '5', '3', '修改', 'departmentEdit', '', '', '', '/admin/system.Department/initEdit\n/admin/system.Department/saveEdit', '1', '1');
INSERT INTO `menu` VALUES ('10', '5', '3', '删除', 'departmentDelete', '', '', '', '/admin/system.Department/delete', '1', '1');
INSERT INTO `menu` VALUES ('11', '1', '2', '角色管理', 'role', '/system/role', 'system/role/Index.vue', 'ChatSquare', '/admin/system.Role/getIndexRoles', '1', '3');
INSERT INTO `menu` VALUES ('12', '11', '3', '添加', 'roleAdd', '', '', '', '/admin/system.Role/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('13', '11', '3', '修改', 'roleEdit', '', '', '', '/admin/system.Role/initEdit\n/admin/system.Role/saveEdit', '1', '2');
INSERT INTO `menu` VALUES ('14', '11', '3', '删除', 'roleDelete', '', '', '', '/admin/system.Role/delete', '1', '3');
INSERT INTO `menu` VALUES ('15', '1', '2', '菜单管理', 'menu', '/system/menu', 'system/menu/Index.vue', 'Reading', '/admin/system.Menu/getIndexMenus', '1', '4');
INSERT INTO `menu` VALUES ('16', '15', '3', '添加', 'menuAdd', '', '', '', '/admin/system.Menu/initAdd\n/admin/system.Menu/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('17', '15', '3', '修改', 'menuEdit', '', '', '', '/admin/system.Menu/initEdit\n/admin/system.Menu/saveEdit', '1', '2');
INSERT INTO `menu` VALUES ('18', '15', '3', '删除', 'menuDelete', '', '', '', '/admin/system.Menu/delete', '1', '3');
INSERT INTO `menu` VALUES ('19', '1', '2', '字典管理', 'dictionary', '/system/dictionary', 'system/dictionary/Index.vue', 'Document', '/admin/system.Dictionary/getIndexDictionarys', '1', '5');
INSERT INTO `menu` VALUES ('20', '19', '3', '添加', 'dictionaryAdd', '', '', '', '/admin/system.Dictionary/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('21', '19', '3', '修改', 'dictionaryEdit', '', '', '', '/admin/system.Dictionary/initEdit\n/admin/system.Dictionary/saveEdit', '1', '2');
INSERT INTO `menu` VALUES ('22', '19', '3', '删除', 'dictionaryDelete', '', '', '', '/admin/system.Dictionary/delete', '1', '3');
INSERT INTO `menu` VALUES ('23', '0', '2', '首页', 'index', '/index', 'Index.vue', 'House', '', '1', '0');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级用户');
INSERT INTO `role` VALUES ('4', '普通角色');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `menu_id` int(10) unsigned NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='角色权限关联';

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('33', '4', '3');
INSERT INTO `role_menu` VALUES ('34', '4', '4');
INSERT INTO `role_menu` VALUES ('35', '4', '6');
INSERT INTO `role_menu` VALUES ('36', '4', '1');
INSERT INTO `role_menu` VALUES ('37', '4', '2');
INSERT INTO `role_menu` VALUES ('38', '1', '23');
INSERT INTO `role_menu` VALUES ('39', '1', '1');
INSERT INTO `role_menu` VALUES ('40', '1', '2');
INSERT INTO `role_menu` VALUES ('41', '1', '3');
INSERT INTO `role_menu` VALUES ('42', '1', '4');
INSERT INTO `role_menu` VALUES ('43', '1', '6');
INSERT INTO `role_menu` VALUES ('44', '1', '7');
INSERT INTO `role_menu` VALUES ('45', '1', '5');
INSERT INTO `role_menu` VALUES ('46', '1', '10');
INSERT INTO `role_menu` VALUES ('47', '1', '9');
INSERT INTO `role_menu` VALUES ('48', '1', '8');
INSERT INTO `role_menu` VALUES ('49', '1', '11');
INSERT INTO `role_menu` VALUES ('50', '1', '12');
INSERT INTO `role_menu` VALUES ('51', '1', '13');
INSERT INTO `role_menu` VALUES ('52', '1', '14');
INSERT INTO `role_menu` VALUES ('53', '1', '15');
INSERT INTO `role_menu` VALUES ('54', '1', '16');
INSERT INTO `role_menu` VALUES ('55', '1', '17');
INSERT INTO `role_menu` VALUES ('56', '1', '18');
INSERT INTO `role_menu` VALUES ('57', '1', '19');
INSERT INTO `role_menu` VALUES ('58', '1', '20');
INSERT INTO `role_menu` VALUES ('59', '1', '21');
INSERT INTO `role_menu` VALUES ('60', '1', '22');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '部门id',
  `status_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态id',
  `account` varchar(64) NOT NULL DEFAULT '' COMMENT '账号',
  `password` varchar(64) NOT NULL DEFAULT '' COMMENT '密码',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '姓名',
  `phone` varchar(64) NOT NULL DEFAULT '' COMMENT '手机号码',
  `avatar` varchar(128) NOT NULL DEFAULT '' COMMENT '头像',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `login_ip` varchar(32) NOT NULL DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`id`),
  KEY `department_id` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='管理用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('10', '1', '1', '15108273576', '01286d00e524004e4ba96705a166dd38', '孙乾户', '15108273576', '', '1684989244', '1685071233', '0', '');
INSERT INTO `user` VALUES ('11', '1', '1', '18781933732', '0525ac8831590b44ab3b8317878f751c', '唐琴梅', '18781933732', '', '1684992552', '1685065712', '0', '');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL COMMENT '用户id',
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `role_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('40', '11', '4');
INSERT INTO `user_role` VALUES ('41', '10', '1');
INSERT INTO `user_role` VALUES ('42', '10', '4');
