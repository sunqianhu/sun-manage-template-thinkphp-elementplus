/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : thinkphpvuemanage

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2023-09-22 11:44:06
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
  `key` varchar(64) NOT NULL DEFAULT '' COMMENT '字典值',
  `value` varchar(64) NOT NULL DEFAULT '' COMMENT '字典名称',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='字典';

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('1', 'menu_type', '1', '目录', '1');
INSERT INTO `dictionary` VALUES ('2', 'menu_type', '2', '页面', '2');
INSERT INTO `dictionary` VALUES ('3', 'menu_type', '3', '按钮', '3');

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT '登录ip',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES ('1', '10', '1686121653', '127.0.0.1');
INSERT INTO `login_log` VALUES ('2', '10', '1686194842', '127.0.0.1');
INSERT INTO `login_log` VALUES ('3', '10', '1686202913', '127.0.0.1');
INSERT INTO `login_log` VALUES ('4', '10', '1686278017', '127.0.0.1');
INSERT INTO `login_log` VALUES ('5', '10', '1686282144', '127.0.0.1');
INSERT INTO `login_log` VALUES ('6', '10', '1686292755', '127.0.0.1');
INSERT INTO `login_log` VALUES ('7', '10', '1686293528', '127.0.0.1');
INSERT INTO `login_log` VALUES ('8', '10', '1686299381', '127.0.0.1');
INSERT INTO `login_log` VALUES ('9', '10', '1686623574', '127.0.0.1');
INSERT INTO `login_log` VALUES ('10', '10', '1686623614', '127.0.0.1');
INSERT INTO `login_log` VALUES ('11', '10', '1687666953', '127.0.0.1');
INSERT INTO `login_log` VALUES ('12', '10', '1688265215', '127.0.0.1');
INSERT INTO `login_log` VALUES ('13', '10', '1688265237', '127.0.0.1');
INSERT INTO `login_log` VALUES ('14', '10', '1688028580', '127.0.0.1');
INSERT INTO `login_log` VALUES ('15', '10', '1694424828', '127.0.0.1');
INSERT INTO `login_log` VALUES ('16', '10', '1694424843', '127.0.0.1');
INSERT INTO `login_log` VALUES ('17', '10', '1694426468', '127.0.0.1');
INSERT INTO `login_log` VALUES ('18', '10', '1694426503', '127.0.0.1');
INSERT INTO `login_log` VALUES ('19', '10', '1694426823', '127.0.0.1');
INSERT INTO `login_log` VALUES ('20', '10', '1694482301', '127.0.0.1');
INSERT INTO `login_log` VALUES ('21', '10', '1694836288', '127.0.0.1');
INSERT INTO `login_log` VALUES ('22', '10', '1694839660', '127.0.0.1');
INSERT INTO `login_log` VALUES ('23', '10', '1694839775', '127.0.0.1');
INSERT INTO `login_log` VALUES ('24', '10', '1694839840', '127.0.0.1');
INSERT INTO `login_log` VALUES ('25', '10', '1694840302', '127.0.0.1');
INSERT INTO `login_log` VALUES ('26', '10', '1694840377', '127.0.0.1');
INSERT INTO `login_log` VALUES ('27', '10', '1694840453', '127.0.0.1');
INSERT INTO `login_log` VALUES ('28', '10', '1694840593', '127.0.0.1');
INSERT INTO `login_log` VALUES ('29', '10', '1694851549', '127.0.0.1');

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
  `keep_alive` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '保活',
  `show` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '菜单显示',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COMMENT='菜单';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '0', '1', '系统管理', 'system', '', '', 'Setting', '', '2', '1', '2');
