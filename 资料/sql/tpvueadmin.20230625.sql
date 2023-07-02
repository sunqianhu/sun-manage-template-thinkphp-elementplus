/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50529
Source Host           : 127.0.0.1:3306
Source Database       : tpvueadmin

Target Server Type    : MYSQL
Target Server Version : 50529
File Encoding         : 65001

Date: 2023-07-02 10:35:05
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COMMENT='登录日志';

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COMMENT='菜单';

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '0', '1', '系统管理', 'system', '', '', 'Setting', '', '1', '2');
INSERT INTO `menu` VALUES ('2', '1', '2', '用户管理', 'user', '/system/user', 'system/user/Index.vue', 'User', '/admin/User/initIndex\n/admin/User/getIndexUsers', '1', '1');
INSERT INTO `menu` VALUES ('3', '2', '3', '添加', 'addUser', '', '', '', '/admin/User/initAdd\n/admin/User/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('4', '2', '3', '修改', 'editUser', '', '', '', '/admin/User/initEdit\n/admin/User/saveEdit', '1', '2');
INSERT INTO `menu` VALUES ('5', '1', '2', '部门管理', 'department', '/system/department', 'system/department/Index.vue', 'Memo', '/admin/Department/getIndexDepartments', '1', '2');
INSERT INTO `menu` VALUES ('6', '2', '3', '修改状态', 'userEditStatus', '', '', '', '/admin/User/editStatus', '1', '3');
INSERT INTO `menu` VALUES ('7', '2', '3', '修改密码', 'editUserPassword', '', '', '', '/admin/User/editPassword', '1', '5');
INSERT INTO `menu` VALUES ('8', '5', '3', '添加', 'addDepartment', '', '', '', '/admin/Department/initAdd\n/admin/Department/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('9', '5', '3', '修改', 'editDepartment', '', '', '', '/admin/Department/initEdit\n/admin/Department/saveEdit', '1', '1');
INSERT INTO `menu` VALUES ('10', '5', '3', '删除', 'deleteDepartment', '', '', '', '/admin/Department/delete', '1', '3');
INSERT INTO `menu` VALUES ('11', '1', '2', '角色管理', 'role', '/system/role', 'system/role/Index.vue', 'ChatSquare', '/admin/Role/getIndexRoles', '1', '3');
INSERT INTO `menu` VALUES ('12', '11', '3', '添加', 'addRole', '', '', '', '/admin/Role/initAdd\n/admin/Role/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('13', '11', '3', '修改', 'editRole', '', '', '', '/admin/Role/initEdit\n/admin/Role/saveEdit', '1', '2');
INSERT INTO `menu` VALUES ('14', '11', '3', '删除', 'deleteRole', '', '', '', '/admin/Role/delete', '1', '3');
INSERT INTO `menu` VALUES ('15', '1', '2', '菜单管理', 'menu', '/system/menu', 'system/menu/Index.vue', 'Reading', '/admin/Menu/getIndexMenus', '1', '4');
INSERT INTO `menu` VALUES ('16', '15', '3', '添加', 'addMenu', '', '', '', '/admin/Menu/initAdd\n/admin/Menu/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('17', '15', '3', '修改', 'editMenu', '', '', '', '/admin/Menu/initEdit\n/admin/Menu/saveEdit', '1', '2');
INSERT INTO `menu` VALUES ('18', '15', '3', '删除', 'deleteMenu', '', '', '', '/admin/Menu/delete', '1', '3');
INSERT INTO `menu` VALUES ('19', '1', '2', '字典管理', 'dictionary', '/system/dictionary', 'system/dictionary/Index.vue', 'Document', '/admin/Dictionary/getIndexDictionarys', '1', '5');
INSERT INTO `menu` VALUES ('20', '19', '3', '添加', 'addDictionary', '', '', '', '/admin/Dictionary/saveAdd', '1', '1');
INSERT INTO `menu` VALUES ('21', '19', '3', '修改', 'editDictionary', '', '', '', '/admin/Dictionary/initEdit\n/admin/Dictionary/saveEdit', '1', '2');
INSERT INTO `menu` VALUES ('22', '19', '3', '删除', 'deleteDictionary', '', '', '', '/admin/Dictionary/delete', '1', '3');
INSERT INTO `menu` VALUES ('23', '0', '2', '首页', 'index', '/index', 'Index.vue', 'House', '', '1', '0');
INSERT INTO `menu` VALUES ('24', '0', '1', '个人中心', 'my', '', '', '', '', '2', '3');
INSERT INTO `menu` VALUES ('25', '24', '3', '修改密码', 'editMyPassword', '', '', '', '/admin/my/editPassword', '1', '1');
INSERT INTO `menu` VALUES ('26', '2', '3', '踢下线', 'offLineUser', '', '', '', '/admin/User/offLine', '1', '5');
INSERT INTO `menu` VALUES ('27', '1', '2', '登录日志', 'loginLog', '/system/loginLog', 'system/login_log/Index.vue', 'MapLocation', '/admin/LoginLog/getIndexLoginLogs', '1', '6');
INSERT INTO `menu` VALUES ('28', '1', '2', '操作日志', 'operationLog', '/system/operationLog', 'system/operation_log/Index.vue', 'Mouse', '/admin/OperationLog/getIndexOperationLogs', '1', '7');

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
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COMMENT='消息';

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
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志';

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
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COMMENT='token';

-- ----------------------------
-- Records of token
-- ----------------------------
INSERT INTO `token` VALUES ('16', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTEsIm5hbWUiOiJcdTU1MTBcdTc0MzRcdTY4ODUiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC44NzU3NzEwMCAxNjg1OTU4NjAwIn0.66olJAHZ7kIl_o7YVwlgVO5axTdyTlQl55SQwDqJIEQ', '1685965811', '11');
INSERT INTO `token` VALUES ('31', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTViNTlcdTRlN2VcdTYyMzciLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC44MTY3OTAwMCAxNjg2MjkyNzU1In0.nqoGzsbK4IO424DgyB0X-TC_KhccojB-SunIXbTMWJA', '1686299957', '10');
INSERT INTO `token` VALUES ('32', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTViNTlcdTRlN2VcdTYyMzciLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC40MTc1NzEwMCAxNjg2MjkzNTI4In0.N1dzlG3pt8Xl7kWoSZsI0T1XpRWaveKyX84o1BS9aCs', '1686300983', '10');
INSERT INTO `token` VALUES ('33', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTViNTlcdTRlN2VcdTYyMzciLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC41NTE5ODEwMCAxNjg2Mjk5MzgxIn0.aI9AzhmG4xeNCnRCrytKFO4_cDJBlj0JzDxNViALO6s', '1686311685', '10');
INSERT INTO `token` VALUES ('34', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTViNTlcdTRlN2VcdTYyMzciLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4yNjg0MzUwMCAxNjg2NjIzNTc0In0.LG5xFWgBI07fvbNrvGaSDxi6V--emTUFbDyYDgbwPE0', '1686630775', '10');
INSERT INTO `token` VALUES ('35', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTViNTlcdTRlN2VcdTYyMzciLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC43Njc2MzkwMCAxNjg2NjIzNjE0In0.alrwDCWBnhQGKe7x_qAzMA995123-QtHNxD1FSIO37k', '1686632755', '10');
INSERT INTO `token` VALUES ('36', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4zMjUzNzQwMCAxNjg3NjY2OTUzIn0.9HwP7aONzy-DDaNqDD8eyfn7TV8-Rc872ra_yTizyTk', '1687674533', '10');
INSERT INTO `token` VALUES ('37', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4wMDM0MDMwMCAxNjg4MjY1MjE1In0.3DUvwCXfcldWQ20kQhMbY7R02dAAjzhAgHx8BlI7tAU', '1688272415', '10');
INSERT INTO `token` VALUES ('38', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MTAsIm5hbWUiOiJcdTdiYTFcdTc0MDZcdTU0NTgiLCJkZXBhcnRtZW50X2lkIjoxLCJ0aW1lIjoiMC4zMzY3NzUwMCAxNjg4MjY1MjM3In0.n5CEy19Qd8zZutLB5HOTnczE4NYEbOejbSkdlGbFTdA', '1688272470', '10');

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
