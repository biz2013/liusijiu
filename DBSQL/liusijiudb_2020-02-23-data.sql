# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: liusijiudb
# Generation Time: 2020-02-23 21:36:08 +0000
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



# Dump of table current_match_bets
# ------------------------------------------------------------



# Dump of table game
# ------------------------------------------------------------

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;

INSERT INTO `game` (`id`, `name`, `bet_close_before_draw_in_min`, `prize_config`, `balance`, `prize_pool`, `userIP`, `createdat`, `updatedat`)
VALUES
	(1,'649',10,'{  \"match_rules\": [\n       {   \"match_count\" :  2, \"reward_type\": \"fixed\", \"reward\": 1 },      \n       {   \"match_count\" :  3, \"reward_type\": \"fixed\", \"reward\": 10 },\n       {   \"match_count\" :  4, \"reward_type\": \"ratio\", \"reward\" :  0.08},\n       {   \"match_count\" :  5, \"reward_type\": \"ratio\", \"reward\" :  0.12},\n       {   \"match_count\" :  6, \"reward_type\": \"ratio\", \"reward\" :  0.4},\n   ]\n}',0.00,0.00,'127.0.0.1','2019-12-05 20:55:17','2019-12-05 21:01:52');

/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table gamebet
# ------------------------------------------------------------



# Dump of table gamedraw
# ------------------------------------------------------------



# Dump of table h_admin
# ------------------------------------------------------------



# Dump of table h_api_member
# ------------------------------------------------------------



# Dump of table h_article
# ------------------------------------------------------------



# Dump of table h_category
# ------------------------------------------------------------



# Dump of table h_config
# ------------------------------------------------------------

LOCK TABLES `h_config` WRITE;
/*!40000 ALTER TABLE `h_config` DISABLE KEYS */;

INSERT INTO `h_config` (`id`, `h_webName`, `h_webLogo`, `h_webLogoLogin`, `h_webKeyword`, `h_keyword`, `h_description`, `h_leftContact`, `h_counter`, `h_footer`, `h_rewriteOpen`, `h_point1Member`, `h_point1MemberPoint2`, `h_point2Quit`, `h_withdrawFee`, `h_withdrawMinCom`, `h_withdrawMinMoney`, `h_point2Lottery`, `h_lottery1`, `h_lottery2`, `h_lottery3`, `h_lottery4`, `h_lottery5`, `h_lottery6`, `h_point2Com1`, `h_point2Com2`, `h_point2Com3`, `h_point2Com4`, `h_point2Com5`, `h_point2Com6`, `h_point2Com7`, `h_point2Com8`, `h_point2Com9`, `h_point2Com10`, `h_levelUpTo0`, `h_levelUpTo1`, `h_levelUpTo2`, `h_levelUpTo3`, `h_levelUpTo4`, `h_levelUpTo5`, `h_levelUpTo6`, `h_levelUpTo7`, `h_levelUpTo8`, `h_levelUpTo9`, `h_levelUpTo10`, `h_serviceQQ`, `h_point2ComReg`, `h_point2ComRegAct`, `h_point2ComBuy`, `h_point3ComBuy`, `h_point4ComBuy`, `h_point5ComBuy`, `h_operationMode`, `h_prod_notify_hostname`, `h_test_notify_hostname`, `h_tradeex_hostname`, `h_tradeex_hostport`, `h_tradeex_api_key`, `h_tradeex_api_secret`, `h_tradeex_cnyf_address`, `h_purchase_limit`, `h_redeem_limit`, `h_transfer_cnyf_limit`, `h_is_test_mode`, `h_proxy_api_key`, `h_proxy_api_secret`, `h_next_649_draw_id`, `h_default_paypal_client_id`, `h_tradeex_site_url`, `h_notify_url`, `h_return_url`)
VALUES
	(0,'彩票网站','/static/img/logo.png','649彩票','Lottery, 649, 彩票',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0,0.00,0.00,0.00,0.00,0.00,0.00,0.000,0.000,0.00,0.00,0,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,'NAKI4WASX20FX67SQGLIERCDPPR9VDFX','d821545f0c31a821901ddfe408c8c553','CePqp1uYqM3nsNZqaUdQJWe8awdRsKEhGK',3000,3000,1000,0,NULL,NULL,NULL,'ATXaDkQkUmwqFMtHV3wSzcU3v-I-i7VRyT_aid_leLJj7zozUuuXsRJBpB9tjDp8zKnuKcXJu08BR9ac','http://127.0.0.1:8000','http://localhost:8083/payment/notify.php','http://localhost:8083/game/game.php');

/*!40000 ALTER TABLE `h_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table h_farm_shop
# ------------------------------------------------------------



# Dump of table h_guestbook
# ------------------------------------------------------------



# Dump of table h_log_point1
# ------------------------------------------------------------



# Dump of table h_log_point2
# ------------------------------------------------------------

LOCK TABLES `h_log_point2` WRITE;
/*!40000 ALTER TABLE `h_log_point2` DISABLE KEYS */;

INSERT INTO `h_log_point2` (`id`, `h_userName`, `h_price`, `h_about`, `h_addTime`, `h_actIP`, `h_type`, `h_member_farm_id`, `h_additional_info`)
VALUES
	(1,'18888888888',1000.00,'out_trade_no:20200210055231398786','2020-02-10 05:54:03','::1','充值',NULL,NULL);

/*!40000 ALTER TABLE `h_log_point2` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table h_member
# ------------------------------------------------------------

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



# Dump of table h_member_msg
# ------------------------------------------------------------



# Dump of table h_member_shop_cart
# ------------------------------------------------------------



# Dump of table h_member_shop_order
# ------------------------------------------------------------



# Dump of table h_menu
# ------------------------------------------------------------



# Dump of table h_pay_order
# ------------------------------------------------------------



# Dump of table h_point2_sell
# ------------------------------------------------------------



# Dump of table h_point2_shop
# ------------------------------------------------------------



# Dump of table h_recharge
# ------------------------------------------------------------

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



# Dump of table h_UserWalletExternal
# ------------------------------------------------------------



# Dump of table h_Wallet
# ------------------------------------------------------------



# Dump of table h_withdraw
# ------------------------------------------------------------



# Dump of table log
# ------------------------------------------------------------

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



# Dump of table t_log_login_member
# ------------------------------------------------------------

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