INSERT INTO `menu` VALUES ('2', '1', '2', '用户管理', 'user', '/user', 'user/Index.vue', 'User', 'manage/User/initIndex\nmanage/User/getIndexUsers', '2', '1', '1');
INSERT INTO `menu` VALUES ('3', '2', '3', '添加', 'user_add', '', '', '', 'manage/User/initAdd\nmanage/User/saveAdd', '2', '1', '1');
INSERT INTO `menu` VALUES ('4', '2', '3', '修改', 'user_edit', '', '', '', 'manage/User/initEdit\nmanage/User/saveEdit', '2', '1', '2');
INSERT INTO `menu` VALUES ('5', '1', '2', '部门管理', 'department', '/department', 'department/Index.vue', 'Memo', 'manage/Department/getIndexDepartments', '2', '1', '2');
INSERT INTO `menu` VALUES ('6', '2', '3', '修改状态', 'user_edit_status', '', '', '', 'manage/User/editStatus', '2', '1', '3');
INSERT INTO `menu` VALUES ('7', '2', '3', '修改密码', 'user_edit_password', '', '', '', 'manage/User/editPassword', '2', '1', '5');
INSERT INTO `menu` VALUES ('8', '5', '3', '添加', 'department_add', '', '', '', 'manage/Department/initAdd\nmanage/Department/saveAdd', '2', '1', '1');
INSERT INTO `menu` VALUES ('9', '5', '3', '修改', 'department_edit', '', '', '', 'manage/Department/initEdit\nmanage/Department/saveEdit', '2', '1', '1');
INSERT INTO `menu` VALUES ('10', '5', '3', '删除', 'department_delete', '', '', '', 'manage/Department/delete', '2', '1', '3');
INSERT INTO `menu` VALUES ('11', '1', '2', '角色管理', 'role', '/role', 'role/Index.vue', 'ChatSquare', 'manage/Role/getIndexRoles', '2', '1', '3');
INSERT INTO `menu` VALUES ('12', '11', '3', '添加', 'role_add', '', '', '', 'manage/Role/initAdd\nmanage/Role/saveAdd', '2', '1', '1');
INSERT INTO `menu` VALUES ('13', '11', '3', '修改', 'role_edit', '', '', '', 'manage/Role/initEdit\nmanage/Role/saveEdit', '2', '1', '2');
INSERT INTO `menu` VALUES ('14', '11', '3', '删除', 'role_delete', '', '', '', 'manage/Role/delete', '2', '1', '3');
INSERT INTO `menu` VALUES ('15', '1', '2', '菜单管理', 'menu', '/menu', 'menu/Index.vue', 'Reading', 'manage/Menu/getIndexMenus', '2', '1', '4');
INSERT INTO `menu` VALUES ('16', '15', '3', '添加', 'menu_add', '', '', '', 'manage/Menu/initAdd\nmanage/Menu/saveAdd', '2', '1', '1');
INSERT INTO `menu` VALUES ('17', '15', '3', '修改', 'menu_edit', '', '', '', 'manage/Menu/initEdit\nmanage/Menu/saveEdit', '2', '1', '2');
INSERT INTO `menu` VALUES ('18', '15', '3', '删除', 'menu_delete', '', '', '', 'manage/Menu/delete', '2', '1', '3');
INSERT INTO `menu` VALUES ('19', '1', '2', '字典管理', 'dictionary', '/dictionary', 'dictionary/Index.vue', 'Document', 'manage/Dictionary/getIndexDictionarys', '2', '1', '5');
INSERT INTO `menu` VALUES ('20', '19', '3', '添加', 'dictionary_add', '', '', '', 'manage/Dictionary/saveAdd', '2', '1', '1');
INSERT INTO `menu` VALUES ('21', '19', '3', '修改', 'dictionary_edit', '', '', '', 'manage/Dictionary/initEdit\nmanage/Dictionary/saveEdit', '2', '1', '2');
INSERT INTO `menu` VALUES ('22', '19', '3', '删除', 'dictionary_delete', '', '', '', 'manage/Dictionary/delete', '2', '1', '3');
INSERT INTO `menu` VALUES ('23', '0', '2', '首页', 'index', '/index', 'Index.vue', 'House', '', '2', '1', '0');
INSERT INTO `menu` VALUES ('24', '0', '1', '个人中心', 'my', '', '', '', '', '2', '2', '3');
INSERT INTO `menu` VALUES ('25', '24', '3', '修改密码', 'my_edit_password', '', '', '', 'manage/my/editPassword', '2', '1', '1');
INSERT INTO `menu` VALUES ('26', '2', '3', '踢下线', 'user_offline', '', '', '', 'manage/User/offLine', '2', '1', '5');
INSERT INTO `menu` VALUES ('27', '1', '2', '登录日志', 'login_log', '/login-log', 'login_log/Index.vue', 'MapLocation', 'manage/LoginLog/getIndexLoginLogs', '2', '1', '6');
INSERT INTO `menu` VALUES ('28', '1', '2', '操作日志', 'operation_log', '/operation-log', 'operation_log/Index.vue', 'Mouse', 'manage/OperationLog/getIndexOperationLogs', '2', '1', '7');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT '消息标题',
  `url` varchar(128) NOT NULL DEFAULT '' COMMENT '跳转地址',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '消息时间',
  `read` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '已读',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=181 DEFAULT CHARSET=utf8mb4 COMMENT='消息';

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', '10', '消息标题', '/system/user', '1685957225', '1');
INSERT INTO `message` VALUES ('2', '11', '消息标题', '/system/user', '1685957225', '0');
INSERT INTO `message` VALUES ('3', '10', '消息标题', '/system/user', '1685957362', '1');
INSERT INTO `message` VALUES ('4', '11', '消息标题', '/system/user', '1685957362', '0');
INSERT INTO `message` VALUES ('5', '10', '消息标题', '/system/user', '1685957574', '1');
INSERT INTO `message` VALUES ('6', '11', '消息标题', '/system/user', '1685957574', '0');
INSERT INTO `message` VALUES ('7', '10', '消息标题', '/system/user', '1685957591', '1');
INSERT INTO `message` VALUES ('8', '11', '消息标题', '/system/user', '1685957591', '0');
INSERT INTO `message` VALUES ('9', '10', '消息标题', '/system/user', '1685957637', '1');
INSERT INTO `message` VALUES ('10', '11', '消息标题', '/system/user', '1685957637', '0');
INSERT INTO `message` VALUES ('11', '10', '消息标题', '/system/user', '1685957661', '1');
INSERT INTO `message` VALUES ('12', '11', '消息标题', '/system/user', '1685957661', '0');
INSERT INTO `message` VALUES ('13', '10', '消息标题', '/system/user', '1685957678', '1');
INSERT INTO `message` VALUES ('14', '11', '消息标题', '/system/user', '1685957678', '0');
INSERT INTO `message` VALUES ('15', '10', '消息标题', '/system/user', '1685957822', '1');
INSERT INTO `message` VALUES ('16', '11', '消息标题', '/system/user', '1685957822', '0');
INSERT INTO `message` VALUES ('17', '10', '消息标题', '/system/user', '1685957857', '1');
INSERT INTO `message` VALUES ('18', '11', '消息标题', '/system/user', '1685957857', '0');
INSERT INTO `message` VALUES ('19', '10', '消息标题', '/system/user', '1685957902', '1');
INSERT INTO `message` VALUES ('20', '11', '消息标题', '/system/user', '1685957902', '0');
INSERT INTO `message` VALUES ('21', '10', '消息标题', '/system/user', '1685957931', '1');
INSERT INTO `message` VALUES ('22', '11', '消息标题', '/system/user', '1685957931', '0');
INSERT INTO `message` VALUES ('23', '10', '消息标题', '/system/user', '1685958400', '1');
INSERT INTO `message` VALUES ('24', '11', '消息标题', '/system/user', '1685958400', '0');
INSERT INTO `message` VALUES ('25', '10', '消息标题', '/system/user', '1685958403', '1');
INSERT INTO `message` VALUES ('26', '11', '消息标题', '/system/user', '1685958403', '0');
INSERT INTO `message` VALUES ('27', '10', '消息标题', '/system/user', '1685958535', '1');
INSERT INTO `message` VALUES ('28', '11', '消息标题', '/system/user', '1685958535', '0');
INSERT INTO `message` VALUES ('29', '10', '消息标题', '/system/user', '1685958550', '1');
INSERT INTO `message` VALUES ('30', '11', '消息标题', '/system/user', '1685958550', '0');
INSERT INTO `message` VALUES ('31', '10', '消息标题', '/system/user', '1685958552', '1');
INSERT INTO `message` VALUES ('32', '11', '消息标题', '/system/user', '1685958553', '0');
INSERT INTO `message` VALUES ('33', '10', '消息标题', '/system/user', '1685958555', '1');
INSERT INTO `message` VALUES ('34', '11', '消息标题', '/system/user', '1685958555', '0');
INSERT INTO `message` VALUES ('35', '10', '消息标题', '/system/user', '1685958557', '1');
INSERT INTO `message` VALUES ('36', '11', '消息标题', '/system/user', '1685958557', '0');
INSERT INTO `message` VALUES ('37', '10', '消息标题', '/system/user', '1685958561', '1');
INSERT INTO `message` VALUES ('38', '11', '消息标题', '/system/user', '1685958562', '0');
INSERT INTO `message` VALUES ('39', '10', '消息标题', '/system/user', '1685958656', '1');
INSERT INTO `message` VALUES ('40', '11', '消息标题', '/system/user', '1685958656', '0');
INSERT INTO `message` VALUES ('41', '10', '消息标题', '/system/user', '1685958664', '1');
INSERT INTO `message` VALUES ('42', '11', '消息标题', '/system/user', '1685958665', '0');
INSERT INTO `message` VALUES ('43', '10', '消息标题', '/system/user', '1685958679', '1');
INSERT INTO `message` VALUES ('44', '11', '消息标题', '/system/user', '1685958680', '0');
INSERT INTO `message` VALUES ('45', '10', '消息标题', '/system/user', '1685958697', '1');
INSERT INTO `message` VALUES ('46', '11', '消息标题', '/system/user', '1685958697', '0');
INSERT INTO `message` VALUES ('47', '10', '消息标题', '/system/user', '1685958751', '1');
INSERT INTO `message` VALUES ('48', '11', '消息标题', '/system/user', '1685958751', '0');
INSERT INTO `message` VALUES ('49', '10', '消息标题', '/system/user', '1685958773', '1');
INSERT INTO `message` VALUES ('50', '11', '消息标题', '/system/user', '1685958773', '0');
INSERT INTO `message` VALUES ('51', '10', '消息标题', '/system/user', '1685958775', '1');
INSERT INTO `message` VALUES ('52', '11', '消息标题', '/system/user', '1685958775', '0');
INSERT INTO `message` VALUES ('53', '10', '消息标题', '/system/user', '1685958775', '1');
INSERT INTO `message` VALUES ('54', '11', '消息标题', '/system/user', '1685958775', '0');
INSERT INTO `message` VALUES ('55', '10', '消息标题', '/system/user', '1685958775', '1');
INSERT INTO `message` VALUES ('56', '11', '消息标题', '/system/user', '1685958775', '0');
INSERT INTO `message` VALUES ('57', '10', '消息标题', '/system/user', '1685958775', '1');
INSERT INTO `message` VALUES ('58', '11', '消息标题', '/system/user', '1685958775', '0');
INSERT INTO `message` VALUES ('59', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('60', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('61', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('62', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('63', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('64', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('65', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('66', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('67', '10', '消息标题', '/system/user', '1685958776', '1');
INSERT INTO `message` VALUES ('68', '11', '消息标题', '/system/user', '1685958776', '0');
INSERT INTO `message` VALUES ('69', '10', '消息标题', '/system/user', '1685958783', '1');
INSERT INTO `message` VALUES ('70', '11', '消息标题', '/system/user', '1685958783', '0');
INSERT INTO `message` VALUES ('71', '10', '消息标题', '/system/user', '1685959087', '1');
INSERT INTO `message` VALUES ('72', '11', '消息标题', '/system/user', '1685959087', '0');
INSERT INTO `message` VALUES ('73', '10', '消息标题', '/system/user', '1686013370', '1');
INSERT INTO `message` VALUES ('74', '11', '消息标题', '/system/user', '1686013370', '0');
INSERT INTO `message` VALUES ('75', '10', '消息标题', '/system/user', '1686032055', '1');
INSERT INTO `message` VALUES ('76', '11', '消息标题', '/system/user', '1686032055', '0');
INSERT INTO `message` VALUES ('77', '10', '消息标题', '/system/user', '1686032060', '1');
INSERT INTO `message` VALUES ('78', '11', '消息标题', '/system/user', '1686032060', '0');
INSERT INTO `message` VALUES ('79', '10', '消息提醒标题', '/admin/system/loginLog', '1686121349', '1');
INSERT INTO `message` VALUES ('80', '11', '消息提醒标题', '/admin/system/loginLog', '1686121349', '0');
INSERT INTO `message` VALUES ('81', '10', '消息提醒标题', '/system/loginLog', '1686121586', '1');
INSERT INTO `message` VALUES ('82', '11', '消息提醒标题', '/system/loginLog', '1686121587', '0');
INSERT INTO `message` VALUES ('83', '10', '消息提醒标题', '/system/user', '1686121587', '1');
INSERT INTO `message` VALUES ('84', '11', '消息提醒标题', '/system/user', '1686121587', '0');
INSERT INTO `message` VALUES ('85', '10', '消息提醒标题', '/system/loginLog', '1686121657', '1');
INSERT INTO `message` VALUES ('86', '11', '消息提醒标题', '/system/loginLog', '1686121657', '0');
INSERT INTO `message` VALUES ('87', '10', '消息提醒标题', '/system/user', '1686121657', '1');
INSERT INTO `message` VALUES ('88', '11', '消息提醒标题', '/system/user', '1686121657', '0');
INSERT INTO `message` VALUES ('89', '10', '消息提醒标题', '/system/loginLog', '1686295402', '1');
INSERT INTO `message` VALUES ('90', '11', '消息提醒标题', '/system/loginLog', '1686295402', '0');
INSERT INTO `message` VALUES ('91', '10', '标题1694497219', '/user', '1694497220', '1');
INSERT INTO `message` VALUES ('92', '11', '标题1694497219', '/user', '1694497220', '0');
INSERT INTO `message` VALUES ('93', '10', '标题1694497229', '/user', '1694497230', '1');
INSERT INTO `message` VALUES ('94', '11', '标题1694497229', '/user', '1694497230', '0');
INSERT INTO `message` VALUES ('95', '10', '标题1694497265', '/user', '1694497265', '1');
INSERT INTO `message` VALUES ('96', '11', '标题1694497265', '/user', '1694497265', '0');
INSERT INTO `message` VALUES ('97', '10', '标题1694497267', '/user', '1694497267', '1');
INSERT INTO `message` VALUES ('98', '11', '标题1694497267', '/user', '1694497267', '0');
INSERT INTO `message` VALUES ('99', '10', '标题1694497268', '/user', '1694497268', '1');
INSERT INTO `message` VALUES ('100', '11', '标题1694497268', '/user', '1694497268', '0');
INSERT INTO `message` VALUES ('101', '10', '标题1694497269', '/user', '1694497269', '1');
INSERT INTO `message` VALUES ('102', '11', '标题1694497269', '/user', '1694497269', '0');
INSERT INTO `message` VALUES ('103', '10', '标题1694497270', '/user', '1694497270', '1');
INSERT INTO `message` VALUES ('104', '11', '标题1694497270', '/user', '1694497270', '0');
INSERT INTO `message` VALUES ('105', '10', '标题1694497270', '/user', '1694497270', '1');
INSERT INTO `message` VALUES ('106', '11', '标题1694497270', '/user', '1694497270', '0');
INSERT INTO `message` VALUES ('107', '10', '标题1694497271', '/user', '1694497271', '1');
INSERT INTO `message` VALUES ('108', '11', '标题1694497271', '/user', '1694497271', '0');
INSERT INTO `message` VALUES ('109', '10', '标题1694497272', '/user', '1694497272', '1');
INSERT INTO `message` VALUES ('110', '11', '标题1694497272', '/user', '1694497272', '0');
INSERT INTO `message` VALUES ('111', '10', '标题1694497273', '/user', '1694497273', '1');
INSERT INTO `message` VALUES ('112', '11', '标题1694497273', '/user', '1694497273', '0');
INSERT INTO `message` VALUES ('113', '10', '标题1694497273', '/user', '1694497273', '1');
INSERT INTO `message` VALUES ('114', '11', '标题1694497273', '/user', '1694497273', '0');
INSERT INTO `message` VALUES ('115', '10', '标题1694497273', '/user', '1694497273', '1');
INSERT INTO `message` VALUES ('116', '11', '标题1694497273', '/user', '1694497273', '0');
INSERT INTO `message` VALUES ('117', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('118', '11', '标题1694497274', '/user', '1694497274', '0');
INSERT INTO `message` VALUES ('119', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('120', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('121', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('122', '11', '标题1694497274', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('123', '10', '标题1694497274', '/user', '1694497274', '1');
INSERT INTO `message` VALUES ('124', '11', '标题1694497274', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('125', '11', '标题1694497274', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('126', '11', '标题1694497274', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('127', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('128', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('129', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('130', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('131', '10', '标题1694497275', '/user', '1694497275', '1');
INSERT INTO `message` VALUES ('132', '11', '标题1694497275', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('133', '11', '标题1694497275', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('134', '11', '标题1694497275', '/user', '1694497275', '0');
INSERT INTO `message` VALUES ('135', '11', '标题1694497275', '/user', '1694497276', '0');
INSERT INTO `message` VALUES ('136', '11', '标题1694497275', '/user', '1694497276', '0');
INSERT INTO `message` VALUES ('137', '10', '标题1694497276', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('138', '10', '标题1694497275', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('139', '10', '标题1694497275', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('140', '10', '标题1694497275', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('141', '10', '标题1694497275', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('142', '10', '标题1694497276', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('143', '10', '标题1694497276', '/user', '1694497276', '1');
INSERT INTO `message` VALUES ('144', '10', '标题1694497276', '/user', '1694497277', '1');
INSERT INTO `message` VALUES ('145', '11', '标题1694497276', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('146', '11', '标题1694497275', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('147', '11', '标题1694497275', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('148', '11', '标题1694497276', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('149', '11', '标题1694497275', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('150', '11', '标题1694497275', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('151', '11', '标题1694497276', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('152', '11', '标题1694497276', '/user', '1694497277', '0');
INSERT INTO `message` VALUES ('153', '10', '标题1694497277', '/user', '1694497277', '1');
INSERT INTO `message` VALUES ('154', '11', '标题1694497277', '/user', '1694497278', '0');
INSERT INTO `message` VALUES ('155', '10', '标题1694497280', '/user', '1694497280', '1');
INSERT INTO `message` VALUES ('156', '11', '标题1694497280', '/user', '1694497280', '0');
INSERT INTO `message` VALUES ('157', '10', '标题1694497281', '/user', '1694497281', '1');
INSERT INTO `message` VALUES ('158', '11', '标题1694497281', '/user', '1694497281', '0');
INSERT INTO `message` VALUES ('159', '10', '标题1694497282', '/user', '1694497282', '1');
INSERT INTO `message` VALUES ('160', '11', '标题1694497282', '/user', '1694497283', '0');
INSERT INTO `message` VALUES ('161', '10', '标题1694497283', '/user', '1694497283', '1');
INSERT INTO `message` VALUES ('162', '11', '标题1694497283', '/user', '1694497283', '0');
INSERT INTO `message` VALUES ('163', '10', '消息标题1694836600', '/login-log', '1694836600', '1');
INSERT INTO `message` VALUES ('164', '11', '消息标题1694836600', '/login-log', '1694836600', '0');
INSERT INTO `message` VALUES ('165', '10', '消息标题1694836609', '/login-log', '1694836609', '1');
INSERT INTO `message` VALUES ('166', '11', '消息标题1694836609', '/login-log', '1694836609', '0');
INSERT INTO `message` VALUES ('167', '10', '消息标题1694840058', '/login-log', '1694840058', '1');
INSERT INTO `message` VALUES ('168', '11', '消息标题1694840058', '/login-log', '1694840058', '0');
INSERT INTO `message` VALUES ('169', '10', '消息标题1694840065', '/login-log', '1694840065', '1');
INSERT INTO `message` VALUES ('170', '11', '消息标题1694840065', '/login-log', '1694840065', '0');
INSERT INTO `message` VALUES ('171', '10', '消息标题1694840066', '/login-log', '1694840066', '1');
INSERT INTO `message` VALUES ('172', '11', '消息标题1694840066', '/login-log', '1694840067', '0');
INSERT INTO `message` VALUES ('173', '10', '消息标题1694840073', '/login-log', '1694840073', '1');
INSERT INTO `message` VALUES ('174', '11', '消息标题1694840073', '/login-log', '1694840073', '0');
INSERT INTO `message` VALUES ('175', '10', '消息标题1694840767', '/login-log', '1694840767', '1');
INSERT INTO `message` VALUES ('176', '11', '消息标题1694840767', '/login-log', '1694840767', '0');
INSERT INTO `message` VALUES ('177', '10', '消息标题1694840773', '/login-log', '1694840773', '1');
INSERT INTO `message` VALUES ('178', '11', '消息标题1694840773', '/login-log', '1694840773', '0');
INSERT INTO `message` VALUES ('179', '10', '消息标题1694840775', '/login-log', '1694840775', '1');
INSERT INTO `message` VALUES ('180', '11', '消息标题1694840775', '/login-log', '1694840775', '0');

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `ip` varchar(64) NOT NULL DEFAULT '' COMMENT '操作ip',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '操作地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=800 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('1', '10', '1686121413', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('2', '10', '1686121546', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('3', '10', '1686121546', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('4', '10', '1686121549', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('5', '10', '1686121575', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('6', '10', '1686121595', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('7', '10', '1686121603', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('8', '10', '1686121606', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('9', '10', '1686121612', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('10', '10', '1686121613', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('11', '10', '1686121615', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('12', '10', '1686121659', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('13', '10', '1686121661', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('14', '10', '1686121667', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('15', '10', '1686121688', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('16', '10', '1686121690', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('17', '10', '1686121691', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('18', '10', '1686121694', '127.0.0.1', '/admin/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('19', '10', '1686195629', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('20', '10', '1686195632', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('21', '10', '1686195640', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('22', '10', '1686195660', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('23', '10', '1686195662', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('24', '10', '1686202950', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('25', '10', '1686202954', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('26', '10', '1686203041', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('27', '10', '1686203536', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('28', '10', '1686282150', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('29', '10', '1686282154', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('30', '10', '1686282157', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('31', '10', '1686282160', '127.0.0.1', '/admin/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('32', '10', '1686282961', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('33', '10', '1686282962', '127.0.0.1', '/admin/system.user/initadd');
INSERT INTO `operation_log` VALUES ('34', '10', '1686282974', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('35', '10', '1686282975', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('36', '10', '1686282979', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('37', '10', '1686283076', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('38', '10', '1686283077', '127.0.0.1', '/admin/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('39', '10', '1686283083', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('40', '10', '1686283085', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('41', '10', '1686283128', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('42', '10', '1686283131', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('43', '10', '1686283135', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('44', '10', '1686283158', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('45', '10', '1686283251', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('46', '10', '1686283253', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('47', '10', '1686283255', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('48', '10', '1686283256', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('49', '10', '1686283258', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('50', '10', '1686283260', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('51', '10', '1686283264', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('52', '10', '1686283265', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('53', '10', '1686283266', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('54', '10', '1686283267', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('55', '10', '1686283269', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('56', '10', '1686283270', '127.0.0.1', '/admin/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('57', '10', '1686283325', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('58', '10', '1686283511', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('59', '10', '1686283513', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('60', '10', '1686283514', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('61', '10', '1686283515', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('62', '10', '1686283517', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('63', '10', '1686283518', '127.0.0.1', '/admin/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('64', '10', '1686285084', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('65', '10', '1686285085', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('66', '10', '1686285086', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('67', '10', '1686285087', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('68', '10', '1686285088', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('69', '10', '1686285089', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('70', '10', '1686285092', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('71', '10', '1686285093', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('72', '10', '1686285094', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('73', '10', '1686285095', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('74', '10', '1686285096', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('75', '10', '1686285097', '127.0.0.1', '/admin/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('76', '10', '1686285104', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('77', '10', '1686285105', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('78', '10', '1686285106', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('79', '10', '1686285107', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('80', '10', '1686285108', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('81', '10', '1686285109', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('82', '10', '1686285110', '127.0.0.1', '/admin/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('83', '10', '1686291912', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('84', '10', '1686291915', '127.0.0.1', '/admin/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('85', '10', '1686291919', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('86', '10', '1686291921', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('87', '10', '1686291924', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('88', '10', '1686291936', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('89', '10', '1686291950', '127.0.0.1', '/admin/system.user/offline');
INSERT INTO `operation_log` VALUES ('90', '10', '1686293532', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('91', '10', '1686293575', '127.0.0.1', '/admin/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('92', '10', '1686293576', '127.0.0.1', '/admin/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('93', '10', '1686293577', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('94', '10', '1686293579', '127.0.0.1', '/admin/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('95', '10', '1686293583', '127.0.0.1', '/admin/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('96', '10', '1686293585', '127.0.0.1', '/admin/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('97', '10', '1686293783', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('98', '10', '1686299651', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('99', '10', '1686300039', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('100', '10', '1686300049', '127.0.0.1', '/admin/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('101', '10', '1686300061', '127.0.0.1', '/admin/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('102', '10', '1686300061', '127.0.0.1', '/admin/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('103', '10', '1686300066', '127.0.0.1', '/admin/system.user/initindex');
INSERT INTO `operation_log` VALUES ('104', '10', '1686300066', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('105', '10', '1686300178', '127.0.0.1', '/admin/system.user/initindex');
INSERT INTO `operation_log` VALUES ('106', '10', '1686300178', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('107', '10', '1686300240', '127.0.0.1', '/admin/system.user/initindex');
INSERT INTO `operation_log` VALUES ('108', '10', '1686300240', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('109', '10', '1686300249', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('110', '10', '1686302675', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('111', '10', '1686302750', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('112', '10', '1686302776', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('113', '10', '1686302781', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('114', '10', '1686302793', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('115', '10', '1686302801', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('116', '10', '1686303680', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('117', '10', '1686303697', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('118', '10', '1686303742', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('119', '10', '1686303770', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('120', '10', '1686303813', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('121', '10', '1686303872', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('122', '10', '1686303883', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('123', '10', '1686303886', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('124', '10', '1686303889', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('125', '10', '1686303892', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('126', '10', '1686303895', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('127', '10', '1686304096', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('128', '10', '1686304398', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('129', '10', '1686304415', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('130', '10', '1686304467', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('131', '10', '1686304476', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('132', '10', '1686304485', '127.0.0.1', '/admin/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('133', '10', '1686624874', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('134', '10', '1686624879', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('135', '10', '1686624883', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('136', '10', '1686624883', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('137', '10', '1686624885', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('138', '10', '1686624885', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('139', '10', '1686624940', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('140', '10', '1686625007', '127.0.0.1', '/admin/user/editpassword');
INSERT INTO `operation_log` VALUES ('141', '10', '1686625020', '127.0.0.1', '/admin/user/editpassword');
INSERT INTO `operation_log` VALUES ('142', '10', '1686625022', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('143', '10', '1686625037', '127.0.0.1', '/admin/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('144', '10', '1686625039', '127.0.0.1', '/admin/role/getindexroles');
INSERT INTO `operation_log` VALUES ('145', '10', '1686625040', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('146', '10', '1686625042', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('147', '10', '1686625043', '127.0.0.1', '/admin/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('148', '10', '1686625045', '127.0.0.1', '/admin/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('149', '10', '1686625481', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('150', '10', '1686625481', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('151', '10', '1686625489', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('152', '10', '1686625493', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('153', '10', '1686625498', '127.0.0.1', '/admin/user/initedit');
INSERT INTO `operation_log` VALUES ('154', '10', '1686625502', '127.0.0.1', '/admin/user/saveedit');
INSERT INTO `operation_log` VALUES ('155', '10', '1686625503', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('156', '10', '1686625508', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('157', '10', '1686625510', '127.0.0.1', '/admin/user/initedit');
INSERT INTO `operation_log` VALUES ('158', '10', '1686625515', '127.0.0.1', '/admin/user/initedit');
INSERT INTO `operation_log` VALUES ('159', '10', '1686625524', '127.0.0.1', '/admin/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('160', '10', '1686625526', '127.0.0.1', '/admin/role/getindexroles');
INSERT INTO `operation_log` VALUES ('161', '10', '1686625528', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('162', '10', '1686625530', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('163', '10', '1686625532', '127.0.0.1', '/admin/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('164', '10', '1686625534', '127.0.0.1', '/admin/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('165', '10', '1686625541', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('166', '10', '1686625541', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('167', '10', '1686625544', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('168', '10', '1686625545', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('169', '10', '1686625555', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('170', '10', '1686625555', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('171', '10', '1687666973', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('172', '10', '1687666977', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('173', '10', '1687666987', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('174', '10', '1687666988', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('175', '10', '1687666991', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('176', '10', '1687666997', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('177', '10', '1687666998', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('178', '10', '1687667000', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('179', '10', '1687667012', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('180', '10', '1687667012', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('181', '10', '1687667015', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('182', '10', '1687667018', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('183', '10', '1687667018', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('184', '10', '1687667021', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('185', '10', '1687667028', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('186', '10', '1687667028', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('187', '10', '1687667031', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('188', '10', '1687667038', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('189', '10', '1687667038', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('190', '10', '1687667043', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('191', '10', '1687667046', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('192', '10', '1687667046', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('193', '10', '1687667088', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('194', '10', '1687667094', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('195', '10', '1687667094', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('196', '10', '1687667097', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('197', '10', '1687667101', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('198', '10', '1687667101', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('199', '10', '1687667104', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('200', '10', '1687667107', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('201', '10', '1687667107', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('202', '10', '1687667114', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('203', '10', '1687667119', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('204', '10', '1687667120', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('205', '10', '1687667122', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('206', '10', '1687667129', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('207', '10', '1687667129', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('208', '10', '1687667135', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('209', '10', '1687667154', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('210', '10', '1687667155', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('211', '10', '1687667160', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('212', '10', '1687667163', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('213', '10', '1687667163', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('214', '10', '1687667168', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('215', '10', '1687667173', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('216', '10', '1687667173', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('217', '10', '1687667175', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('218', '10', '1687667184', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('219', '10', '1687667184', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('220', '10', '1687667189', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('221', '10', '1687667195', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('222', '10', '1687667195', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('223', '10', '1687667198', '127.0.0.1', '/admin/menu/initedit');
INSERT INTO `operation_log` VALUES ('224', '10', '1687667203', '127.0.0.1', '/admin/menu/saveedit');
INSERT INTO `operation_log` VALUES ('225', '10', '1687667204', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('226', '10', '1687667258', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('227', '10', '1687667259', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('228', '10', '1687667260', '127.0.0.1', '/admin/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('229', '10', '1687667261', '127.0.0.1', '/admin/role/getindexroles');
INSERT INTO `operation_log` VALUES ('230', '10', '1687667262', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('231', '10', '1687667262', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('232', '10', '1687667265', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('233', '10', '1687667286', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('234', '10', '1687667286', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('235', '10', '1687667294', '127.0.0.1', '/admin/user/initedit');
INSERT INTO `operation_log` VALUES ('236', '10', '1687667309', '127.0.0.1', '/admin/user/saveedit');
INSERT INTO `operation_log` VALUES ('237', '10', '1687667309', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('238', '10', '1687667312', '127.0.0.1', '/admin/user/initedit');
INSERT INTO `operation_log` VALUES ('239', '10', '1687667324', '127.0.0.1', '/admin/user/saveedit');
INSERT INTO `operation_log` VALUES ('240', '10', '1687667324', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('241', '10', '1687667326', '127.0.0.1', '/admin/user/initedit');
INSERT INTO `operation_log` VALUES ('242', '10', '1687667332', '127.0.0.1', '/admin/user/saveedit');
INSERT INTO `operation_log` VALUES ('243', '10', '1687667333', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('244', '10', '1688265247', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('245', '10', '1688265247', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('246', '10', '1688265250', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('247', '10', '1688265252', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('248', '10', '1688265252', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('249', '10', '1688265258', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('250', '10', '1688265258', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('251', '10', '1688265261', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('252', '10', '1688265270', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('253', '10', '1688265310', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('254', '10', '1688265316', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('255', '10', '1688265316', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('256', '10', '1688265316', '127.0.0.1', '/admin/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('257', '10', '1688028585', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('258', '10', '1688028585', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('259', '10', '1688028586', '127.0.0.1', '/admin/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('260', '10', '1688028638', '127.0.0.1', '/admin/role/getindexroles');
INSERT INTO `operation_log` VALUES ('261', '10', '1688028639', '127.0.0.1', '/admin/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('262', '10', '1688028650', '127.0.0.1', '/admin/role/getindexroles');
INSERT INTO `operation_log` VALUES ('263', '10', '1688028651', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('264', '10', '1688028654', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('265', '10', '1688028659', '127.0.0.1', '/admin/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('266', '10', '1688028663', '127.0.0.1', '/admin/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('267', '10', '1688028665', '127.0.0.1', '/admin/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('268', '10', '1688028679', '127.0.0.1', '/admin/user/initindex');
INSERT INTO `operation_log` VALUES ('269', '10', '1688028679', '127.0.0.1', '/admin/user/getindexusers');
INSERT INTO `operation_log` VALUES ('270', '10', '1688028682', '127.0.0.1', '/admin/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('271', '10', '1688028683', '127.0.0.1', '/admin/role/getindexroles');
INSERT INTO `operation_log` VALUES ('272', '10', '1688028695', '127.0.0.1', '/admin/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('273', '10', '1694427067', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('274', '10', '1694427068', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('275', '10', '1694427069', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('276', '10', '1694427069', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('277', '10', '1694427078', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('278', '10', '1694427078', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('279', '10', '1694427078', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('280', '10', '1694427078', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('281', '10', '1694427086', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('282', '10', '1694427086', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('283', '10', '1694427087', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('284', '10', '1694427087', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('285', '10', '1694482302', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('286', '10', '1694482302', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('287', '10', '1694482303', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('288', '10', '1694482303', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('289', '10', '1694482676', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('290', '10', '1694482677', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('291', '10', '1694482677', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('292', '10', '1694482677', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('293', '10', '1694482960', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('294', '10', '1694482960', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('295', '10', '1694482961', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('296', '10', '1694482961', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('297', '10', '1694483040', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('298', '10', '1694483040', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('299', '10', '1694483041', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('300', '10', '1694483041', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('301', '10', '1694484672', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('302', '10', '1694484682', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('303', '10', '1694484682', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('304', '10', '1694484683', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('305', '10', '1694484683', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('306', '10', '1694484721', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('307', '10', '1694484793', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('308', '10', '1694484793', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('309', '10', '1694484803', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('310', '10', '1694484803', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('311', '10', '1694484810', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('312', '10', '1694484810', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('313', '10', '1694484811', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('314', '10', '1694484811', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('315', '10', '1694484836', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('316', '10', '1694484836', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('317', '10', '1694484840', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('318', '10', '1694484840', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('319', '10', '1694484885', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('320', '10', '1694484886', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('321', '10', '1694484886', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('322', '10', '1694484886', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('323', '10', '1694485159', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('324', '10', '1694485159', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('325', '10', '1694485159', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('326', '10', '1694485166', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('327', '10', '1694485166', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('328', '10', '1694485166', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('329', '10', '1694485166', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('330', '10', '1694491049', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('331', '10', '1694491050', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('332', '10', '1694491051', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('333', '10', '1694491051', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('334', '10', '1694496968', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('335', '10', '1694496970', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('336', '10', '1694496972', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('337', '10', '1694496972', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('338', '10', '1694496973', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('339', '10', '1694497037', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('340', '10', '1694497037', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('341', '10', '1694497038', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('342', '10', '1694497038', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('343', '10', '1694497038', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('344', '10', '1694497222', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('345', '10', '1694497231', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('346', '10', '1694497266', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('347', '10', '1694497267', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('348', '10', '1694497268', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('349', '10', '1694497269', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('350', '10', '1694497270', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('351', '10', '1694497271', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('352', '10', '1694497272', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('353', '10', '1694497272', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('354', '10', '1694497273', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('355', '10', '1694497273', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('356', '10', '1694497274', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('357', '10', '1694497275', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('358', '10', '1694497275', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('359', '10', '1694497275', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('360', '10', '1694497277', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('361', '10', '1694497277', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('362', '10', '1694497277', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('363', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('364', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('365', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('366', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('367', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('368', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('369', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('370', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('371', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('372', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('373', '10', '1694497278', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('374', '10', '1694497279', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('375', '10', '1694497279', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('376', '10', '1694497281', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('377', '10', '1694497282', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('378', '10', '1694497283', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('379', '10', '1694497284', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('380', '10', '1694497289', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('381', '10', '1694497408', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('382', '10', '1694497408', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('383', '10', '1694497409', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('384', '10', '1694497409', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('385', '10', '1694497409', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('386', '10', '1694497423', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('387', '10', '1694497423', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('388', '10', '1694497424', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('389', '10', '1694497424', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('390', '10', '1694497424', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('391', '10', '1694497483', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('392', '10', '1694497484', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('393', '10', '1694497484', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('394', '10', '1694497484', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('395', '10', '1694497484', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('396', '10', '1694497675', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('397', '10', '1694497675', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('398', '10', '1694497676', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('399', '10', '1694497676', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('400', '10', '1694497676', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('401', '10', '1694497689', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('402', '10', '1694497689', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('403', '10', '1694497691', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('404', '10', '1694497691', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('405', '10', '1694497691', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('406', '10', '1694498338', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('407', '10', '1694498338', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('408', '10', '1694498340', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('409', '10', '1694498340', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('410', '10', '1694498340', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('411', '10', '1694498531', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('412', '10', '1694498545', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('413', '10', '1694499785', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('414', '10', '1694499785', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('415', '10', '1694499786', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('416', '10', '1694499786', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('417', '10', '1694499786', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('418', '10', '1694499786', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('419', '10', '1694500441', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('420', '10', '1694500443', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('421', '10', '1694500445', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('422', '10', '1694500910', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('423', '10', '1694500911', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('424', '10', '1694500913', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('425', '10', '1694500914', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('426', '10', '1694500920', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('427', '10', '1694500921', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('428', '10', '1694500922', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('429', '10', '1694500923', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('430', '10', '1694500952', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('431', '10', '1694501073', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('432', '10', '1694501074', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('433', '10', '1694501085', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('434', '10', '1694501237', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('435', '10', '1694501238', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('436', '10', '1694501242', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('437', '10', '1694501245', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('438', '10', '1694501247', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('439', '10', '1694501248', '127.0.0.1', '/manage/dictionary/initedit');
INSERT INTO `operation_log` VALUES ('440', '10', '1694501249', '127.0.0.1', '/manage/dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('441', '10', '1694501257', '127.0.0.1', '/manage/dictionary/initedit');
INSERT INTO `operation_log` VALUES ('442', '10', '1694501261', '127.0.0.1', '/manage/dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('443', '10', '1694501298', '127.0.0.1', '/manage/dictionary/initedit');
INSERT INTO `operation_log` VALUES ('444', '10', '1694501298', '127.0.0.1', '/manage/dictionary/saveedit');
INSERT INTO `operation_log` VALUES ('445', '10', '1694501299', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('446', '10', '1694501300', '127.0.0.1', '/manage/dictionary/initedit');
INSERT INTO `operation_log` VALUES ('447', '10', '1694501386', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('448', '10', '1694501641', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('449', '10', '1694501641', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('450', '10', '1694501642', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('451', '10', '1694501642', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('452', '10', '1694501643', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('453', '10', '1694501643', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('454', '10', '1694501755', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('455', '10', '1694501755', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('456', '10', '1694501756', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('457', '10', '1694501756', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('458', '10', '1694501756', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('459', '10', '1694501756', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('460', '10', '1694501760', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('461', '10', '1694501778', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('462', '10', '1694501781', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('463', '10', '1694501781', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('464', '10', '1694501783', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('465', '10', '1694501784', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('466', '10', '1694501784', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('467', '10', '1694501802', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('468', '10', '1694501952', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('469', '10', '1694501952', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('470', '10', '1694501953', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('471', '10', '1694501953', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('472', '10', '1694501953', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('473', '10', '1694501953', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('474', '10', '1694502093', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('475', '10', '1694502095', '127.0.0.1', '/manage/department/initedit');
INSERT INTO `operation_log` VALUES ('476', '10', '1694502096', '127.0.0.1', '/manage/department/saveedit');
INSERT INTO `operation_log` VALUES ('477', '10', '1694502096', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('478', '10', '1694502099', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('479', '10', '1694502099', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('480', '10', '1694502374', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('481', '10', '1694502375', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('482', '10', '1694502376', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('483', '10', '1694502381', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('484', '10', '1694502417', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('485', '10', '1694502420', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('486', '10', '1694502421', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('487', '10', '1694502422', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('488', '10', '1694502428', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('489', '10', '1694502430', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('490', '10', '1694502430', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('491', '10', '1694502433', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('492', '10', '1694502433', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('493', '10', '1694502433', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('494', '10', '1694502434', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('495', '10', '1694502434', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('496', '10', '1694502435', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('497', '10', '1694502436', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('498', '10', '1694502437', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('499', '10', '1694502438', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('500', '10', '1694502438', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('501', '10', '1694502439', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('502', '10', '1694502439', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('503', '10', '1694502439', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('504', '10', '1694502475', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('505', '10', '1694502476', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('506', '10', '1694502477', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('507', '10', '1694502495', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('508', '10', '1694502495', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('509', '10', '1694502523', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('510', '10', '1694502523', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('511', '10', '1694502524', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('512', '10', '1694502525', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('513', '10', '1694502526', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('514', '10', '1694502528', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('515', '10', '1694502531', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('516', '10', '1694502533', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('517', '10', '1694502667', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('518', '10', '1694502667', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('519', '10', '1694502669', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('520', '10', '1694504323', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('521', '10', '1694504478', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('522', '10', '1694504502', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('523', '10', '1694504506', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('524', '10', '1694504571', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('525', '10', '1694504639', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('526', '10', '1694504778', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('527', '10', '1694504833', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('528', '10', '1694504913', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('529', '10', '1694504915', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('530', '10', '1694504916', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('531', '10', '1694504990', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('532', '10', '1694504998', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('533', '10', '1694505021', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('534', '10', '1694505046', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('535', '10', '1694505051', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('536', '10', '1694505051', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('537', '10', '1694505053', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('538', '10', '1694505056', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('539', '10', '1694505056', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('540', '10', '1694505057', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('541', '10', '1694505066', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('542', '10', '1694505069', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('543', '10', '1694505070', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('544', '10', '1694505071', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('545', '10', '1694505074', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('546', '10', '1694505075', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('547', '10', '1694505247', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('548', '10', '1694505247', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('549', '10', '1694505277', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('550', '10', '1694505294', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('551', '10', '1694505307', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('552', '10', '1694505307', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('553', '10', '1694505310', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('554', '10', '1694505312', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('555', '10', '1694505313', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('556', '10', '1694505313', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('557', '10', '1694505316', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('558', '10', '1694505320', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('559', '10', '1694505323', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('560', '10', '1694505324', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('561', '10', '1694505326', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('562', '10', '1694505327', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('563', '10', '1694505328', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('564', '10', '1694505329', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('565', '10', '1694505329', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('566', '10', '1694505329', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('567', '10', '1694505331', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('568', '10', '1694505331', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('569', '10', '1694505333', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('570', '10', '1694505335', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('571', '10', '1694505337', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('572', '10', '1694505337', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('573', '10', '1694505361', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('574', '10', '1694505362', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('575', '10', '1694505365', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('576', '10', '1694505365', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('577', '10', '1694505365', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('578', '10', '1694505365', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('579', '10', '1694505367', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('580', '10', '1694505408', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('581', '10', '1694505409', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('582', '10', '1694505416', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('583', '10', '1694505417', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('584', '10', '1694505420', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('585', '10', '1694505420', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('586', '10', '1694505420', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('587', '10', '1694505420', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('588', '10', '1694505421', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('589', '10', '1694505429', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('590', '10', '1694505431', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('591', '10', '1694505436', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('592', '10', '1694505440', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('593', '10', '1694505513', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('594', '10', '1694505514', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('595', '10', '1694505515', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('596', '10', '1694505516', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('597', '10', '1694505519', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('598', '10', '1694505519', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('599', '10', '1694505519', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('600', '10', '1694505519', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('601', '10', '1694505520', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('602', '10', '1694505524', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('603', '10', '1694505527', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('604', '10', '1694505528', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('605', '10', '1694505543', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('606', '10', '1694505544', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('607', '10', '1694505549', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('608', '10', '1694505550', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('609', '10', '1694505553', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('610', '10', '1694505558', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('611', '10', '1694505562', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('612', '10', '1694505572', '127.0.0.1', '/manage/menu/saveedit');
INSERT INTO `operation_log` VALUES ('613', '10', '1694505572', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('614', '10', '1694505642', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('615', '10', '1694505643', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('616', '10', '1694505646', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('617', '10', '1694505649', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('618', '10', '1694505665', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('619', '10', '1694505665', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('620', '10', '1694505666', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('621', '10', '1694505666', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('622', '10', '1694505666', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('623', '10', '1694505667', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('624', '10', '1694505687', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('625', '10', '1694505691', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('626', '10', '1694505692', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('627', '10', '1694836289', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('628', '10', '1694836289', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('629', '10', '1694836291', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('630', '10', '1694836291', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('631', '10', '1694836291', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('632', '10', '1694836297', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('633', '10', '1694836298', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('634', '10', '1694836313', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('635', '10', '1694836316', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('636', '10', '1694836317', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('637', '10', '1694836318', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('638', '10', '1694836319', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('639', '10', '1694836320', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('640', '10', '1694836551', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('641', '10', '1694836552', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('642', '10', '1694836554', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('643', '10', '1694836601', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('644', '10', '1694836610', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('645', '10', '1694837033', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('646', '10', '1694837033', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('647', '10', '1694837034', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('648', '10', '1694837035', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('649', '10', '1694837035', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('650', '10', '1694837037', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('651', '10', '1694837054', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('652', '10', '1694839327', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('653', '10', '1694839330', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('654', '10', '1694839330', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('655', '10', '1694839331', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('656', '10', '1694839331', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('657', '10', '1694839331', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('658', '10', '1694839335', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('659', '10', '1694839438', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('660', '10', '1694839660', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('661', '10', '1694839660', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('662', '10', '1694839663', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('663', '10', '1694839663', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('664', '10', '1694839663', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('665', '10', '1694839669', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('666', '10', '1694839669', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('667', '10', '1694839674', '127.0.0.1', '/manage/user/initadd');
INSERT INTO `operation_log` VALUES ('668', '10', '1694839680', '127.0.0.1', '/manage/user/initedit');
INSERT INTO `operation_log` VALUES ('669', '10', '1694839688', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('670', '10', '1694839695', '127.0.0.1', '/manage/department/initadd');
INSERT INTO `operation_log` VALUES ('671', '10', '1694839697', '127.0.0.1', '/manage/department/initedit');
INSERT INTO `operation_log` VALUES ('672', '10', '1694839713', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('673', '10', '1694839775', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('674', '10', '1694839775', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('675', '10', '1694839776', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('676', '10', '1694839776', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('677', '10', '1694839776', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('678', '10', '1694839791', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('679', '10', '1694839840', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('680', '10', '1694839840', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('681', '10', '1694839841', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('682', '10', '1694839841', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('683', '10', '1694839841', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('684', '10', '1694839861', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('685', '10', '1694839861', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('686', '10', '1694839865', '127.0.0.1', '/manage/user/initadd');
INSERT INTO `operation_log` VALUES ('687', '10', '1694839868', '127.0.0.1', '/manage/user/initedit');
INSERT INTO `operation_log` VALUES ('688', '10', '1694839877', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('689', '10', '1694839884', '127.0.0.1', '/manage/department/initadd');
INSERT INTO `operation_log` VALUES ('690', '10', '1694839887', '127.0.0.1', '/manage/department/initedit');
INSERT INTO `operation_log` VALUES ('691', '10', '1694839891', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('692', '10', '1694839899', '127.0.0.1', '/manage/role/initadd');
INSERT INTO `operation_log` VALUES ('693', '10', '1694839908', '127.0.0.1', '/manage/role/initedit');
INSERT INTO `operation_log` VALUES ('694', '10', '1694839921', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('695', '10', '1694839933', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('696', '10', '1694839944', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('697', '10', '1694839959', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('698', '10', '1694839960', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('699', '10', '1694839966', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('700', '10', '1694839969', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('701', '10', '1694840059', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('702', '10', '1694840065', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('703', '10', '1694840067', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('704', '10', '1694840073', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('705', '10', '1694840228', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('706', '10', '1694840302', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('707', '10', '1694840302', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('708', '10', '1694840303', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('709', '10', '1694840303', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('710', '10', '1694840303', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('711', '10', '1694840334', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('712', '10', '1694840377', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('713', '10', '1694840377', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('714', '10', '1694840378', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('715', '10', '1694840378', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('716', '10', '1694840378', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('717', '10', '1694840388', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('718', '10', '1694840388', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('719', '10', '1694840388', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('720', '10', '1694840390', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('721', '10', '1694840391', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('722', '10', '1694840392', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('723', '10', '1694840393', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('724', '10', '1694840396', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('725', '10', '1694840409', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('726', '10', '1694840409', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('727', '10', '1694840418', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('728', '10', '1694840453', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('729', '10', '1694840453', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('730', '10', '1694840454', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('731', '10', '1694840454', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('732', '10', '1694840454', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('733', '10', '1694840457', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('734', '10', '1694840458', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('735', '10', '1694840462', '127.0.0.1', '/manage/user/initadd');
INSERT INTO `operation_log` VALUES ('736', '10', '1694840464', '127.0.0.1', '/manage/user/initedit');
INSERT INTO `operation_log` VALUES ('737', '10', '1694840473', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('738', '10', '1694840481', '127.0.0.1', '/manage/department/initadd');
INSERT INTO `operation_log` VALUES ('739', '10', '1694840487', '127.0.0.1', '/manage/department/initedit');
INSERT INTO `operation_log` VALUES ('740', '10', '1694840490', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('741', '10', '1694840493', '127.0.0.1', '/manage/role/initadd');
INSERT INTO `operation_log` VALUES ('742', '10', '1694840500', '127.0.0.1', '/manage/role/initedit');
INSERT INTO `operation_log` VALUES ('743', '10', '1694840506', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('744', '10', '1694840515', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('745', '10', '1694840533', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('746', '10', '1694840536', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('747', '10', '1694840552', '127.0.0.1', '/manage/dictionary/initedit');
INSERT INTO `operation_log` VALUES ('748', '10', '1694840560', '127.0.0.1', '/manage/login/logout');
INSERT INTO `operation_log` VALUES ('749', '10', '1694840594', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('750', '10', '1694840594', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('751', '10', '1694840595', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('752', '10', '1694840595', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('753', '10', '1694840595', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('754', '10', '1694840598', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('755', '10', '1694840598', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('756', '10', '1694840600', '127.0.0.1', '/manage/user/initadd');
INSERT INTO `operation_log` VALUES ('757', '10', '1694840606', '127.0.0.1', '/manage/user/initedit');
INSERT INTO `operation_log` VALUES ('758', '10', '1694840614', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('759', '10', '1694840621', '127.0.0.1', '/manage/department/initadd');
INSERT INTO `operation_log` VALUES ('760', '10', '1694840625', '127.0.0.1', '/manage/department/initedit');
INSERT INTO `operation_log` VALUES ('761', '10', '1694840629', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('762', '10', '1694840634', '127.0.0.1', '/manage/role/initadd');
INSERT INTO `operation_log` VALUES ('763', '10', '1694840644', '127.0.0.1', '/manage/role/initedit');
INSERT INTO `operation_log` VALUES ('764', '10', '1694840646', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('765', '10', '1694840662', '127.0.0.1', '/manage/menu/initadd');
INSERT INTO `operation_log` VALUES ('766', '10', '1694840672', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('767', '10', '1694840679', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('768', '10', '1694840704', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('769', '10', '1694840708', '127.0.0.1', '/manage/operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('770', '10', '1694840767', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('771', '10', '1694840773', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('772', '10', '1694840775', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('773', '10', '1694840869', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('774', '10', '1694840870', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('775', '10', '1694840871', '127.0.0.1', '/manage/message/readall');
INSERT INTO `operation_log` VALUES ('776', '10', '1694851549', '127.0.0.1', '/manage/main/getpermissions');
INSERT INTO `operation_log` VALUES ('777', '10', '1694851550', '127.0.0.1', '/manage/main/getroutes');
INSERT INTO `operation_log` VALUES ('778', '10', '1694851552', '127.0.0.1', '/manage/main/getmenus');
INSERT INTO `operation_log` VALUES ('779', '10', '1694851552', '127.0.0.1', '/manage/message/getnoreads');
INSERT INTO `operation_log` VALUES ('780', '10', '1694851552', '127.0.0.1', '/manage/main/getwatermark');
INSERT INTO `operation_log` VALUES ('781', '10', '1694851555', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('782', '10', '1694851558', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('783', '10', '1694851561', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('784', '10', '1694851603', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('785', '10', '1694851605', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('786', '10', '1694851794', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('787', '10', '1694851799', '127.0.0.1', '/manage/user/initindex');
INSERT INTO `operation_log` VALUES ('788', '10', '1694851799', '127.0.0.1', '/manage/user/getindexusers');
INSERT INTO `operation_log` VALUES ('789', '10', '1694851835', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('790', '10', '1694851837', '127.0.0.1', '/manage/role/getindexroles');
INSERT INTO `operation_log` VALUES ('791', '10', '1694851838', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('792', '10', '1694851840', '127.0.0.1', '/manage/dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('793', '10', '1694852242', '127.0.0.1', '/manage/loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('794', '10', '1694852934', '127.0.0.1', '/manage/my/info');
INSERT INTO `operation_log` VALUES ('795', '10', '1694853014', '127.0.0.1', '/manage/menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('796', '10', '1694853022', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('797', '10', '1694853074', '127.0.0.1', '/manage/menu/initedit');
INSERT INTO `operation_log` VALUES ('798', '10', '1694853331', '127.0.0.1', '/manage/department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('799', '10', '1694853440', '127.0.0.1', '/manage/login/logout');

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
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8 COMMENT='角色权限关联';

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('86', '4', '3');
INSERT INTO `role_menu` VALUES ('87', '4', '4');
INSERT INTO `role_menu` VALUES ('88', '4', '6');
INSERT INTO `role_menu` VALUES ('89', '4', '24');
INSERT INTO `role_menu` VALUES ('90', '4', '25');
INSERT INTO `role_menu` VALUES ('91', '4', '1');
INSERT INTO `role_menu` VALUES ('92', '4', '2');
INSERT INTO `role_menu` VALUES ('119', '1', '23');
INSERT INTO `role_menu` VALUES ('120', '1', '1');
INSERT INTO `role_menu` VALUES ('121', '1', '2');
INSERT INTO `role_menu` VALUES ('122', '1', '3');
INSERT INTO `role_menu` VALUES ('123', '1', '4');
INSERT INTO `role_menu` VALUES ('124', '1', '6');
INSERT INTO `role_menu` VALUES ('125', '1', '7');
INSERT INTO `role_menu` VALUES ('126', '1', '26');
INSERT INTO `role_menu` VALUES ('127', '1', '5');
INSERT INTO `role_menu` VALUES ('128', '1', '10');
INSERT INTO `role_menu` VALUES ('129', '1', '9');
INSERT INTO `role_menu` VALUES ('130', '1', '8');
INSERT INTO `role_menu` VALUES ('131', '1', '11');
INSERT INTO `role_menu` VALUES ('132', '1', '12');
INSERT INTO `role_menu` VALUES ('133', '1', '13');
INSERT INTO `role_menu` VALUES ('134', '1', '14');
INSERT INTO `role_menu` VALUES ('135', '1', '15');
INSERT INTO `role_menu` VALUES ('136', '1', '16');
INSERT INTO `role_menu` VALUES ('137', '1', '17');
INSERT INTO `role_menu` VALUES ('138', '1', '18');
INSERT INTO `role_menu` VALUES ('139', '1', '19');
INSERT INTO `role_menu` VALUES ('140', '1', '20');
INSERT INTO `role_menu` VALUES ('141', '1', '21');
INSERT INTO `role_menu` VALUES ('142', '1', '22');
INSERT INTO `role_menu` VALUES ('143', '1', '27');
INSERT INTO `role_menu` VALUES ('144', '1', '28');
INSERT INTO `role_menu` VALUES ('145', '1', '24');
INSERT INTO `role_menu` VALUES ('146', '1', '25');

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `token` text NOT NULL COMMENT 'token',
  `expires_in` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有效期',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  PRIMARY KEY (`id`),
  KEY `token` (`token`(128)) USING BTREE,
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES ('16', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsIm5hbWUiOiJcdTU1MTBcdTc0MzRcdTY4ODUiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC44NzU3NzEwMCAxNjg1OTU4NjAwIn0.66olJAHZ7kIl_o7YVwlgVO5axTdyTlQl55SQwDqJIEQ', '1685965811', '11');

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
INSERT INTO `user` VALUES ('10', '1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '管理员', '15122222222', '', '1684989244', '1687667332', '0', '');
INSERT INTO `user` VALUES ('11', '8', '1', 'user1', 'e10adc3949ba59abbe56e057f20f883e', '用户1', '15111111111', '', '1684992552', '1687667324', '0', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('45', '11', '4');
INSERT INTO `user_role` VALUES ('46', '10', '1');
INSERT INTO `user_role` VALUES ('47', '10', '4');
