# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: liusijiudb
# Generation Time: 2020-03-03 03:07:27 +0000
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



# Dump of table current_match_bets
# ------------------------------------------------------------

DROP VIEW IF EXISTS `current_match_bets`;

CREATE TABLE `current_match_bets` (
   `username` VARCHAR(32) NOT NULL,
   `match_count` BIGINT(21) NOT NULL DEFAULT '0',
   `match` INT(2) NOT NULL DEFAULT '0'
) ENGINE=MyISAM;



# Dump of table game
# ------------------------------------------------------------

DROP TABLE IF EXISTS `game`;

CREATE TABLE `game` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(64) NOT NULL DEFAULT '',
  `bet_close_before_draw_in_min` int(10) NOT NULL DEFAULT '10' COMMENT '开奖前多少分钟停止下注',
  `prize_config` varchar(1024) NOT NULL DEFAULT '{}',
  `balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `prize_pool` decimal(12,2) NOT NULL DEFAULT '0.00',
  `userIP` varchar(32) NOT NULL DEFAULT '127.0.0.1',
  `createdat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `next_draw_utc` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏设置';

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;

INSERT INTO `game` (`id`, `name`, `bet_close_before_draw_in_min`, `prize_config`, `balance`, `prize_pool`, `userIP`, `createdat`, `updatedat`, `next_draw_utc`)
VALUES
	(1,'649',10,'{  \"match_rules\": [\n       {   \"match_count\" :  2, \"reward_type\": \"fixed\", \"reward\": 1 },      \n       {   \"match_count\" :  3, \"reward_type\": \"fixed\", \"reward\": 10 },\n       {   \"match_count\" :  4, \"reward_type\": \"ratio\", \"reward\" :  0.08},\n       {   \"match_count\" :  5, \"reward_type\": \"ratio\", \"reward\" :  0.12},\n       {   \"match_count\" :  6, \"reward_type\": \"ratio\", \"reward\" :  0.4},\n   ]\n}',0.00,0.00,'127.0.0.1','2019-12-05 20:55:17','2019-12-05 21:01:52',NULL);

/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gamebet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gamebet`;

CREATE TABLE `gamebet` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `game_draw_id` varchar(16) NOT NULL COMMENT '每次开盘的ID',
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
  CONSTRAINT `gamebet_ibfk_1` FOREIGN KEY (`game_draw_id`) REFERENCES `gamedraw` (`draw_id`) ON DELETE CASCADE,
  CONSTRAINT `gamebet_ibfk_2` FOREIGN KEY (`username`) REFERENCES `h_member` (`h_userName`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏下注';



# Dump of table gamedraw
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gamedraw`;

