/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : marsdb

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 08/06/2022 13:04:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mc_cha_comment
-- ----------------------------
DROP TABLE IF EXISTS `mc_cha_comment`;
CREATE TABLE `mc_cha_comment`  (
  `cid` int(0) NOT NULL,
  `ccid` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(0) NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`ccid`) USING BTREE,
  INDEX `cccid`(`cid`) USING BTREE,
  INDEX `ccuid`(`uid`) USING BTREE,
  CONSTRAINT `cccid` FOREIGN KEY (`cid`) REFERENCES `mc_challenge` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ccuid` FOREIGN KEY (`uid`) REFERENCES `mc_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_cha_tag
-- ----------------------------
DROP TABLE IF EXISTS `mc_cha_tag`;
CREATE TABLE `mc_cha_tag`  (
  `tgid` int(0) NOT NULL AUTO_INCREMENT,
  `tgname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tid` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`tgid`) USING BTREE,
  UNIQUE INDEX `tgname`(`tgname`) USING BTREE,
  INDEX `tag_tid`(`tid`) USING BTREE,
  CONSTRAINT `tag_tid` FOREIGN KEY (`tid`) REFERENCES `mc_cha_type` (`tid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mc_cha_tag
-- ----------------------------
INSERT INTO `mc_cha_tag` VALUES (39, '文件上传', 1);
INSERT INTO `mc_cha_tag` VALUES (40, 'CSRF', 1);
INSERT INTO `mc_cha_tag` VALUES (41, 'RCE', 1);
INSERT INTO `mc_cha_tag` VALUES (42, '信息泄漏', 1);
INSERT INTO `mc_cha_tag` VALUES (43, '文件包含', 1);
INSERT INTO `mc_cha_tag` VALUES (44, 'web基础', 1);
INSERT INTO `mc_cha_tag` VALUES (46, 'SQL注入', 1);
INSERT INTO `mc_cha_tag` VALUES (47, 'SSRF', 1);
INSERT INTO `mc_cha_tag` VALUES (48, 'XSS', 1);
INSERT INTO `mc_cha_tag` VALUES (49, 'XXE', 1);
INSERT INTO `mc_cha_tag` VALUES (50, '栈溢出', 2);
INSERT INTO `mc_cha_tag` VALUES (51, '堆溢出', 2);
INSERT INTO `mc_cha_tag` VALUES (52, '格式化字符串', 2);
INSERT INTO `mc_cha_tag` VALUES (53, 'double free', 2);
INSERT INTO `mc_cha_tag` VALUES (54, 'pwn基础', 2);
INSERT INTO `mc_cha_tag` VALUES (55, '逆向基础', 3);
INSERT INTO `mc_cha_tag` VALUES (56, '安卓逆向', 3);
INSERT INTO `mc_cha_tag` VALUES (57, 'windows逆向', 3);
INSERT INTO `mc_cha_tag` VALUES (58, '脱壳', 3);
INSERT INTO `mc_cha_tag` VALUES (59, 'RSA', 4);
INSERT INTO `mc_cha_tag` VALUES (60, 'ECB', 4);
INSERT INTO `mc_cha_tag` VALUES (61, '图片隐写', 5);
INSERT INTO `mc_cha_tag` VALUES (62, '音频隐写', 5);
INSERT INTO `mc_cha_tag` VALUES (63, '视频隐写', 5);
INSERT INTO `mc_cha_tag` VALUES (64, '常见编码', 4);
INSERT INTO `mc_cha_tag` VALUES (65, '124', 1);
INSERT INTO `mc_cha_tag` VALUES (66, '421', 1);

-- ----------------------------
-- Table structure for mc_cha_tag_map
-- ----------------------------
DROP TABLE IF EXISTS `mc_cha_tag_map`;
CREATE TABLE `mc_cha_tag_map`  (
  `cid` int(0) NOT NULL,
  `tgid` int(0) NOT NULL,
  PRIMARY KEY (`cid`, `tgid`) USING BTREE,
  INDEX `cha_tag_tgid`(`tgid`) USING BTREE,
  CONSTRAINT `cha_tag_cid` FOREIGN KEY (`cid`) REFERENCES `mc_challenge` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `cha_tag_tgid` FOREIGN KEY (`tgid`) REFERENCES `mc_cha_tag` (`tgid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_cha_type
-- ----------------------------
DROP TABLE IF EXISTS `mc_cha_type`;
CREATE TABLE `mc_cha_type`  (
  `tid` int(0) NOT NULL AUTO_INCREMENT,
  `tname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`tid`) USING BTREE,
  INDEX `tname`(`tname`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mc_cha_type
-- ----------------------------
INSERT INTO `mc_cha_type` VALUES (4, 'crypto');
INSERT INTO `mc_cha_type` VALUES (5, 'misc');
INSERT INTO `mc_cha_type` VALUES (2, 'pwn');
INSERT INTO `mc_cha_type` VALUES (3, 're');
INSERT INTO `mc_cha_type` VALUES (1, 'web');

-- ----------------------------
-- Table structure for mc_challenge
-- ----------------------------
DROP TABLE IF EXISTS `mc_challenge`;
CREATE TABLE `mc_challenge`  (
  `cid` int(0) NOT NULL AUTO_INCREMENT,
  `cname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `score` int(0) NULL DEFAULT NULL,
  `exposed` bit(1) NULL DEFAULT NULL,
  `cretime` datetime(0) NULL DEFAULT NULL,
  `fid` int(0) UNSIGNED NULL DEFAULT NULL,
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `finished_num` int(0) NOT NULL,
  `master_uid` int(0) NULL DEFAULT NULL,
  `tid` int(0) NULL DEFAULT NULL,
  `is_dynamic` bit(1) NULL DEFAULT b'0',
  `image_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `src_port` int(0) NULL DEFAULT NULL,
  `cpu_limit` double(10, 2) NULL DEFAULT NULL,
  `mem_limit` int(0) NULL DEFAULT NULL,
  `download_ok` int(0) NULL DEFAULT NULL,
  `is_dynamic_flag` bit(1) NULL DEFAULT NULL,
  `flag_prefix` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cid`) USING BTREE,
  UNIQUE INDEX `cname`(`cname`) USING BTREE,
  INDEX `file`(`fid`) USING BTREE,
  INDEX `ttid`(`tid`) USING BTREE,
  CONSTRAINT `file` FOREIGN KEY (`fid`) REFERENCES `mc_file` (`fid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ttid` FOREIGN KEY (`tid`) REFERENCES `mc_cha_type` (`tid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 108 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_config
-- ----------------------------
DROP TABLE IF EXISTS `mc_config`;
CREATE TABLE `mc_config`  (
  `docker_min_port` int(0) NULL DEFAULT NULL,
  `docker_max_port` int(0) NULL DEFAULT NULL,
  `ret_domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `frpc_config` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `frpc_api_host` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `frpc_api_port` int(0) NULL DEFAULT NULL,
  `frpc_api_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `frpc_api_pass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `docker_time` int(0) NULL DEFAULT NULL,
  `max_container_count` int(0) NULL DEFAULT NULL,
  `add_time_count` int(0) NULL DEFAULT NULL,
  `add_time_num` int(0) NULL DEFAULT NULL,
  `user_max_container` int(0) NULL DEFAULT NULL,
  `docker_host` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `docker_registry` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_multi` bit(1) NULL DEFAULT NULL,
  `is_tls` bit(1) NULL DEFAULT b'0'
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mc_config
-- ----------------------------
INSERT INTO `mc_config` VALUES (40000, 50000, '127.0.0.1', '[common]\nserver_addr = 192.168.48.1\nserver_port = 7000\ntoken = b1ackc4tyyds\nadmin_addr = 127.0.0.1\nadmin_port = 7400\nadmin_user = admin\nadmin_pwd = admin@Admin\n\n[admin_ui]\ntype = tcp\nlocal_port = 7400\nremote_port = 7400', '127.0.0.1', 7400, 'admin', 'admin', 7200, 100, 3, 3600, 2, 'unix:///var/run/docker.sock', 'http://hub-mirror.c.163.com', b'0', b'0');

-- ----------------------------
-- Table structure for mc_docker_container
-- ----------------------------
DROP TABLE IF EXISTS `mc_docker_container`;
CREATE TABLE `mc_docker_container`  (
  `container_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` int(0) NOT NULL,
  `cid` int(0) NOT NULL,
  `start_time` datetime(0) NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dst_port` int(0) NULL DEFAULT NULL,
  `flag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `add_count` int(0) NULL DEFAULT NULL,
  `add_time` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`, `cid`) USING BTREE,
  INDEX `dockercid`(`cid`) USING BTREE,
  CONSTRAINT `dockercid` FOREIGN KEY (`cid`) REFERENCES `mc_challenge` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `dockeruid` FOREIGN KEY (`uid`) REFERENCES `mc_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_file
-- ----------------------------
DROP TABLE IF EXISTS `mc_file`;
CREATE TABLE `mc_file`  (
  `fid` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `fpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ext` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `size` double NULL DEFAULT NULL,
  PRIMARY KEY (`fid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_learn_cha_map
-- ----------------------------
DROP TABLE IF EXISTS `mc_learn_cha_map`;
CREATE TABLE `mc_learn_cha_map`  (
  `lid` int(0) NOT NULL,
  `cid` int(0) NOT NULL,
  PRIMARY KEY (`lid`, `cid`) USING BTREE,
  INDEX `lcid`(`cid`) USING BTREE,
  CONSTRAINT `lcid` FOREIGN KEY (`cid`) REFERENCES `mc_challenge` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lllid` FOREIGN KEY (`lid`) REFERENCES `mc_learning` (`lid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_learn_comment
-- ----------------------------
DROP TABLE IF EXISTS `mc_learn_comment`;
CREATE TABLE `mc_learn_comment`  (
  `lid` int(0) NOT NULL,
  `lcid` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(0) NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`lcid`) USING BTREE,
  INDEX `lclid`(`lid`) USING BTREE,
  INDEX `lcuid`(`uid`) USING BTREE,
  CONSTRAINT `lclid` FOREIGN KEY (`lid`) REFERENCES `mc_learning` (`lid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `lcuid` FOREIGN KEY (`uid`) REFERENCES `mc_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_learn_image
-- ----------------------------
DROP TABLE IF EXISTS `mc_learn_image`;
CREATE TABLE `mc_learn_image`  (
  `lid` int(0) NOT NULL,
  `fpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_learn_tag_map
-- ----------------------------
DROP TABLE IF EXISTS `mc_learn_tag_map`;
CREATE TABLE `mc_learn_tag_map`  (
  `lid` int(0) NOT NULL,
  `tgid` int(0) NOT NULL,
  PRIMARY KEY (`lid`, `tgid`) USING BTREE,
  INDEX `ltgid`(`tgid`) USING BTREE,
  CONSTRAINT `llid` FOREIGN KEY (`lid`) REFERENCES `mc_learning` (`lid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ltgid` FOREIGN KEY (`tgid`) REFERENCES `mc_cha_tag` (`tgid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_learning
-- ----------------------------
DROP TABLE IF EXISTS `mc_learning`;
CREATE TABLE `mc_learning`  (
  `lid` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `uid` int(0) NOT NULL,
  `tid` int(0) NOT NULL,
  `has_train` bit(1) NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `cre_time` datetime(0) NULL DEFAULT NULL,
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`lid`) USING BTREE,
  INDEX `luid`(`uid`) USING BTREE,
  INDEX `ltid`(`tid`) USING BTREE,
  CONSTRAINT `ltid` FOREIGN KEY (`tid`) REFERENCES `mc_cha_type` (`tid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `luid` FOREIGN KEY (`uid`) REFERENCES `mc_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_notice
-- ----------------------------
DROP TABLE IF EXISTS `mc_notice`;
CREATE TABLE `mc_notice`  (
  `nid` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `uid` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`nid`) USING BTREE,
  INDEX `nouid`(`uid`) USING BTREE,
  CONSTRAINT `nouid` FOREIGN KEY (`uid`) REFERENCES `mc_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_notice_image
-- ----------------------------
DROP TABLE IF EXISTS `mc_notice_image`;
CREATE TABLE `mc_notice_image`  (
  `nid` int(0) UNSIGNED NOT NULL,
  `fpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_user
-- ----------------------------
DROP TABLE IF EXISTS `mc_user`;
CREATE TABLE `mc_user`  (
  `uid` int(0) NOT NULL,
  `uname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` bit(1) NULL DEFAULT NULL,
  `skill` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sign` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reg_time` datetime(0) NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `upassword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `web` int(0) NOT NULL,
  `pwn` int(0) NOT NULL,
  `re` int(0) NOT NULL,
  `crypto` int(0) NOT NULL,
  `misc` int(0) NOT NULL,
  `other` int(0) NOT NULL,
  `score` int(0) NOT NULL,
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE INDEX `uname`(`uname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mc_user
-- ----------------------------
INSERT INTO `mc_user` VALUES (1707327487, 'admin', b'0', 'web', '', 'hubu', '', '2022-06-05 06:34:32', 'ROLE_admin', '$2a$10$ChjgGTVVBlExsgITom8eZ.GQRfQYQFLqXzHqcD4qpB/dISs3WXlFe', 0, 0, 0, 0, 0, 0, 0);

-- ----------------------------
-- Table structure for mc_user_cha_map
-- ----------------------------
DROP TABLE IF EXISTS `mc_user_cha_map`;
CREATE TABLE `mc_user_cha_map`  (
  `uid` int(0) NOT NULL,
  `cid` int(0) NOT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `finish_time` datetime(0) NULL DEFAULT NULL,
  `rank` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`uid`, `cid`) USING BTREE,
  INDEX `ucm_cid`(`cid`) USING BTREE,
  CONSTRAINT `ucm_cid` FOREIGN KEY (`cid`) REFERENCES `mc_challenge` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ucm_uid` FOREIGN KEY (`uid`) REFERENCES `mc_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_wp_comment
-- ----------------------------
DROP TABLE IF EXISTS `mc_wp_comment`;
CREATE TABLE `mc_wp_comment`  (
  `wid` int(0) UNSIGNED NOT NULL,
  `wcid` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int(0) NULL DEFAULT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`wcid`) USING BTREE,
  INDEX `wcwid`(`wid`) USING BTREE,
  INDEX `wcuid`(`uid`) USING BTREE,
  CONSTRAINT `wcuid` FOREIGN KEY (`uid`) REFERENCES `mc_user` (`uid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `wcwid` FOREIGN KEY (`wid`) REFERENCES `mc_writeup` (`wid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_wp_image
-- ----------------------------
DROP TABLE IF EXISTS `mc_wp_image`;
CREATE TABLE `mc_wp_image`  (
  `wid` int(0) UNSIGNED NOT NULL,
  `fpath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mc_writeup
-- ----------------------------
DROP TABLE IF EXISTS `mc_writeup`;
CREATE TABLE `mc_writeup`  (
  `wid` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cid` int(0) NOT NULL,
  `uid` int(0) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `status` bit(1) NULL DEFAULT NULL,
  `score` int(0) NULL DEFAULT NULL,
  `likes` int(0) NULL DEFAULT NULL,
  `wp_tags` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cre_time` datetime(0) NULL DEFAULT NULL,
  `done` bit(1) NULL DEFAULT b'0',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`wid`) USING BTREE,
  INDEX `wpCid`(`cid`) USING BTREE,
  CONSTRAINT `wpCid` FOREIGN KEY (`cid`) REFERENCES `mc_challenge` (`cid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for persistent_logins
-- ----------------------------
DROP TABLE IF EXISTS `persistent_logins`;
CREATE TABLE `persistent_logins`  (
  `username` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `series` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_used` timestamp(0) NOT NULL,
  PRIMARY KEY (`series`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
