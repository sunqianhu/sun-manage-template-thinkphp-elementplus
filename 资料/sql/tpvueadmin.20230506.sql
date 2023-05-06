/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : tpvueadmin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2023-05-06 18:30:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '部门名称',
  `sort` int(255) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='部门';

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '0', '部门1', '1');
INSERT INTO `department` VALUES ('2', '1', '部门1-1', '1');
INSERT INTO `department` VALUES ('3', '2', '部门2', '2');
INSERT INTO `department` VALUES ('4', '0', '部门3', '3');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级菜单',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '菜单类型',
  `icon` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路由路径',
  `component` varchar(255) NOT NULL DEFAULT '' COMMENT '组件路径',
  `show` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '菜单显示',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COMMENT='菜单';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '0', '系统管理', '1', 'Setting', '/layouts/Blank.vue', '/system', '1', '1');
INSERT INTO `menu` VALUES ('2', '1', '用户管理', '1', '', '/layouts/Blank.vue', '/system/user', '1', '1');
INSERT INTO `menu` VALUES ('3', '2', '用户列表', '2', '', '/views/system/user/Index.vue', '/system/user/index', '2', '1');
INSERT INTO `menu` VALUES ('4', '2', '用户详情', '2', '', '/views/system/user/Detail.vue', '/system/user/detail', '2', '2');
INSERT INTO `menu` VALUES ('5', '1', '部门管理', '2', '', '/views/system/department/Index.vue', '/system/department', '1', '2');
INSERT INTO `menu` VALUES ('6', '5', '添加', '3', '', '', '', '2', '1');
INSERT INTO `menu` VALUES ('7', '5', '修改', '3', '', '', '', '2', '2');
INSERT INTO `menu` VALUES ('8', '5', '删除', '3', '', '', '', '2', '3');
INSERT INTO `menu` VALUES ('9', '1', '角色管理', '2', '', '/views/system/role/Index.vue', '/system/role', '1', '4');
INSERT INTO `menu` VALUES ('10', '1', '菜单管理', '2', '', '/views/system/menu/Index.vue', '/system/menu', '1', '5');
INSERT INTO `menu` VALUES ('11', '9', '添加', '3', '', '', '', '2', '1');
INSERT INTO `menu` VALUES ('12', '9', '删除', '3', '', '', '', '2', '1');
INSERT INTO `menu` VALUES ('13', '9', '修改', '3', '', '', '', '1', '1');
INSERT INTO `menu` VALUES ('14', '3', '添加', '3', '', '', '', '2', '1');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '名称',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '超级用户', '', '1676018723', '1676018723');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `role_id` int(10) unsigned NOT NULL COMMENT '角色id',
  `menu_id` int(10) unsigned NOT NULL COMMENT '菜单id',
  KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限关联';

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('1', '6');
INSERT INTO `role_menu` VALUES ('1', '8');
INSERT INTO `role_menu` VALUES ('1', '12');
INSERT INTO `role_menu` VALUES ('1', '10');
INSERT INTO `role_menu` VALUES ('1', '1');
INSERT INTO `role_menu` VALUES ('1', '5');
INSERT INTO `role_menu` VALUES ('1', '9');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '部门id',
  `role_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '角色id串',
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='管理用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('8', '1', '1', '1', '15108273576', '01286d00e524004e4ba96705a166dd38', '孙乾户', '15108273576', '', '1675929726', '0', '0', '');
