/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : localhost:3306
Source Database       : thinkphpvuemanagetemplate

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2024-01-27 12:36:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `version` varchar(64) NOT NULL DEFAULT '' COMMENT '版本号',
  PRIMARY KEY (`id`),
  KEY `token` (`version`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('1', '1.0.0');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `department_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级部门id',
  `type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '类型id',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '部门名称',
  `sort` int(255) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='部门';

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '0', '1', '部门1', '1');
INSERT INTO `department` VALUES ('2', '1', '2', '部门1-1', '1');
INSERT INTO `department` VALUES ('3', '0', '1', '部门2', '2');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='字典';

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('1', 'menu_type', '1', '目录', '1');
INSERT INTO `dictionary` VALUES ('2', 'menu_type', '2', '页面', '2');
INSERT INTO `dictionary` VALUES ('3', 'menu_type', '3', '按钮', '3');
INSERT INTO `dictionary` VALUES ('4', 'menu_layout', 'main', '主布局', '1');
INSERT INTO `dictionary` VALUES ('5', 'menu_layout', 'blank', '空白布局', '2');
INSERT INTO `dictionary` VALUES ('6', 'menu_type', '4', '外部链接', '4');
INSERT INTO `dictionary` VALUES ('7', 'department_type', '1', '类型1', '1');
INSERT INTO `dictionary` VALUES ('8', 'department_type', '2', '类型2', '2');
INSERT INTO `dictionary` VALUES ('9', 'department_type', '3', '类型3', '3');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

-- ----------------------------
-- Records of login_log
-- ----------------------------
INSERT INTO `login_log` VALUES ('1', '1', '1704425432', '127.0.0.1');
INSERT INTO `login_log` VALUES ('2', '1', '1704680564', '127.0.0.1');
INSERT INTO `login_log` VALUES ('3', '1', '1705907520', '127.0.0.1');
INSERT INTO `login_log` VALUES ('4', '1', '1705907582', '127.0.0.1');
INSERT INTO `login_log` VALUES ('5', '1', '1705907599', '127.0.0.1');
INSERT INTO `login_log` VALUES ('6', '1', '1706066872', '127.0.0.1');
INSERT INTO `login_log` VALUES ('7', '1', '1706066945', '127.0.0.1');
INSERT INTO `login_log` VALUES ('8', '1', '1706067117', '127.0.0.1');
INSERT INTO `login_log` VALUES ('9', '1', '1706234571', '127.0.0.1');
INSERT INTO `login_log` VALUES ('10', '1', '1706234582', '127.0.0.1');
INSERT INTO `login_log` VALUES ('11', '1', '1706239367', '127.0.0.1');
INSERT INTO `login_log` VALUES ('12', '1', '1706329395', '127.0.0.1');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `menu_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级菜单id',
  `type_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '菜单类型id',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `key` varchar(128) DEFAULT '' COMMENT '菜单key',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路由路径',
  `component` varchar(255) NOT NULL DEFAULT '' COMMENT '组件路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '链接网址',
  `icon` varchar(32) NOT NULL DEFAULT '' COMMENT '菜单图标',
  `api` varchar(1024) NOT NULL DEFAULT '' COMMENT '接口地址',
  `layout` varchar(32) NOT NULL DEFAULT '' COMMENT '页面布局',
  `keep_alive` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '保活',
  `show` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '菜单显示',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `remark` varchar(32) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COMMENT='菜单';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '0', '1', '系统管理', 'system', '', '', '', 'Setting', '', '', '2', '1', '99', '');
