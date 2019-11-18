# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: liusijiudb
# Generation Time: 2019-11-16 23:12:31 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table blypay_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `blypay_order`;

CREATE TABLE `blypay_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(50) DEFAULT '',
  `orderid` varchar(50) NOT NULL DEFAULT '' COMMENT '订单号',
  `amout` float(10,2) NOT NULL DEFAULT '0.00',
  `addtime` datetime DEFAULT NULL COMMENT '充值时间',
  `state` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `bank` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录';



# Dump of table game
# ------------------------------------------------------------

DROP TABLE IF EXISTS `game`;

CREATE TABLE `game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(64) DEFAULT '',
  `bet_close_before_draw_in_min` int(10) NOT NULL DEFAULT '10' COMMENT '开奖前多少分钟停止下注',
  `prize_config` varchar(1024) NOT NULL DEFAULT '{}',
  `balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `createdat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏设置';



# Dump of table gamebet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gamebet`;

CREATE TABLE `gamebet` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_draw_id` int(10) unsigned NOT NULL,
  `username` varchar(32) NOT NULL COMMENT '玩家的用户名',
  `bet` varchar(256) NOT NULL DEFAULT '',
  `bet_amount` decimal(12,2) NOT NULL DEFAULT '1.00',
  `bet_amount_currency` varchar(4) NOT NULL DEFAULT 'CAD',
  `match` int(2) NOT NULL DEFAULT '0' COMMENT '对上多少个主号',
  `match2` int(2) NOT NULL DEFAULT '0' COMMENT '对上多少个次号，有的游戏有第二种号',
  `match_bonus` int(2) NOT NULL DEFAULT '0' COMMENT '对上多少个奖励号',
  `prize` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '获得奖励金额',
  `status` enum('Created','Verified','Distributed','Closed') NOT NULL COMMENT '下注状态',
  `createdat` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedat` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `game_draw_id_ind` (`game_draw_id`),
  KEY `username_ind` (`username`),
  CONSTRAINT `gamebet_ibfk_1` FOREIGN KEY (`game_draw_id`) REFERENCES `gamedraw` (`id`) ON DELETE CASCADE,
  CONSTRAINT `gamebet_ibfk_2` FOREIGN KEY (`username`) REFERENCES `h_member` (`h_userName`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏下注';



# Dump of table gamedraw
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gamedraw`;

CREATE TABLE `gamedraw` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_id` int(10) unsigned NOT NULL COMMENT '游戏的ID',
  `draw_time` datetime NOT NULL COMMENT '下次开奖时间',
  `status` enum('NotStarted','Open','BetClose','Drawn','Closed','Distributed') NOT NULL COMMENT '开奖状态',
  `draw_result` varchar(256) NOT NULL DEFAULT '{}',
  `total_income` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_prize_pool` decimal(12,2) NOT NULL DEFAULT '0.00',
  `distributed` decimal(12,2) NOT NULL DEFAULT '0.00',
  `remain_prize` decimal(12,2) NOT NULL DEFAULT '0.00',
  `createdat` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedat` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `game_id_ind` (`game_id`),
  CONSTRAINT `gamedraw_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏开盘';



# Dump of table h_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_admin`;

CREATE TABLE `h_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(50) DEFAULT NULL,
  `h_passWord` varchar(50) DEFAULT NULL,
  `h_nickName` varchar(50) DEFAULT NULL,
  `h_isPass` int(11) DEFAULT '1',
  `h_addTime` datetime DEFAULT NULL,
  `h_permissions` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_api_member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_api_member`;

CREATE TABLE `h_api_member` (
  `api_key` varchar(128) NOT NULL,
  `api_secret` varchar(256) NOT NULL,
  `active` int(4) DEFAULT '1' COMMENT '是否激活',
  `default_cnyf_address` varchar(128) DEFAULT NULL,
  `h_lastUpdatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `h_createdAt` datetime DEFAULT NULL,
  `name` varchar(128) NOT NULL DEFAULT '""' COMMENT '外部应用的名字',
  PRIMARY KEY (`api_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_article
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_article`;

CREATE TABLE `h_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_location` varchar(20) DEFAULT NULL,
  `h_menuId` int(11) DEFAULT NULL,
  `h_title` varchar(250) DEFAULT NULL,
  `h_pageKey` varchar(250) DEFAULT NULL,
  `h_categoryId` int(11) DEFAULT '0',
  `h_picSmall` varchar(250) DEFAULT NULL,
  `h_picBig` varchar(250) DEFAULT NULL,
  `h_picBig2` varchar(250) DEFAULT NULL,
  `h_picBig3` varchar(250) DEFAULT NULL,
  `h_picBig4` varchar(250) DEFAULT NULL,
  `h_picBig5` varchar(250) DEFAULT NULL,
  `h_picBig6` varchar(250) DEFAULT NULL,
  `h_picBig7` varchar(250) DEFAULT NULL,
  `h_picBig8` varchar(250) DEFAULT NULL,
  `h_picBig9` varchar(250) DEFAULT NULL,
  `h_picBig10` varchar(250) DEFAULT NULL,
  `h_isLink` int(11) DEFAULT NULL,
  `h_href` varchar(250) DEFAULT NULL,
  `h_target` varchar(20) DEFAULT NULL,
  `h_addTime` datetime DEFAULT NULL,
  `h_order` int(11) DEFAULT '0',
  `h_clicks` int(11) DEFAULT '0',
  `h_keyword` text,
  `h_description` text,
  `h_info` text,
  `h_jj` text,
  `h_dataSheet` varchar(250) DEFAULT NULL,
  `h_download` varchar(250) DEFAULT NULL,
  `h_pm` varchar(250) DEFAULT NULL,
  `h_pfwz` varchar(250) DEFAULT NULL,
  `h_cz` varchar(250) DEFAULT NULL,
  `h_gy` varchar(250) DEFAULT NULL,
  `h_ys` varchar(250) DEFAULT NULL,
  `h_mz` varchar(250) DEFAULT NULL,
  `h_lsj` decimal(9,2) DEFAULT '0.00',
  `h_hyj` decimal(9,2) DEFAULT '0.00',
  `h_tc1` decimal(9,2) DEFAULT '0.00',
  `h_tc2` decimal(9,2) DEFAULT '0.00',
  `h_tc3` decimal(9,2) DEFAULT '0.00',
  `h_kc` int(11) DEFAULT '0' COMMENT '库存',
  `h_isPass` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_category`;

CREATE TABLE `h_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_location` varchar(20) DEFAULT NULL,
  `h_menuId` int(11) DEFAULT NULL,
  `h_title` varchar(250) DEFAULT NULL,
  `h_pageKey` varchar(200) DEFAULT NULL,
  `h_order` int(11) DEFAULT '0',
  `h_addTime` datetime DEFAULT NULL,
  `h_picBig` varchar(250) DEFAULT NULL,
  `h_picBigN` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_config`;

CREATE TABLE `h_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_webName` varchar(50) DEFAULT NULL,
  `h_webLogo` varchar(250) DEFAULT NULL,
  `h_webLogoLogin` varchar(250) DEFAULT NULL,
  `h_webKeyword` varchar(250) DEFAULT NULL,
  `h_keyword` text,
  `h_description` text,
  `h_leftContact` text,
  `h_counter` text,
  `h_footer` text,
  `h_rewriteOpen` int(11) DEFAULT '0',
  `h_point1Member` int(11) DEFAULT '0' COMMENT '激活会员需要多少激活币',
  `h_point1MemberPoint2` int(11) DEFAULT '0' COMMENT '被激活的会员拥有多少金币',
  `h_point2Quit` int(11) DEFAULT '0' COMMENT '放弃已经拍下来的金币，扣多少金币作为惩罚',
  `h_withdrawFee` decimal(11,2) DEFAULT '0.00' COMMENT '提现手续费百分比',
  `h_withdrawMinCom` int(11) DEFAULT '0' COMMENT '提现要求至少直荐多少人',
  `h_withdrawMinMoney` int(11) DEFAULT '0' COMMENT '提现最低要求金额',
  `h_point2Lottery` int(11) DEFAULT '0' COMMENT '抽奖一次扣多少金币',
  `h_lottery1` int(11) DEFAULT '0' COMMENT '1等奖中奖概率，万分之几',
  `h_lottery2` int(11) DEFAULT '0',
  `h_lottery3` int(11) DEFAULT '0',
  `h_lottery4` int(11) DEFAULT '0',
  `h_lottery5` int(11) DEFAULT '0',
  `h_lottery6` int(11) DEFAULT '0',
  `h_point2Com1` decimal(11,2) DEFAULT '0.00' COMMENT '1代直推奖励',
  `h_point2Com2` decimal(11,2) DEFAULT '0.00',
  `h_point2Com3` decimal(11,2) DEFAULT '0.00',
  `h_point2Com4` decimal(11,2) DEFAULT '0.00',
  `h_point2Com5` decimal(11,2) DEFAULT '0.00',
  `h_point2Com6` decimal(11,2) DEFAULT '0.00' COMMENT '6-10保留，未用',
  `h_point2Com7` decimal(11,3) DEFAULT '0.000',
  `h_point2Com8` decimal(11,3) DEFAULT '0.000',
  `h_point2Com9` decimal(11,2) DEFAULT '0.00',
  `h_point2Com10` decimal(11,2) DEFAULT '0.00',
  `h_levelUpTo0` int(11) DEFAULT '0' COMMENT '升级至vip需要直荐多少人',
  `h_levelUpTo1` int(11) DEFAULT '0',
  `h_levelUpTo2` int(11) DEFAULT '0',
  `h_levelUpTo3` int(11) DEFAULT '0',
  `h_levelUpTo4` int(11) DEFAULT '0',
  `h_levelUpTo5` int(11) DEFAULT '0' COMMENT '5-10保留，未启用',
  `h_levelUpTo6` int(11) DEFAULT '0',
  `h_levelUpTo7` int(11) DEFAULT '0',
  `h_levelUpTo8` int(11) DEFAULT '0',
  `h_levelUpTo9` int(11) DEFAULT '0',
  `h_levelUpTo10` int(11) DEFAULT '0',
  `h_serviceQQ` char(255) DEFAULT NULL,
  `h_point2ComReg` int(11) DEFAULT '0' COMMENT '推荐1个注册会员送金币',
  `h_point2ComRegAct` int(11) DEFAULT '0' COMMENT '推荐的会员被激活时送金币',
  `h_point2ComBuy` int(11) DEFAULT '0',
  `h_point3ComBuy` int(11) DEFAULT '0',
  `h_point4ComBuy` int(11) DEFAULT '0',
  `h_point5ComBuy` int(11) DEFAULT '0',
  `h_operationMode` varchar(32) DEFAULT NULL,
  `h_prod_notify_hostname` varchar(256) DEFAULT NULL COMMENT '正式应用系统的异步通知网站的hostname',
  `h_test_notify_hostname` varchar(256) DEFAULT NULL COMMENT '测试系统的异步通知网站的hostname',
  `h_prod_tradeex_hostname` varchar(256) DEFAULT NULL COMMENT '场外交易系统的网站的hostname',
  `h_test_tradeex_hostname` varchar(256) DEFAULT NULL COMMENT '场外交易系统的测试网站的hostname',
  `h_tradeex_api_key` varchar(256) DEFAULT NULL COMMENT '场外交易系统的API KEY',
  `h_tradeex_api_secret` varchar(256) DEFAULT NULL COMMENT '场外交易系统的API SECRET',
  `h_tradeex_cnyf_address` varchar(256) NOT NULL DEFAULT 'CePqp1uYqM3nsNZqaUdQJWe8awdRsKEhGK' COMMENT '用于把提现的金额转给场外交易的地址',
  `h_purchase_limit` int(11) NOT NULL DEFAULT '3000' COMMENT '每次充值的上限',
  `h_redeem_limit` int(11) NOT NULL DEFAULT '3000' COMMENT '每次提现的上限',
  `h_transfer_cnyf_limit` int(11) NOT NULL DEFAULT '1000' COMMENT '每次转币上限',
  `h_is_test_mode` int(11) NOT NULL DEFAULT '0' COMMENT '是否是测试阶段',
  `h_proxy_api_key` varchar(256) DEFAULT NULL COMMENT '支付网关系统的API KEY',
  `h_proxy_api_secret` varchar(256) DEFAULT NULL COMMENT '支付网关系统的API KEY',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_farm_shop
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_farm_shop`;

CREATE TABLE `h_farm_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_title` char(50) DEFAULT NULL,
  `h_pic` char(255) DEFAULT NULL,
  `h_point2Day` decimal(8,2) DEFAULT '0.00' COMMENT '每天生产金币',
  `h_life` int(11) DEFAULT '0' COMMENT '生存周期',
  `h_money` int(11) DEFAULT '0' COMMENT '售价',
  `h_minMemberLevel` int(11) DEFAULT '0' COMMENT '购买最低会员等级',
  `h_dayBuyMaxNum` int(11) DEFAULT '0' COMMENT '每天限购数量',
  `h_allMaxNum` int(11) DEFAULT '0' COMMENT '农场中最多存在多少只',
  `h_order` int(11) DEFAULT '0',
  `h_addTime` datetime DEFAULT NULL,
  `h_location` varchar(20) DEFAULT NULL,
  `h_menuId` int(11) DEFAULT NULL,
  `cjfh` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `order_id` (`h_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_guestbook
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_guestbook`;

CREATE TABLE `h_guestbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_fullName` varchar(50) DEFAULT NULL,
  `h_address` varchar(250) DEFAULT NULL,
  `h_email` varchar(50) DEFAULT NULL,
  `h_phone` varchar(50) DEFAULT NULL,
  `h_isPass` int(11) DEFAULT '0',
  `h_addTime` datetime DEFAULT NULL,
  `h_message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_log_point1
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_log_point1`;

CREATE TABLE `h_log_point1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(20) DEFAULT NULL,
  `h_price` decimal(14,2) DEFAULT '0.00',
  `h_about` varchar(250) DEFAULT NULL,
  `h_addTime` datetime DEFAULT NULL,
  `h_actIP` char(50) DEFAULT NULL,
  `h_type` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_log_point2
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_log_point2`;

CREATE TABLE `h_log_point2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(20) DEFAULT NULL,
  `h_price` decimal(14,2) DEFAULT '0.00',
  `h_about` varchar(250) DEFAULT NULL,
  `h_addTime` datetime DEFAULT NULL,
  `h_actIP` char(50) DEFAULT NULL,
  `h_type` char(50) DEFAULT NULL,
  `h_member_farm_id` int(11) DEFAULT NULL,
  `h_additional_info` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_member`;

CREATE TABLE `h_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(32) DEFAULT NULL,
  `h_passWord` varchar(32) DEFAULT NULL,
  `h_passWordII` varchar(32) DEFAULT NULL,
  `h_fullName` varchar(20) DEFAULT NULL,
  `h_sex` varchar(2) DEFAULT NULL,
  `h_mobile` varchar(11) DEFAULT NULL,
  `h_qq` varchar(20) DEFAULT NULL,
  `h_email` varchar(50) DEFAULT NULL,
  `h_regTime` datetime DEFAULT NULL,
  `h_regIP` char(50) DEFAULT NULL,
  `h_isPass` int(11) DEFAULT '0' COMMENT '是否激活，激活才能登录',
  `h_moneyCurr` decimal(9,2) DEFAULT '0.00' COMMENT '会员余额',
  `h_parentUserName` varchar(20) DEFAULT NULL,
  `h_level` int(11) DEFAULT '0',
  `h_point1` decimal(14,2) DEFAULT '0.00' COMMENT '激活币',
  `h_point2` decimal(14,2) DEFAULT '0.00' COMMENT '金币',
  `h_lastTime` datetime DEFAULT NULL,
  `h_lastIP` char(50) DEFAULT NULL,
  `h_alipayUserName` char(100) DEFAULT NULL,
  `h_alipayFullName` char(100) DEFAULT NULL,
  `h_addrAddress` char(255) DEFAULT NULL,
  `h_addrPostcode` char(20) DEFAULT NULL,
  `h_addrFullName` char(20) DEFAULT NULL,
  `h_addrTel` char(20) DEFAULT NULL,
  `h_weixin` char(100) DEFAULT NULL,
  `h_logins` int(11) DEFAULT '0',
  `h_a1` char(255) DEFAULT NULL,
  `h_q1` char(255) DEFAULT NULL,
  `h_a2` char(255) DEFAULT NULL,
  `h_q2` char(255) DEFAULT NULL,
  `h_a3` char(255) DEFAULT NULL,
  `h_q3` char(255) DEFAULT NULL,
  `h_isLock` int(11) DEFAULT '0' COMMENT '锁定，不可登录',
  `first_buy` int(1) DEFAULT '0',
  `h_jifen` int(11) NOT NULL DEFAULT '0',
  `qrcode` varchar(255) DEFAULT NULL,
  `h_lastUpdatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `h_canRedeem` int(11) DEFAULT '0' COMMENT '是否可以提现',
  `h_weixin_qrcode` varchar(256) DEFAULT NULL COMMENT '微信收款二维码文件名',
  PRIMARY KEY (`id`),
  UNIQUE KEY `QUNIQUE_USER_API_KEY` (`h_userName`),
  KEY `INDEX_USER_API_KEY` (`h_userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_member_farm
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_member_farm`;

CREATE TABLE `h_member_farm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(20) DEFAULT NULL,
  `h_pid` int(11) DEFAULT '0' COMMENT '动物id',
  `h_num` int(11) DEFAULT '0' COMMENT '动物数量',
  `h_addTime` datetime DEFAULT NULL COMMENT '购买时间',
  `h_endTime` datetime DEFAULT NULL COMMENT '动物死亡时间',
  `h_lastSettleTime` datetime DEFAULT NULL COMMENT '最后一次结算时间，直接在结算时记录当前时间；只用于显示或者备忘，结算算法中不用这个字段',
  `h_settleLen` int(11) DEFAULT '0' COMMENT '结算次数',
  `h_isEnd` int(11) DEFAULT '0' COMMENT '动物是否死亡',
  `h_title` char(50) DEFAULT NULL,
  `h_pic` char(255) DEFAULT NULL,
  `h_point2Day` decimal(8,2) DEFAULT '0.00' COMMENT '每天生产金币',
  `h_life` int(11) DEFAULT '0' COMMENT '生存周期',
  `h_money` int(11) DEFAULT '0' COMMENT '售价',
  `cjfh` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `order_id` (`h_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_member_msg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_member_msg`;

CREATE TABLE `h_member_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(20) DEFAULT NULL,
  `h_toUserName` varchar(20) DEFAULT NULL COMMENT '买家',
  `h_info` text,
  `h_addTime` datetime DEFAULT NULL,
  `h_actIP` char(39) DEFAULT NULL,
  `h_isRead` int(11) DEFAULT '0',
  `h_readTime` datetime DEFAULT NULL,
  `h_isDelete` int(11) DEFAULT '0' COMMENT '放弃或删除',
  `h_deleteTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_member_shop_cart
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_member_shop_cart`;

CREATE TABLE `h_member_shop_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_oid` varchar(20) DEFAULT NULL,
  `h_userName` varchar(20) DEFAULT NULL,
  `h_pid` int(11) DEFAULT '0' COMMENT '动物id',
  `h_num` int(11) DEFAULT '0' COMMENT '动物数量',
  `h_addTime` datetime DEFAULT NULL COMMENT '购买时间',
  `h_title` char(50) DEFAULT NULL,
  `h_pic` char(255) DEFAULT NULL,
  `h_money` int(11) DEFAULT '0' COMMENT '售价',
  PRIMARY KEY (`id`),
  KEY `order_id` (`h_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_member_shop_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_member_shop_order`;

CREATE TABLE `h_member_shop_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_oid` varchar(20) DEFAULT NULL,
  `h_userName` varchar(20) DEFAULT NULL,
  `h_addTime` datetime DEFAULT NULL COMMENT '购买时间',
  `h_addrAddress` char(255) DEFAULT NULL,
  `h_addrPostcode` char(20) DEFAULT NULL,
  `h_addrFullName` char(20) DEFAULT NULL,
  `h_addrTel` char(20) DEFAULT NULL,
  `h_remark` text,
  `h_state` char(20) DEFAULT NULL COMMENT '待发货、已发货、拒绝发货',
  `h_money` int(11) DEFAULT '0' COMMENT '订单总价',
  `h_isReturn` int(20) DEFAULT '0' COMMENT '若审核失败，是否返款了，只返一次',
  `h_reply` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_menu`;

CREATE TABLE `h_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_location` varchar(20) DEFAULT NULL,
  `h_type` varchar(20) DEFAULT NULL,
  `h_adminFile` varchar(30) DEFAULT NULL,
  `h_title` varchar(200) DEFAULT NULL,
  `h_pageKey` varchar(200) DEFAULT NULL,
  `h_href` varchar(250) DEFAULT NULL,
  `h_isPass` int(11) DEFAULT '1',
  `h_target` varchar(10) DEFAULT NULL,
  `h_order` int(11) DEFAULT '0',
  `h_picBigWidth` int(11) DEFAULT '0',
  `h_picBigHeight` int(11) DEFAULT '0',
  `h_picSmallWidth` int(11) DEFAULT '0',
  `h_picSmallHeight` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_pay_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_pay_order`;

CREATE TABLE `h_pay_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_payId` char(32) DEFAULT NULL,
  `h_orderId` varchar(32) DEFAULT NULL,
  `h_payWay` char(50) DEFAULT NULL,
  `h_payType` char(50) DEFAULT NULL,
  `h_payPrice` decimal(9,2) DEFAULT '0.00' COMMENT '打折后的金额',
  `h_addTime` datetime DEFAULT NULL,
  `h_payTime` datetime DEFAULT '0000-00-00 00:00:00' COMMENT '支付时间',
  `h_payState` char(50) DEFAULT '待支付' COMMENT '待支付、已支付、支付失败',
  `h_wxNickName` varchar(250) DEFAULT NULL,
  `h_wxOpenId` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`h_payId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_point2_sell
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_point2_sell`;

CREATE TABLE `h_point2_sell` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(20) DEFAULT NULL,
  `h_money` int(11) DEFAULT '0',
  `h_alipayUserName` char(100) DEFAULT NULL,
  `h_alipayFullName` char(100) DEFAULT NULL,
  `h_weixin` char(100) DEFAULT NULL,
  `h_tel` char(20) DEFAULT NULL,
  `h_addTime` datetime DEFAULT NULL,
  `h_state` char(20) DEFAULT NULL COMMENT '挂单中、等待买家付款、买家放弃、卖家放弃、等待卖家确认收款、交易完成',
  `h_buyUserName` varchar(20) DEFAULT NULL COMMENT '买家',
  `h_buyTime` datetime DEFAULT NULL,
  `h_buyIsPay` int(11) DEFAULT '0',
  `h_payTime` datetime DEFAULT NULL,
  `h_isDelete` int(11) DEFAULT '0' COMMENT '放弃或删除',
  `h_deleteTime` datetime DEFAULT NULL,
  `h_confirmTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_point2_shop
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_point2_shop`;

CREATE TABLE `h_point2_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_title` char(255) DEFAULT NULL,
  `h_pic` char(255) DEFAULT NULL,
  `h_minComMembers` int(11) DEFAULT '0' COMMENT '至少要直荐多少人',
  `h_money` int(11) DEFAULT '0' COMMENT '售价',
  `h_minMemberLevel` int(11) DEFAULT '0' COMMENT '购买最低会员等级',
  `h_info` text,
  `h_addTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`h_title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_recharge
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_recharge`;

CREATE TABLE `h_recharge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(50) DEFAULT NULL,
  `h_money` decimal(14,2) DEFAULT '0.00',
  `h_fee` decimal(14,2) DEFAULT '0.00',
  `h_bank` tinyint(2) DEFAULT '0',
  `h_bankFullname` varchar(64) DEFAULT NULL,
  `h_bankCardId` varchar(32) DEFAULT NULL,
  `h_mobile` varchar(20) DEFAULT NULL,
  `h_addTime` datetime DEFAULT NULL,
  `h_isRead` int(20) DEFAULT '0',
  `h_state` tinyint(20) DEFAULT NULL COMMENT '待审核、已打款、审核失败',
  `h_isReturn` int(20) DEFAULT '0' COMMENT '若审核失败，是否返款了，只返一次',
  `h_reply` char(255) DEFAULT NULL,
  `h_actIP` char(39) DEFAULT NULL,
  `out_trade_no` varchar(100) DEFAULT NULL,
  `h_refIdType` varchar(32) DEFAULT 'out_trade_no',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_UserWallet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_UserWallet`;

CREATE TABLE `h_UserWallet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `h_crypto` varchar(8) NOT NULL,
  `h_address` varchar(64) NOT NULL,
  `h_balance` decimal(16,2) NOT NULL DEFAULT '0.00',
  `h_balance_locked` decimal(16,2) NOT NULL DEFAULT '0.00',
  `h_balance_available` decimal(16,2) NOT NULL DEFAULT '0.00',
  `h_lastUpdatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_UserWalletExternal
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_UserWalletExternal`;

CREATE TABLE `h_UserWalletExternal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `h_crypto` varchar(8) NOT NULL,
  `h_address` varchar(64) NOT NULL,
  `h_alias` varchar(32) DEFAULT '',
  `h_lastUpdatedAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_Wallet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_Wallet`;

CREATE TABLE `h_Wallet` (
  `h_crypto` varchar(8) NOT NULL,
  `h_ru` varchar(32) NOT NULL,
  `h_rp` varchar(256) NOT NULL,
  `h_port` int(11) NOT NULL DEFAULT '0',
  `h_walletpassphrase` varchar(32) DEFAULT NULL,
  `h_lastUpdatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`h_crypto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table h_withdraw
# ------------------------------------------------------------

DROP TABLE IF EXISTS `h_withdraw`;

CREATE TABLE `h_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` varchar(50) DEFAULT NULL,
  `h_money` decimal(11,2) DEFAULT '0.00',
  `h_fee` decimal(11,2) DEFAULT '0.00',
  `h_bank` varchar(32) DEFAULT NULL,
  `h_bankFullname` varchar(32) DEFAULT NULL,
  `h_bankCardId` varchar(32) DEFAULT NULL,
  `h_mobile` varchar(20) DEFAULT NULL,
  `h_addTime` datetime DEFAULT NULL,
  `h_isRead` int(20) DEFAULT '0',
  `h_state` char(20) DEFAULT NULL COMMENT '待审核、已打款、审核失败',
  `h_isReturn` int(20) DEFAULT '0' COMMENT '若审核失败，是否返款了，只返一次',
  `h_reply` char(255) DEFAULT NULL,
  `h_actIP` char(39) DEFAULT NULL,
  `h_imgs` varchar(150) DEFAULT NULL,
  `out_trade_no` varchar(250) DEFAULT '0' COMMENT '支付订单号',
  `h_refIdType` varchar(32) DEFAULT 'out_trade_no',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logtime` datetime DEFAULT NULL,
  `data` text,
  `type` varchar(255) DEFAULT 'test',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `out_trade_no` varchar(255) DEFAULT NULL COMMENT '订单号',
  `username` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `total_fee` decimal(8,2) DEFAULT '0.00' COMMENT '支付金额（元）',
  `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `ip` varchar(255) DEFAULT NULL,
  `trx_bill_no` varchar(255) DEFAULT '',
  `status` varchar(255) DEFAULT 'UNKNOWN' COMMENT '支付状态',
  `type` varchar(255) DEFAULT 'recharge' COMMENT 'recharge 充值，withdraw提现',
  `txid` varchar(128) DEFAULT NULL COMMENT '对于recharge, 这是成功后转币的交易，对于提现，这是提现前的转给场外交易的地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shoukuanla_order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shoukuanla_order`;

CREATE TABLE `shoukuanla_order` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `uid` int(10) NOT NULL DEFAULT '0' COMMENT 'uid',
  `money` float(10,2) NOT NULL DEFAULT '0.00',
  `num` char(40) NOT NULL DEFAULT '' COMMENT '订单号',
  `paytype` char(10) NOT NULL COMMENT '支付类型',
  `jiaoyi` char(50) NOT NULL COMMENT '交易号',
  `addtime` int(10) NOT NULL DEFAULT '0' COMMENT '充值时间',
  `state` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `skl_order` char(50) DEFAULT NULL COMMENT '扫码备注',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='充值记录';



# Dump of table t_log_login_member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `t_log_login_member`;

CREATE TABLE `t_log_login_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_userName` char(20) DEFAULT NULL,
  `h_ip` char(39) DEFAULT NULL,
  `h_addTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
