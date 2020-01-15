<?php
error_reporting(E_ALL);
ini_set('error_reporting', E_ALL);
ini_set('display_errors',1);

require_once $_SERVER['DOCUMENT_ROOT'] . '/include/conn.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/webConfig.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/member/logged_data.php';

if(strlen($comMember) != 11){
    echo '{"state":false,"msg":"推荐人帐号错误，请检查！"}';
    exit;
}
if(strlen($username) != 11){
    echo '{"state":false,"msg":"玩家编号错误，请检查！"}';
    exit;
}
if(strlen($pwd) < 6 || strlen($pwd) > 32){
    echo '{"state":false,"msg":"登录密码6-32位任意字符，请检查！"}';
    exit;
}
if($pwd != $pwd2){
    echo '{"state":false,"msg":"两次输入的登录密码不一致，请检查！"}';
    exit;
}
if(strlen($pwdII) < 6 || strlen($pwdII) > 32){
    echo '{"state":false,"msg":"资金密码6-32位任意字符，请检查！"}';
    exit;
}
if($pwdII != $pwdII2){
    echo '{"state":false,"msg":"两次输入的资金密码不一致，请检查！"}';
    exit;
}

session_start();
    /* comment out due to uslessness */
/*if($vCode != $_SESSION['code']){
    //echo '{"state":false,"msg":"验证码错误，请检查！"}';
    //exit;
}*/

$rs = $db->get_one("select * from `h_member` where h_userName = '{$comMember}'");
if(!$rs){
    echo '{"state":false,"msg":"您填写的推荐人帐号并不存在，请检查！"}';
    exit;
}

$rs = $db->get_one("select * from `h_member` where h_userName = '{$username}'");
if($rs){
    echo '{"state":false,"msg":"您填写的会员帐号（手机号码）已经存在，请换一个！"}';
    exit;
}

$ucip = getUserIP();
$rs = $db->get_one("select * from `h_member` where h_regIP = '{$ucip}'");
if($rs){
    //echo '{"state":false,"msg":"一个IP只能注册一次！"}';
    //exit;
}
    
$pwd = md5($pwd);
$pwdII = md5($pwdII);

//写入..
$sql = "insert into `h_member` set ";
$sql .= "h_parentUserName = '" . $comMember . "', ";
$sql .= "h_userName = '" . $username . "', ";
$sql .= "h_passWord = '" . $pwd . "', ";
$sql .= "h_passWordII = '" . $pwdII . "', ";
$sql .= "h_level = '4', ";
$sql .= "h_isPass = '1', ";
$sql .= "h_regTime = '" . date('Y-m-d H:i:s') . "', ";
$sql .= "h_regIP = '" . getUserIP() . "' ";
$db->query($sql);

//如果有注册奖励，进行奖励
bonus_member_reg($username,$comMember);

echo '{"state":true,"msg":"您的账户已经注册成功,请牢记您的[玩家编号]和[密码]"}';


?>