CREATE TABLE `gamedraw` (
  `draw_id` varchar(16) NOT NULL COMMENT '每次开盘的ID',
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
  PRIMARY KEY (`draw_id`),
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
  `h_tradeex_hostname` varchar(256) DEFAULT NULL COMMENT '场外交易系统的网站的hostname',
  `h_tradeex_hostport` int(11) DEFAULT NULL,
  `h_tradeex_api_key` varchar(256) DEFAULT NULL COMMENT '场外交易系统的API KEY',
  `h_tradeex_api_secret` varchar(256) DEFAULT NULL COMMENT '场外交易系统的API SECRET',
  `h_tradeex_cnyf_address` varchar(256) NOT NULL DEFAULT 'CePqp1uYqM3nsNZqaUdQJWe8awdRsKEhGK' COMMENT '用于把提现的金额转给场外交易的地址',
  `h_purchase_limit` int(11) NOT NULL DEFAULT '3000' COMMENT '每次充值的上限',
  `h_redeem_limit` int(11) NOT NULL DEFAULT '3000' COMMENT '每次提现的上限',
  `h_transfer_cnyf_limit` int(11) NOT NULL DEFAULT '1000' COMMENT '每次转币上限',
  `h_is_test_mode` int(11) NOT NULL DEFAULT '0' COMMENT '是否是测试阶段',
  `h_proxy_api_key` varchar(256) DEFAULT NULL COMMENT '支付网关系统的API KEY',
  `h_proxy_api_secret` varchar(256) DEFAULT NULL COMMENT '支付网关系统的API KEY',
  `h_next_649_draw_id` varchar(16) DEFAULT NULL COMMENT '下一个开盘ID，YYYYMMDD0649',
  `h_default_paypal_client_id` varchar(128) DEFAULT NULL COMMENT '目前卖家的信息',
  `h_tradeex_site_url` varchar(128) DEFAULT NULL COMMENT '场外交易网站URL',
  `h_notify_url` varchar(128) DEFAULT NULL COMMENT '充值异步通知 URL',
  `h_return_url` varchar(128) DEFAULT NULL COMMENT '充值跳转URL',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `h_config` WRITE;
/*!40000 ALTER TABLE `h_config` DISABLE KEYS */;

INSERT INTO `h_config` (`id`, `h_webName`, `h_webLogo`, `h_webLogoLogin`, `h_webKeyword`, `h_keyword`, `h_description`, `h_leftContact`, `h_counter`, `h_footer`, `h_rewriteOpen`, `h_point1Member`, `h_point1MemberPoint2`, `h_point2Quit`, `h_withdrawFee`, `h_withdrawMinCom`, `h_withdrawMinMoney`, `h_point2Lottery`, `h_lottery1`, `h_lottery2`, `h_lottery3`, `h_lottery4`, `h_lottery5`, `h_lottery6`, `h_point2Com1`, `h_point2Com2`, `h_point2Com3`, `h_point2Com4`, `h_point2Com5`, `h_point2Com6`, `h_point2Com7`, `h_point2Com8`, `h_point2Com9`, `h_point2Com10`, `h_levelUpTo0`, `h_levelUpTo1`, `h_levelUpTo2`, `h_levelUpTo3`, `h_levelUpTo4`, `h_levelUpTo5`, `h_levelUpTo6`, `h_levelUpTo7`, `h_levelUpTo8`, `h_levelUpTo9`, `h_levelUpTo10`, `h_serviceQQ`, `h_point2ComReg`, `h_point2ComRegAct`, `h_point2ComBuy`, `h_point3ComBuy`, `h_point4ComBuy`, `h_point5ComBuy`, `h_operationMode`, `h_prod_notify_hostname`, `h_test_notify_hostname`, `h_tradeex_hostname`, `h_tradeex_hostport`, `h_tradeex_api_key`, `h_tradeex_api_secret`, `h_tradeex_cnyf_address`, `h_purchase_limit`, `h_redeem_limit`, `h_transfer_cnyf_limit`, `h_is_test_mode`, `h_proxy_api_key`, `h_proxy_api_secret`, `h_next_649_draw_id`, `h_default_paypal_client_id`, `h_tradeex_site_url`, `h_notify_url`, `h_return_url`)
VALUES
	(0,'彩票网站','/static/img/logo.png','649彩票','Lottery, 649, 彩票',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0,0.00,0.00,0.00,0.00,0.00,0.00,0.000,0.000,0.00,0.00,0,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,'NAKI4WASX20FX67SQGLIERCDPPR9VDFX','d821545f0c31a821901ddfe408c8c553','CePqp1uYqM3nsNZqaUdQJWe8awdRsKEhGK',3000,3000,1000,0,NULL,NULL,NULL,'ATXaDkQkUmwqFMtHV3wSzcU3v-I-i7VRyT_aid_leLJj7zozUuuXsRJBpB9tjDp8zKnuKcXJu08BR9ac','http://127.0.0.1:8000','http://localhost:8083/payment/notify.php','http://localhost:8083/game/game.php');

/*!40000 ALTER TABLE `h_config` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `h_log_point2` WRITE;
/*!40000 ALTER TABLE `h_log_point2` DISABLE KEYS */;

INSERT INTO `h_log_point2` (`id`, `h_userName`, `h_price`, `h_about`, `h_addTime`, `h_actIP`, `h_type`, `h_member_farm_id`, `h_additional_info`)
VALUES
	(1,'18888888888',1000.00,'out_trade_no:20200210055231398786','2020-02-10 05:54:03','::1','充值',NULL,NULL);

/*!40000 ALTER TABLE `h_log_point2` ENABLE KEYS */;
UNLOCK TABLES;


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
  `reward` decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '赢的奖励',
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

LOCK TABLES `h_member` WRITE;
/*!40000 ALTER TABLE `h_member` DISABLE KEYS */;

INSERT INTO `h_member` (`id`, `h_userName`, `h_passWord`, `h_passWordII`, `h_fullName`, `h_sex`, `h_mobile`, `h_qq`, `h_email`, `h_regTime`, `h_regIP`, `h_isPass`, `h_moneyCurr`, `h_parentUserName`, `h_level`, `h_point1`, `h_point2`, `h_lastTime`, `reward`, `h_lastIP`, `h_alipayUserName`, `h_alipayFullName`, `h_addrAddress`, `h_addrPostcode`, `h_addrFullName`, `h_addrTel`, `h_weixin`, `h_logins`, `h_a1`, `h_q1`, `h_a2`, `h_q2`, `h_a3`, `h_q3`, `h_isLock`, `first_buy`, `h_jifen`, `qrcode`, `h_lastUpdatedAt`, `h_canRedeem`, `h_weixin_qrcode`)
VALUES
	(1,'18888888888','e10adc3949ba59abbe56e057f20f883e','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,NULL,NULL,NULL,'2018-07-30 15:19:18','115.84.97.91',1,0.00,'',4,0.00,4836.14,'2020-02-23 07:52:31',0.00,'::1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,40,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,'2020-02-22 15:52:31',0,NULL),
	(2,'17777788888','e10adc3949ba59abbe56e057f20f883e','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,NULL,NULL,NULL,'2020-01-15 11:46:19','::1',1,0.00,'18888888888',4,0.00,0.00,'2020-01-15 11:46:46',0.00,'::1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,'2020-01-14 19:46:46',0,NULL),
	(3,'16666677777','e10adc3949ba59abbe56e057f20f883e','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,NULL,NULL,NULL,'2020-01-15 11:48:02','::1',1,0.00,'17777788888',4,0.00,0.00,'2020-01-15 11:48:12',0.00,'::1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,'2020-01-14 19:48:12',0,NULL);

/*!40000 ALTER TABLE `h_member` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `h_recharge` WRITE;
/*!40000 ALTER TABLE `h_recharge` DISABLE KEYS */;

INSERT INTO `h_recharge` (`id`, `h_userName`, `h_money`, `h_fee`, `h_bank`, `h_bankFullname`, `h_bankCardId`, `h_mobile`, `h_addTime`, `h_isRead`, `h_state`, `h_isReturn`, `h_reply`, `h_actIP`, `out_trade_no`, `h_refIdType`)
VALUES
	(1,'',10.00,0.00,0,'out_trade_no:20200206095245182549',NULL,NULL,'2020-02-06 09:52:47',0,2,0,NULL,'::1','20200206095245182549','out_trade_no'),
	(2,'',10.00,0.00,0,'out_trade_no:20200206100331116268',NULL,NULL,'2020-02-06 10:03:33',0,2,0,NULL,'::1','20200206100331116268','out_trade_no'),
	(3,'',10.00,0.00,0,'out_trade_no:20200206110207327226',NULL,NULL,'2020-02-06 11:02:09',0,2,0,NULL,'::1','20200206110207327226','out_trade_no'),
	(4,'',10.00,0.00,0,'out_trade_no:20200206112809324546',NULL,NULL,'2020-02-06 11:28:11',0,2,0,NULL,'::1','20200206112809324546','out_trade_no'),
	(5,'18888888888',10.00,0.00,0,'out_trade_no:20200210055033913328',NULL,NULL,'2020-02-10 05:50:34',0,2,0,NULL,'::1','20200210055033913328','out_trade_no'),
	(6,'18888888888',10.00,0.00,0,'out_trade_no:20200210055231398786',NULL,NULL,'2020-02-10 05:54:03',0,1,1,NULL,'::1','20200210055231398786','out_trade_no');

/*!40000 ALTER TABLE `h_recharge` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;

INSERT INTO `log` (`id`, `logtime`, `data`, `type`)
VALUES
	(1,'2020-02-06 09:23:26','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200206091822945843\", \"trx_bill_no\": \"API_TX_20200206092210_304064\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u6237\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"D5166519E942F367B377A76E5B7F661B\"}\",\"IP\":\"::1\"}','test'),
	(2,'2020-02-06 09:23:31','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200206090324251306\", \"trx_bill_no\": \"API_TX_20200206090325_147983\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u6237\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"Success\", \"sign\": \"8558E49CDD16C7776A67DDBEF0A6D13E\"}\",\"IP\":\"::1\"}','test'),
	(3,'2020-02-06 09:48:52','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200206092627935225\", \"trx_bill_no\": \"API_TX_20200206092653_275774\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u6237\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"7B9590345CBE20CD2E3A421F2C77A205\"}\",\"IP\":\"::1\"}','test'),
	(4,'2020-02-06 09:52:08','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200206094901772968\", \"trx_bill_no\": \"API_TX_20200206095138_827975\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u6237\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"F7D5F9E211885AD560670599C73E036D\"}\",\"IP\":\"::1\"}','test'),
	(5,'2020-02-06 10:03:14','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200206095245182549\", \"trx_bill_no\": \"API_TX_20200206095246_009952\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u6237\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"2167CBF0A6B5E92BDE9616DE847FB766\"}\",\"IP\":\"::1\"}','test'),
	(6,'2020-02-06 10:44:18','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200206100331116268\", \"trx_bill_no\": \"API_TX_20200206100331_616786\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u6237\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"8357D4A3999B809993F3EFE58FDFB73F\"}\",\"IP\":\"::1\"}','test'),
	(7,'2020-02-06 11:27:50','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200206110207327226\", \"trx_bill_no\": \"API_TX_20200206110207_232881\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u6237\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"A18895EA6D08428A4056E1BE266D92C4\"}\",\"IP\":\"::1\"}','test'),
	(8,'2020-02-06 11:37:25','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200206112809324546\", \"trx_bill_no\": \"API_TX_20200206112810_002678\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u6237\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"6B4B728E61273D1940DCAA3E1A7E76EA\"}\",\"IP\":\"::1\"}','test'),
	(9,'2020-02-10 05:21:12','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200210052007591234\", \"trx_bill_no\": \"API_TX_20200210052007_773103\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u623718888888888\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=18888888888\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"DF11E0C762DB549CB7A3B63F5C358833\"}\",\"IP\":\"::1\"}','test'),
	(10,'2020-02-10 05:48:57','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200210054518933997\", \"trx_bill_no\": \"API_TX_20200210054519_204087\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u623718888888888\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=18888888888\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"565BDE72857CE744FA20DA4F3E206B7A\"}\",\"IP\":\"::1\"}','test'),
	(11,'2020-02-10 05:48:59','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200210054028895011\", \"trx_bill_no\": \"API_TX_20200210054028_494282\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u623718888888888\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=18888888888\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"3763E8B8939AB50D0206913BB48A40A9\"}\",\"IP\":\"::1\"}','test'),
	(12,'2020-02-10 05:49:05','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200210052727419738\", \"trx_bill_no\": \"API_TX_20200210052727_860111\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u623718888888888\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=18888888888\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"4E8A475E34A299045AEA7B3874367732\"}\",\"IP\":\"::1\"}','test'),
	(13,'2020-02-10 05:49:08','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200210052131414647\", \"trx_bill_no\": \"API_TX_20200210052131_564040\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u623718888888888\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=18888888888\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"6033D0E7A1A271C5455B452925D55119\"}\",\"IP\":\"::1\"}','test'),
	(14,'2020-02-10 05:52:18','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200210055033913328\", \"trx_bill_no\": \"API_TX_20200210055033_389513\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u623718888888888\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=18888888888\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"UserAbandon\", \"sign\": \"9B2D9A112171E498EF6501D1FBC4F4EF\"}\",\"IP\":\"::1\"}','test'),
	(15,'2020-02-10 05:54:03','{\"POST\":[],\"GET\":[],\"REQUEST_URI\":\"/payment/notify.php\",\"HTTP_USER_AGENT\":\"python-requests/2.19.1\",\"HTTP_RAW_POST_DATA\":\"{\"version\": \"1.0\", \"api_key\": \"NAKI4WASX20FX67SQGLIERCDPPR9VDFX\", \"out_trade_no\": \"20200210055231398786\", \"trx_bill_no\": \"API_TX_20200210055231_394050\", \"payment_provider\": \"paypal\", \"subject\": \"\\u6e38\\u620f\\u7f51\\u7ad9\\u5ba2\\u623718888888888\\u8bf7\\u6c42\\u5145\\u503c10\\u52a0\\u5143\", \"attach\": \"username=18888888888\", \"total_amount\": 1000, \"real_fee\": 0, \"received_time\": null, \"trade_status\": \"Success\", \"sign\": \"E361FD0D783AEEC915F274E5704A6870\"}\",\"IP\":\"::1\"}','test');

/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;

INSERT INTO `order` (`id`, `out_trade_no`, `username`, `subject`, `total_fee`, `submit_time`, `pay_time`, `ip`, `trx_bill_no`, `status`, `type`, `txid`)
VALUES
	(1,'20200206095245182549','','',1000.00,'2020-02-06 09:52:47','2020-02-06 10:03:14','::1','API_TX_20200206095246_009952','userabandon','recharge',NULL),
	(2,'20200206100331116268','','游戏网站客户请求充值10加元',1000.00,'2020-02-06 10:03:33','2020-02-06 10:44:18','::1','API_TX_20200206100331_616786','userabandon','recharge',NULL),
	(3,'20200206110207327226','','游戏网站客户请求充值10加元',1000.00,'2020-02-06 11:02:09','2020-02-06 11:27:50','::1','API_TX_20200206110207_232881','userabandon','recharge',NULL),
	(4,'20200206112809324546','','游戏网站客户请求充值10加元',1000.00,'2020-02-06 11:28:11','2020-02-06 11:37:25','::1','API_TX_20200206112810_002678','userabandon','recharge',NULL),
	(5,'20200210055033913328','18888888888','游戏网站客户18888888888请求充值10加元',1000.00,'2020-02-10 05:50:34','2020-02-10 05:52:18','::1','API_TX_20200210055033_389513','userabandon','recharge',NULL),
	(6,'20200210055231398786','18888888888','游戏网站客户18888888888请求充值10加元',1000.00,'2020-02-10 05:52:32','2020-02-10 05:54:03','::1','API_TX_20200210055231_394050','success','recharge',NULL);

/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;


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

LOCK TABLES `t_log_login_member` WRITE;
/*!40000 ALTER TABLE `t_log_login_member` DISABLE KEYS */;

INSERT INTO `t_log_login_member` (`id`, `h_userName`, `h_ip`, `h_addTime`)
VALUES
	(1,'18888888888','::1','2019-11-18 13:28:11'),
	(2,'18888888888','::1','2019-11-19 06:00:21'),
	(3,'18888888888','::1','2020-01-10 09:29:44'),
	(4,'18888888888','::1','2020-01-10 10:17:44'),
	(5,'18888888888','::1','2020-01-10 10:21:00'),
	(6,'18888888888','::1','2020-01-15 09:56:13'),
	(7,'18888888888','::1','2020-01-15 10:25:23'),
	(8,'18888888888','::1','2020-01-15 11:38:49'),
	(9,'17777788888','::1','2020-01-15 11:46:46'),
	(10,'16666677777','::1','2020-01-15 11:48:12'),
	(11,'18888888888','::1','2020-01-22 09:48:53'),
	(12,'18888888888','::1','2020-02-04 13:01:13'),
	(13,'18888888888','::1','2020-02-04 13:02:59'),
	(14,'18888888888','::1','2020-02-04 13:18:22'),
	(15,'18888888888','::1','2020-02-04 15:16:27'),
	(16,'18888888888','::1','2020-02-06 07:32:01'),
	(17,'18888888888','::1','2020-02-10 05:17:14'),
	(18,'18888888888','::1','2020-02-23 04:32:07'),
	(19,'18888888888','::1','2020-02-23 07:20:03'),
	(20,'18888888888','::1','2020-02-23 07:43:48'),
	(21,'18888888888','::1','2020-02-23 07:52:31');

/*!40000 ALTER TABLE `t_log_login_member` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_and_parents
# ------------------------------------------------------------

DROP VIEW IF EXISTS `user_and_parents`;

CREATE TABLE `user_and_parents` (
   `parent3Id` INT(11) NULL DEFAULT '0',
   `parent3Username` VARCHAR(32) NULL DEFAULT NULL,
   `parent3Balance` DECIMAL(14) NULL DEFAULT '0.00',
   `parent2Id` INT(11) NULL DEFAULT '0',
   `parent2Username` VARCHAR(32) NULL DEFAULT NULL,
   `parent2Balance` DECIMAL(14) NULL DEFAULT '0.00',
   `parent1Id` INT(11) NULL DEFAULT '0',
   `parent1Username` VARCHAR(32) NULL DEFAULT NULL,
   `parent1Balance` DECIMAL(14) NULL DEFAULT '0.00',
   `userId` INT(11) NOT NULL DEFAULT '0',
   `username` VARCHAR(32) NULL DEFAULT NULL,
   `balance` DECIMAL(14) NULL DEFAULT '0.00'
) ENGINE=MyISAM;





# Replace placeholder table for current_match_bets with correct view syntax
# ------------------------------------------------------------

DROP TABLE `current_match_bets`;

CREATE ALGORITHM=UNDEFINED DEFINER=`user649`@`localhost` SQL SECURITY DEFINER VIEW `current_match_bets`
AS SELECT
   `b`.`username` AS `username`,count(`b`.`match`) AS `match_count`,
   `b`.`match` AS `match`
FROM (((select `liusijiudb`.`gamebet`.`id` AS `id`,`liusijiudb`.`gamebet`.`game_draw_id` AS `game_draw_id`,`liusijiudb`.`gamebet`.`username` AS `username`,`liusijiudb`.`gamebet`.`bet` AS `bet`,`liusijiudb`.`gamebet`.`bet_amount` AS `bet_amount`,`liusijiudb`.`gamebet`.`bet_amount_currency` AS `bet_amount_currency`,`liusijiudb`.`gamebet`.`match` AS `match`,`liusijiudb`.`gamebet`.`match2` AS `match2`,`liusijiudb`.`gamebet`.`match_bonus` AS `match_bonus`,`liusijiudb`.`gamebet`.`prize` AS `prize`,`liusijiudb`.`gamebet`.`status` AS `status`,`liusijiudb`.`gamebet`.`createdat` AS `createdat`,`liusijiudb`.`gamebet`.`updatedat` AS `updatedat` from `liusijiudb`.`gamebet` where ((`liusijiudb`.`gamebet`.`match` >= 3) and (`liusijiudb`.`gamebet`.`status` = 'COMMITTED')))) `b` join (select `liusijiudb`.`gamedraw`.`draw_id` AS `draw_id`,`liusijiudb`.`gamedraw`.`game_id` AS `game_id`,`liusijiudb`.`gamedraw`.`draw_time` AS `draw_time`,`liusijiudb`.`gamedraw`.`status` AS `status`,`liusijiudb`.`gamedraw`.`draw_result` AS `draw_result`,`liusijiudb`.`gamedraw`.`total_income` AS `total_income`,`liusijiudb`.`gamedraw`.`total_prize_pool` AS `total_prize_pool`,`liusijiudb`.`gamedraw`.`distributed` AS `distributed`,`liusijiudb`.`gamedraw`.`remain_prize` AS `remain_prize`,`liusijiudb`.`gamedraw`.`createdat` AS `createdat`,`liusijiudb`.`gamedraw`.`updatedat` AS `updatedat` from `liusijiudb`.`gamedraw` where (`liusijiudb`.`gamedraw`.`status` = 'Drawn')) `d` on((`b`.`game_draw_id` = `d`.`draw_id`))) group by `b`.`username`,`b`.`match`;


# Replace placeholder table for user_and_parents with correct view syntax
# ------------------------------------------------------------

DROP TABLE `user_and_parents`;

CREATE ALGORITHM=UNDEFINED DEFINER=`user649`@`localhost` SQL SECURITY DEFINER VIEW `user_and_parents`
AS SELECT
   `p`.`id` AS `parent3Id`,
   `p`.`h_userName` AS `parent3Username`,
   `p`.`h_point2` AS `parent3Balance`,
   `s3`.`parent2Id` AS `parent2Id`,
   `s3`.`parent2Username` AS `parent2Username`,
   `s3`.`parent2Balance` AS `parent2Balance`,
   `s3`.`parent1Id` AS `parent1Id`,
   `s3`.`parent1Username` AS `parent1Username`,
   `s3`.`parent1Balance` AS `parent1Balance`,
   `s3`.`userId` AS `userId`,
   `s3`.`username` AS `username`,
   `s3`.`balance` AS `balance`
FROM (((select `p`.`id` AS `parent2Id`,`p`.`h_userName` AS `parent2Username`,`p`.`h_parentUserName` AS `level2_parent_username`,`p`.`h_point2` AS `parent2Balance`,`s2`.`parent1Id` AS `parent1Id`,`s2`.`parent1Username` AS `parent1Username`,`s2`.`parent1Balance` AS `parent1Balance`,`s2`.`userId` AS `userId`,`s2`.`username` AS `username`,`s2`.`balance` AS `balance` from (((select `p`.`id` AS `parent1Id`,`p`.`h_userName` AS `parent1Username`,`p`.`h_parentUserName` AS `level1_parent_username`,`p`.`h_point2` AS `parent1Balance`,`s`.`id` AS `userId`,`s`.`h_userName` AS `username`,`s`.`balance` AS `balance` from (((select `liusijiudb`.`h_member`.`id` AS `id`,`liusijiudb`.`h_member`.`h_userName` AS `h_userName`,`liusijiudb`.`h_member`.`h_parentUserName` AS `h_parentUsername`,`liusijiudb`.`h_member`.`h_point2` AS `balance` from `liusijiudb`.`h_member`)) `s` left join `liusijiudb`.`h_member` `p` on((`p`.`h_userName` = `s`.`h_parentUsername`))))) `s2` left join `liusijiudb`.`h_member` `p` on((`p`.`h_userName` = `s2`.`level1_parent_username`))))) `s3` left join `liusijiudb`.`h_member` `p` on((`p`.`h_userName` = `s3`.`level2_parent_username`)));

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
