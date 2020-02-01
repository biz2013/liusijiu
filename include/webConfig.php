<?php
//主要配置数据
$webInfo = $db->get_one("SELECT * FROM `h_config`");
//是否开启伪静态，0为关闭，1为开启
$rewriteOpen = $webInfo['h_rewriteOpen'];
//$rewriteOpen = 0;

//模板编号，/templets/web/ 目录下
$templetsFolder = 'a001';
$templetsSite = 'xxx.com';

//System constants
$DEFAULT_PAYPAL_CLIENT_ID= $webInfo['h_default_paypal_client_id'];
$APIKEY = $webInfo['h_tradeex_api_key'];
$SECRETKEY = $webInfo['h_tradeex_api_secret'];
?>
