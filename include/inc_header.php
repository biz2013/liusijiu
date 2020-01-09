<?php 
require_once $_SERVER['DOCUMENT_ROOT'] . '/member/logged_data.php';
if(!$memberLogged){
	header("Location: /member/login.php");
	exit();
}
$expire = time() + 60 * 30;
setcookie("m_username", $memberLogged_userName,$expire,'/');
setcookie("m_password", $memberLogged_passWord,$expire,'/');

if (!isset($pageTitle)){
  $pageTitle='';
}
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/pager.php';
?><!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0">
<title><?php echo $pageTitle . $webInfo['h_webName'] . ' - ' . '会员中心'; ?></title>
<meta name="keywords" content="<?php echo $webInfo['h_keyword']; ?>" />
<meta name="description" content="<?php echo $webInfo['h_description']; ?>" />
<link rel="stylesheet" href="/ui/css/bootstrap.min.css">


<script type="text/javascript" src="/ui/js/jquery.min.js"></script>
<script type="text/javascript" src="/ui/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/ui/js/bootstrap-confirmation.min.js"></script>
<script type="text/javascript" src="/ui/layer/layer.js"></script>
<script type="text/javascript" src="/ui/js/long.js"></script>
<style>body{ font-size:14px;}</style>
<!--<script type="text/javascript" src="/ui/js/jquery.js"></script>-->
<script type="text/javascript" src="/ui/js/modernizr.custom.js"></script>
<script type="text/javascript" src="/ui/js/jquery.dlmenu.js"></script>
<link href="/res/css/home.css" rel="stylesheet" type="text/css" media="all" />
<link href="/res/css/css.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" type="text/css" href="/res/css/common.css">
<link rel="stylesheet" type="text/css" href="/res/css/style1.css">
<style>
.con_rec li span {
    font-size: 12px;
    line-height: 36px;
    display: inline;
    float: none;
    color: #606060;
}</style>
<!--[if lt IE 9]>
<script src="/ui/js/html5shiv.min.js"></script>
<script src="/ui/js/respond.min.js"></script>
<![endif]-->
<script type="text/javascript">
var browserWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
</script>
</head>
<body style="<?php echo isset($body_style)?$body_style:'';?>">
<!--<div class="top">
	<div class="box">
        <a href="<?php echo isset($back_url)?$back_url:'javascript:window.history.back();';?>" class="return"><img src="/res/picture/return.png"></a>
       <?php
	   $pageTitle = explode('-',$pageTitle);
	   echo $pageTitle[0];?>    
    </div>
</div>-->


<script type="text/javascript">

$(function(){

	$( '#dl-menu' ).dlmenu();

});

</script>
	<script>
    //$(selector).toggle(speed,callback);
    </script>
    <!--LEFT End-->
