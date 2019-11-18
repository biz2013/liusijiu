# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: liusijiudb
# Generation Time: 2019-11-18 05:05:37 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table h_config
# ------------------------------------------------------------

LOCK TABLES `h_config` WRITE;
/*!40000 ALTER TABLE `h_config` DISABLE KEYS */;

INSERT INTO `h_config` (`id`, `h_webName`, `h_webLogo`, `h_webLogoLogin`, `h_webKeyword`, `h_keyword`, `h_description`, `h_leftContact`, `h_counter`, `h_footer`, `h_rewriteOpen`, `h_point1Member`, `h_point1MemberPoint2`, `h_point2Quit`, `h_withdrawFee`, `h_withdrawMinCom`, `h_withdrawMinMoney`, `h_point2Lottery`, `h_lottery1`, `h_lottery2`, `h_lottery3`, `h_lottery4`, `h_lottery5`, `h_lottery6`, `h_point2Com1`, `h_point2Com2`, `h_point2Com3`, `h_point2Com4`, `h_point2Com5`, `h_point2Com6`, `h_point2Com7`, `h_point2Com8`, `h_point2Com9`, `h_point2Com10`, `h_levelUpTo0`, `h_levelUpTo1`, `h_levelUpTo2`, `h_levelUpTo3`, `h_levelUpTo4`, `h_levelUpTo5`, `h_levelUpTo6`, `h_levelUpTo7`, `h_levelUpTo8`, `h_levelUpTo9`, `h_levelUpTo10`, `h_serviceQQ`, `h_point2ComReg`, `h_point2ComRegAct`, `h_point2ComBuy`, `h_point3ComBuy`, `h_point4ComBuy`, `h_point5ComBuy`, `h_operationMode`, `h_prod_notify_hostname`, `h_test_notify_hostname`, `h_prod_tradeex_hostname`, `h_test_tradeex_hostname`, `h_tradeex_api_key`, `h_tradeex_api_secret`, `h_tradeex_cnyf_address`, `h_purchase_limit`, `h_redeem_limit`, `h_transfer_cnyf_limit`, `h_is_test_mode`, `h_proxy_api_key`, `h_proxy_api_secret`)
VALUES
	(0,'彩票网站','/static/img/logo.png','649彩票','Lottery, 649, 彩票',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0.00,0,0,0,0,0,0,0,0,0,0.00,0.00,0.00,0.00,0.00,0.00,0.000,0.000,0.00,0.00,0,0,0,0,0,0,0,0,0,0,0,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'CePqp1uYqM3nsNZqaUdQJWe8awdRsKEhGK',3000,3000,1000,0,NULL,NULL);

/*!40000 ALTER TABLE `h_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table h_member
# ------------------------------------------------------------

LOCK TABLES `h_member` WRITE;
/*!40000 ALTER TABLE `h_member` DISABLE KEYS */;

INSERT INTO `h_member` (`id`, `h_userName`, `h_passWord`, `h_passWordII`, `h_fullName`, `h_sex`, `h_mobile`, `h_qq`, `h_email`, `h_regTime`, `h_regIP`, `h_isPass`, `h_moneyCurr`, `h_parentUserName`, `h_level`, `h_point1`, `h_point2`, `h_lastTime`, `h_lastIP`, `h_alipayUserName`, `h_alipayFullName`, `h_addrAddress`, `h_addrPostcode`, `h_addrFullName`, `h_addrTel`, `h_weixin`, `h_logins`, `h_a1`, `h_q1`, `h_a2`, `h_q2`, `h_a3`, `h_q3`, `h_isLock`, `first_buy`, `h_jifen`, `qrcode`, `h_lastUpdatedAt`, `h_canRedeem`, `h_weixin_qrcode`)
VALUES
	(1,'18888888888','e10adc3949ba59abbe56e057f20f883e','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,NULL,NULL,NULL,'2018-07-30 15:19:18','115.84.97.91',1,0.00,'',4,0.00,3836.14,'2019-11-18 13:03:40','::1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,21,NULL,NULL,NULL,NULL,NULL,NULL,0,0,0,NULL,'2019-11-17 21:03:40',0,NULL);

/*!40000 ALTER TABLE `h_member` ENABLE KEYS */;
UNLOCK TABLES;


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



# Dump of table order
# ------------------------------------------------------------



# Dump of table shoukuanla_order
# ------------------------------------------------------------




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