INSERT INTO `menu` VALUES ('2', '1', '2', '用户管理', 'system_user', '/system/user', 'system/user/Index.vue', '', 'User', 'manage/system.User/initIndex\nmanage/system.User/getIndexUsers', 'main', '2', '1', '3', '');
INSERT INTO `menu` VALUES ('3', '2', '3', '添加', 'system_user_add', '', '', '', '', 'manage/system.User/initAdd\nmanage/system.User/saveAdd', '', '2', '1', '1', '');
INSERT INTO `menu` VALUES ('4', '2', '3', '修改', 'system_user_edit', '', '', '', '', 'manage/system.User/initEdit\nmanage/system.User/saveEdit', '', '2', '1', '2', '');
INSERT INTO `menu` VALUES ('5', '1', '2', '部门管理', 'system_department', '/system/department', 'system/department/Index.vue', '', 'Memo', 'manage/system.Department/getIndexDepartments', 'main', '2', '1', '5', '');
INSERT INTO `menu` VALUES ('6', '2', '3', '修改状态', 'system_user_edit_status', '', '', '', '', 'manage/system.User/editStatus', '', '2', '1', '3', '');
INSERT INTO `menu` VALUES ('7', '2', '3', '修改密码', 'system_user_edit_password', '', '', '', '', 'manage/system.User/editPassword', '', '2', '1', '5', '');
INSERT INTO `menu` VALUES ('8', '5', '3', '添加', 'system_department_add', '', '', '', '', 'manage/system.Department/initAdd\nmanage/system.Department/saveAdd', '', '2', '1', '1', '');
INSERT INTO `menu` VALUES ('9', '5', '3', '修改', 'system_department_edit', '', '', '', '', 'manage/system.Department/initEdit\nmanage/system.Department/saveEdit', '', '2', '1', '1', '');
INSERT INTO `menu` VALUES ('10', '5', '3', '删除', 'system_department_delete', '', '', '', '', 'manage/system.Department/delete', '', '2', '1', '3', '');
INSERT INTO `menu` VALUES ('11', '1', '2', '角色管理', 'system_role', '/system/role', 'system/role/Index.vue', '', 'ChatSquare', 'manage/system.Role/getIndexRoles', 'main', '2', '1', '7', '');
INSERT INTO `menu` VALUES ('12', '11', '3', '添加', 'system_role_add', '', '', '', '', 'manage/system.Role/initAdd\nmanage/system.Role/saveAdd', '', '2', '1', '1', '');
INSERT INTO `menu` VALUES ('13', '11', '3', '修改', 'system_role_edit', '', '', '', '', 'manage/system.Role/initEdit\nmanage/system.Role/saveEdit', '', '2', '1', '2', '');
INSERT INTO `menu` VALUES ('14', '11', '3', '删除', 'system_role_delete', '', '', '', '', 'manage/system.Role/delete', '', '2', '1', '3', '');
INSERT INTO `menu` VALUES ('15', '1', '2', '菜单管理', 'system_menu', '/system/menu', 'system/menu/Index.vue', '', 'Reading', 'manage/system.Menu/getIndexMenus', 'main', '2', '1', '9', '');
INSERT INTO `menu` VALUES ('16', '15', '3', '添加', 'system_menu_add', '', '', '', '', 'manage/system.Menu/initAdd\nmanage/system.Menu/saveAdd', '', '2', '1', '1', '');
INSERT INTO `menu` VALUES ('17', '15', '3', '修改', 'menu_edit', '', '', '', '', 'manage/system.Menu/initEdit\nmanage/system.Menu/saveEdit', '', '2', '1', '2', '');
INSERT INTO `menu` VALUES ('18', '15', '3', '删除', 'system_menu_delete', '', '', '', '', 'manage/system.Menu/delete', '', '2', '1', '3', '');
INSERT INTO `menu` VALUES ('19', '1', '2', '字典管理', 'system_dictionary', '/system/dictionary', 'system/dictionary/Index.vue', '', 'Document', 'manage/system.Dictionary/getIndexDictionarys', 'main', '2', '1', '11', '');
INSERT INTO `menu` VALUES ('20', '19', '3', '添加', 'system_dictionary_add', '', '', '', '', 'manage/system.Dictionary/saveAdd', '', '2', '1', '1', '');
INSERT INTO `menu` VALUES ('21', '19', '3', '修改', 'system_dictionary_edit', '', '', '', '', 'manage/system.Dictionary/initEdit\nmanage/system.Dictionary/saveEdit', '', '2', '1', '2', '');
INSERT INTO `menu` VALUES ('22', '19', '3', '删除', 'system_dictionary_delete', '', '', '', '', 'manage/system.Dictionary/delete', '', '2', '1', '3', '');
INSERT INTO `menu` VALUES ('23', '0', '2', '首页', 'index', '/index', 'Index.vue', '', 'House', '', 'main', '2', '1', '0', '');
INSERT INTO `menu` VALUES ('26', '2', '3', '踢下线', 'system_user_offline', '', '', '', '', 'manage/system.User/offLine', '', '2', '1', '5', '');
INSERT INTO `menu` VALUES ('27', '1', '2', '登录日志', 'system_login_log', '/system/login-log', 'system/login_log/Index.vue', '', 'MapLocation', 'manage/system.LoginLog/getIndexLoginLogs', 'main', '2', '1', '13', '');
INSERT INTO `menu` VALUES ('28', '1', '2', '操作日志', 'system_operation_log', '/system/operation-log', 'system/operation_log/Index.vue', '', 'Mouse', 'manage/system.OperationLog/getIndexOperationLogs', 'main', '2', '1', '15', '');
INSERT INTO `menu` VALUES ('29', '2', '2', '用户详情', 'system_user_detail', '/system/user/:id', 'system/user/Detail.vue', '', '', 'manage/system.user/detail', 'blank', '2', '2', '3', '');
INSERT INTO `menu` VALUES ('30', '0', '4', '外部链接', 'baidu', '', '', 'https://www.baidu.com', 'ChatSquare', '', '', '2', '1', '3', '新窗口');
INSERT INTO `menu` VALUES ('31', '1', '2', '系统设置', 'system_config', '/system/config', 'system/config/Index.vue', '', 'Cpu', 'manage/system.Config/init\nmanage/system.Config/save', 'main', '2', '1', '1', '');
INSERT INTO `menu` VALUES ('32', '0', '1', '统计分析', 'statistic', '', '', '', 'PieChart', '', '', '2', '1', '2', '');
INSERT INTO `menu` VALUES ('33', '32', '2', '订单趋势统计', 'statistic_order_trend', '/statistic/order/trend', 'statistic/order/Trend.vue', '', 'Share', 'manage/statistic.order.Trend/init\nmanage/statistic.order.Trend/exportExcel', 'main', '2', '1', '1', '');
INSERT INTO `menu` VALUES ('34', '32', '2', '订单部门统计', 'statistic_order_department', '/statistic/order/department', 'statistic/order/Department.vue', '', 'OfficeBuilding', 'manage/statistic.order.Department/init', 'main', '2', '1', '3', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8mb4 COMMENT='消息';

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
INSERT INTO `message` VALUES ('181', '10', '消息标题1695436293', '/login-log', '1695436293', '1');
INSERT INTO `message` VALUES ('182', '11', '消息标题1695436293', '/login-log', '1695436293', '0');
INSERT INTO `message` VALUES ('183', '10', '消息标题1695436656', '/login-log', '1695436656', '1');
INSERT INTO `message` VALUES ('184', '11', '消息标题1695436656', '/login-log', '1695436656', '0');
INSERT INTO `message` VALUES ('185', '10', '消息标题1695436661', '/login-log', '1695436661', '1');
INSERT INTO `message` VALUES ('186', '11', '消息标题1695436661', '/login-log', '1695436661', '0');
INSERT INTO `message` VALUES ('187', '10', '消息标题1695436662', '/login-log', '1695436662', '1');
INSERT INTO `message` VALUES ('188', '11', '消息标题1695436662', '/login-log', '1695436663', '0');
INSERT INTO `message` VALUES ('189', '10', '消息标题1695436663', '/login-log', '1695436664', '1');
INSERT INTO `message` VALUES ('190', '11', '消息标题1695436663', '/login-log', '1695436664', '0');
INSERT INTO `message` VALUES ('191', '10', '消息标题1695436665', '/login-log', '1695436665', '1');
INSERT INTO `message` VALUES ('192', '11', '消息标题1695436665', '/login-log', '1695436665', '0');
INSERT INTO `message` VALUES ('193', '10', '消息标题1695436666', '/login-log', '1695436666', '1');
INSERT INTO `message` VALUES ('194', '11', '消息标题1695436666', '/login-log', '1695436666', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

-- ----------------------------
-- Records of operation_log
-- ----------------------------
INSERT INTO `operation_log` VALUES ('1', '1', '1704425442', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('2', '1', '1704425444', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('3', '1', '1704425445', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('4', '1', '1704425446', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('5', '1', '1704425448', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('6', '1', '1704425450', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('7', '1', '1704425453', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('8', '1', '1704425455', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('9', '1', '1704425458', '127.0.0.1', '/manage/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('10', '1', '1704680601', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('11', '1', '1704680607', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('12', '1', '1704680607', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('13', '1', '1704680611', '127.0.0.1', '/manage/system.user/initadd');
INSERT INTO `operation_log` VALUES ('14', '1', '1704680614', '127.0.0.1', '/manage/system.department/getindexdepartments');
INSERT INTO `operation_log` VALUES ('15', '1', '1704680617', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('16', '1', '1704680619', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('17', '1', '1704680621', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('18', '1', '1704680628', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('19', '1', '1704680632', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('20', '1', '1704680665', '127.0.0.1', '/manage/system.loginlog/getindexloginlogs');
INSERT INTO `operation_log` VALUES ('21', '1', '1704680666', '127.0.0.1', '/manage/system.operationlog/getindexoperationlogs');
INSERT INTO `operation_log` VALUES ('22', '1', '1704680668', '127.0.0.1', '/manage/system.dictionary/getindexdictionarys');
INSERT INTO `operation_log` VALUES ('23', '1', '1704680854', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('24', '1', '1704680854', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('25', '1', '1705907601', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('26', '1', '1706066876', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('27', '1', '1706066894', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('28', '1', '1706066921', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('29', '1', '1706066948', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('30', '1', '1706067119', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('31', '1', '1706234585', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('32', '1', '1706234591', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('33', '1', '1706234594', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('34', '1', '1706234606', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('35', '1', '1706234610', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('36', '1', '1706234670', '127.0.0.1', '/manage/system.menu/saveadd');
INSERT INTO `operation_log` VALUES ('37', '1', '1706234671', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('38', '1', '1706234674', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('39', '1', '1706234678', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('40', '1', '1706234729', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('41', '1', '1706234872', '127.0.0.1', '/manage/system.menu/saveadd');
INSERT INTO `operation_log` VALUES ('42', '1', '1706234872', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('43', '1', '1706234881', '127.0.0.1', '/manage/system.menu/initadd');
INSERT INTO `operation_log` VALUES ('44', '1', '1706234995', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('45', '1', '1706234998', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('46', '1', '1706235013', '127.0.0.1', '/manage/system.menu/saveadd');
INSERT INTO `operation_log` VALUES ('47', '1', '1706235013', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('48', '1', '1706235028', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('49', '1', '1706235028', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('50', '1', '1706235036', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('51', '1', '1706235044', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('52', '1', '1706235046', '127.0.0.1', '/manage/system.role/initedit');
INSERT INTO `operation_log` VALUES ('53', '1', '1706235049', '127.0.0.1', '/manage/system.role/saveedit');
INSERT INTO `operation_log` VALUES ('54', '1', '1706235049', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('55', '1', '1706235052', '127.0.0.1', '/manage/system.role/getindexroles');
INSERT INTO `operation_log` VALUES ('56', '1', '1706235064', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('57', '1', '1706235067', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('58', '1', '1706235080', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('59', '1', '1706235081', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('60', '1', '1706235084', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('61', '1', '1706235143', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('62', '1', '1706235154', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('63', '1', '1706235172', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('64', '1', '1706235321', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('65', '1', '1706235330', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('66', '1', '1706235330', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('67', '1', '1706235352', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('68', '1', '1706235373', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('69', '1', '1706235376', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('70', '1', '1706235388', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('71', '1', '1706235389', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('72', '1', '1706235636', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('73', '1', '1706235747', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('74', '1', '1706235754', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('75', '1', '1706235754', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('76', '1', '1706235772', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('77', '1', '1706235788', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('78', '1', '1706235789', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('79', '1', '1706235793', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('80', '1', '1706235856', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('81', '1', '1706235858', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('82', '1', '1706235881', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('83', '1', '1706235955', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('84', '1', '1706236384', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('85', '1', '1706236386', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('86', '1', '1706236391', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('87', '1', '1706236400', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('88', '1', '1706236400', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('89', '1', '1706236405', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('90', '1', '1706236413', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('91', '1', '1706236413', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('92', '1', '1706236416', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('93', '1', '1706236434', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('94', '1', '1706236442', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('95', '1', '1706236442', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('96', '1', '1706236446', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('97', '1', '1706236483', '127.0.0.1', '/manage/statistic.trend/init');
INSERT INTO `operation_log` VALUES ('98', '1', '1706236509', '127.0.0.1', '/manage/statistic.department/init');
INSERT INTO `operation_log` VALUES ('99', '1', '1706236542', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('100', '1', '1706236577', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('101', '1', '1706236612', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('102', '1', '1706236612', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('103', '1', '1706236616', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('104', '1', '1706236636', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('105', '1', '1706236637', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('106', '1', '1706236639', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('107', '1', '1706236660', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('108', '1', '1706236664', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('109', '1', '1706236676', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('110', '1', '1706236715', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('111', '1', '1706236724', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('112', '1', '1706236975', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('113', '1', '1706237009', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('114', '1', '1706237014', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('115', '1', '1706237015', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('116', '1', '1706237018', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('117', '1', '1706237039', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('118', '1', '1706237044', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('119', '1', '1706237058', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('120', '1', '1706237059', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('121', '1', '1706237080', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('122', '1', '1706237081', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('123', '1', '1706237086', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('124', '1', '1706237103', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('125', '1', '1706237122', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('126', '1', '1706237236', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('127', '1', '1706237497', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('128', '1', '1706237509', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('129', '1', '1706237517', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('130', '1', '1706237520', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('131', '1', '1706237522', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('132', '1', '1706237524', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('133', '1', '1706237888', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('134', '1', '1706237903', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('135', '1', '1706237983', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('136', '1', '1706237988', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('137', '1', '1706238020', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('138', '1', '1706238020', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('139', '1', '1706238519', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('140', '1', '1706238520', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('141', '1', '1706238779', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('142', '1', '1706238829', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('143', '1', '1706238864', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('144', '1', '1706238912', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('145', '1', '1706238950', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('146', '1', '1706238954', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('147', '1', '1706238978', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('148', '1', '1706239026', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('149', '1', '1706239038', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('150', '1', '1706239057', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('151', '1', '1706239097', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('152', '1', '1706239103', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('153', '1', '1706239112', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('154', '1', '1706239120', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('155', '1', '1706239165', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('156', '1', '1706239173', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('157', '1', '1706239173', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('158', '1', '1706239210', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('159', '1', '1706239211', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('160', '1', '1706239221', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('161', '1', '1706239222', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('162', '1', '1706239235', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('163', '1', '1706239235', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('164', '1', '1706239278', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('165', '1', '1706239279', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('166', '1', '1706239280', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('167', '1', '1706239282', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('168', '1', '1706239285', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('169', '1', '1706239286', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('170', '1', '1706239296', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('171', '1', '1706239296', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('172', '1', '1706239369', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('173', '1', '1706239382', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('174', '1', '1706239412', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('175', '1', '1706239420', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('176', '1', '1706239451', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('177', '1', '1706239467', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('178', '1', '1706239511', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('179', '1', '1706239513', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('180', '1', '1706239515', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('181', '1', '1706239520', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('182', '1', '1706239527', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('183', '1', '1706239570', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('184', '1', '1706239573', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('185', '1', '1706239578', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('186', '1', '1706239593', '127.0.0.1', '/manage/system.menu/saveedit');
INSERT INTO `operation_log` VALUES ('187', '1', '1706239594', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('188', '1', '1706239598', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('189', '1', '1706239656', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('190', '1', '1706240621', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('191', '1', '1706240626', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('192', '1', '1706240663', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('193', '1', '1706240861', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('194', '1', '1706240971', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('195', '1', '1706241060', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('196', '1', '1706241096', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('197', '1', '1706241197', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('198', '1', '1706241200', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('199', '1', '1706241201', '127.0.0.1', '/manage/statistic.order.trend/exportexcel');
INSERT INTO `operation_log` VALUES ('200', '1', '1706241298', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('201', '1', '1706241303', '127.0.0.1', '/manage/statistic.order.department/init');
INSERT INTO `operation_log` VALUES ('202', '1', '1706241306', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('203', '1', '1706241311', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('204', '1', '1706241347', '127.0.0.1', '/manage/system.config/init');
INSERT INTO `operation_log` VALUES ('205', '1', '1706241348', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('206', '1', '1706241363', '127.0.0.1', '/manage/system.user/initindex');
INSERT INTO `operation_log` VALUES ('207', '1', '1706241364', '127.0.0.1', '/manage/system.user/getindexusers');
INSERT INTO `operation_log` VALUES ('208', '1', '1706329634', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('209', '1', '1706329767', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('210', '1', '1706329883', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('211', '1', '1706329925', '127.0.0.1', '/manage/statistic.order.trend/init');
INSERT INTO `operation_log` VALUES ('212', '1', '1706330019', '127.0.0.1', '/manage/system.menu/getindexmenus');
INSERT INTO `operation_log` VALUES ('213', '1', '1706330034', '127.0.0.1', '/manage/system.menu/initedit');
INSERT INTO `operation_log` VALUES ('214', '1', '1706330046', '127.0.0.1', '/manage/system.menu/initedit');

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
INSERT INTO `role` VALUES ('2', '普通角色');

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
) ENGINE=InnoDB AUTO_INCREMENT=300 DEFAULT CHARSET=utf8 COMMENT='角色权限关联';

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('204', '2', '3');
INSERT INTO `role_menu` VALUES ('205', '2', '4');
INSERT INTO `role_menu` VALUES ('206', '2', '6');
INSERT INTO `role_menu` VALUES ('207', '2', '1');
INSERT INTO `role_menu` VALUES ('208', '2', '2');
INSERT INTO `role_menu` VALUES ('264', '1', '23');
INSERT INTO `role_menu` VALUES ('265', '1', '30');
INSERT INTO `role_menu` VALUES ('266', '1', '1');
INSERT INTO `role_menu` VALUES ('267', '1', '31');
INSERT INTO `role_menu` VALUES ('268', '1', '2');
INSERT INTO `role_menu` VALUES ('269', '1', '3');
INSERT INTO `role_menu` VALUES ('270', '1', '4');
INSERT INTO `role_menu` VALUES ('271', '1', '6');
INSERT INTO `role_menu` VALUES ('272', '1', '29');
INSERT INTO `role_menu` VALUES ('273', '1', '26');
INSERT INTO `role_menu` VALUES ('274', '1', '7');
INSERT INTO `role_menu` VALUES ('275', '1', '5');
INSERT INTO `role_menu` VALUES ('276', '1', '9');
INSERT INTO `role_menu` VALUES ('277', '1', '8');
INSERT INTO `role_menu` VALUES ('278', '1', '10');
INSERT INTO `role_menu` VALUES ('279', '1', '11');
INSERT INTO `role_menu` VALUES ('280', '1', '12');
INSERT INTO `role_menu` VALUES ('281', '1', '13');
INSERT INTO `role_menu` VALUES ('282', '1', '14');
INSERT INTO `role_menu` VALUES ('283', '1', '15');
INSERT INTO `role_menu` VALUES ('284', '1', '16');
INSERT INTO `role_menu` VALUES ('285', '1', '17');
INSERT INTO `role_menu` VALUES ('286', '1', '18');
INSERT INTO `role_menu` VALUES ('287', '1', '19');
INSERT INTO `role_menu` VALUES ('288', '1', '20');
INSERT INTO `role_menu` VALUES ('289', '1', '21');
INSERT INTO `role_menu` VALUES ('290', '1', '22');
INSERT INTO `role_menu` VALUES ('291', '1', '27');
INSERT INTO `role_menu` VALUES ('292', '1', '28');
INSERT INTO `role_menu` VALUES ('297', '1', '32');
INSERT INTO `role_menu` VALUES ('298', '1', '33');
INSERT INTO `role_menu` VALUES ('299', '1', '34');

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
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES ('34', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC42MDA0MDMwMCAxNzAzMjE1OTU0In0.hCtCWoJvF5UJ_OX2yYvozYIM-tUGYyLbbWHcDkm4_R8', '1703226008', '10');
INSERT INTO `token` VALUES ('35', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43NzY1MjMwMCAxNzAzMjI2NzQ0In0.o1NW6DuKKk6PRjnpGlGJrjmofBDQQdedmHLOGyHZ4vI', '1703235581', '10');
INSERT INTO `token` VALUES ('36', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43OTgzNzYwMCAxNzAzNDg1MjQzIn0.owdRQGm9nQQIH3LF4HCFes1GuoxjMhZ090ym3mXTV9s', '1703496265', '10');
INSERT INTO `token` VALUES ('37', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4yMzAxOTgwMCAxNzAzNTYxMTE5In0.yMAPpSgE43MQ2VNMJm4qM3560E19d5CJvqC-SFb45Q8', '1703568404', '10');
INSERT INTO `token` VALUES ('38', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC40Mjc1NTAwMCAxNzAzNTcwMzkxIn0.mwnHb0RhHhIWOQzt94-cpxuM5jliZ754_xOVA2e_xR0', '1703584727', '10');
INSERT INTO `token` VALUES ('39', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC44Mzg0NTYwMCAxNzAzNTc4MTExIn0.ZcYF9H3xXtI5V9TKq-8XOeSa76wBg_TM1GKnUt47HUA', '1703585312', '10');
INSERT INTO `token` VALUES ('40', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC41ODYyNDgwMCAxNzAzNTc4MTU4In0.fA36XuiF1BW8F5HGaPJS6CYpIRWQKohzACPwduBti7k', '1703585359', '10');
INSERT INTO `token` VALUES ('41', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4xNzM3NTYwMCAxNzAzNTc4MTk2In0.Y8aS9mz7wCq6gWEi-S5UcnmWw5hKWOIGrr_ewrDtsQI', '1703585396', '10');
INSERT INTO `token` VALUES ('42', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4xNzQ0MDMwMCAxNzAzNTc4MjA3In0.VjQ5HRcjKYo8gfzH6NoN9DneAE8cFLAPtTLzMaC-TBg', '1703593928', '10');
INSERT INTO `token` VALUES ('43', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC41OTg5NjEwMCAxNzAzNjM5MzA4In0.uHjXcyEhttgy0V9hDYUS1QykJarzgKSke3J7-nmg99o', '1703657085', '10');
INSERT INTO `token` VALUES ('44', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43NTk5MTcwMCAxNzAzNzI2NjU0In0.8Fy4Wiw_M13SgOUrIHlRtOEEg_zv4VbcnXy9x1MkRpg', '1703733855', '10');
INSERT INTO `token` VALUES ('45', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43MzI5NzYwMCAxNzAzNzI3MDg3In0.q7FPU2dFfb_0gnQtn0LsmEn5mEok7ga997gZEPM200U', '1703735267', '10');
INSERT INTO `token` VALUES ('46', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43NDQxNTgwMCAxNzA0NDE3NDQ1In0.AwVM6Ry1x22wCJMOcPYmSYUE_GdP7cDReXKau3jBI4Y', '1704424647', '10');
INSERT INTO `token` VALUES ('47', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC41NDAyNjUwMCAxNzA0NDE3NDY5In0.4lHwTZ41SoQeIE8_7h81YL9EwgiYjnKerwiONFkjL88', '1704453986', '10');
INSERT INTO `token` VALUES ('55', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjI5NDkyMjAwIDE3MDYwNjcxMTcifQ.C2gZSLUyV3I5m9oFPtkg1Vf3nbWIoAu6jPqyGbW2XoU', '1706095919', '1');
INSERT INTO `token` VALUES ('56', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY4NDY5NzAwIDE3MDYyMzQ1NzAifQ.-D-uefcu41R_vCqAi4Ck5BLh82ExqiNljwlvi24or-s', '1706263372', '1');
INSERT INTO `token` VALUES ('57', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjY0NDQ2NDAwIDE3MDYyMzQ1ODIifQ.ERz_RAm1Dd535JicSBaLcZv5cwG1asVr_BHhfdgPlQo', '1706268098', '1');
INSERT INTO `token` VALUES ('58', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjA0ODQxNzAwIDE3MDYyMzkzNjcifQ._xujttJMpW-ED6pVWpNfDSBx-m8u2tBPkxzjk4WXMWY', '1706270164', '1');
INSERT INTO `token` VALUES ('59', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwibmFtZSI6Ilx1NWYyMFx1NGUwOSIsImRlcGFydG1lbnRfaWQiOjEsInRpbWUiOiIwLjc3NDY0MDAwIDE3MDYzMjkzOTUifQ.JCoxiPg_0NE2IWAfrAJxbrt2IrY1Z-g5h2C63anqmzY', '1706358887', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='管理用户';

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '1', '1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '张三', '15122222222', '', '1684989244', '1687667332', '1706329395', '127.0.0.1');
INSERT INTO `user` VALUES ('2', '1', '1', 'user', 'e10adc3949ba59abbe56e057f20f883e', '李四', '15111111111', '', '1684992552', '1703148627', '0', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='用户角色';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('46', '1', '1');
INSERT INTO `user_role` VALUES ('47', '1', '2');
INSERT INTO `user_role` VALUES ('50', '2', '2');
