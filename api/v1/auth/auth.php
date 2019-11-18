<?php

if ($_SERVER['REQUEST_METHOD'] != 'POST') {
    header("HTTP/1.0 405 Method Not Allowed");
    exit();
}

require_once $_SERVER['DOCUMENT_ROOT'] . '/include/conn.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/webConfig.php';

function login($db, $username, $pwd, $userIP) {
	
	error_log("{$username} is trying to login...");
	if (strlen($username) != 11){
		return '{"state": false,"msg":"玩家编号错误，请检查！"}';
	}
	if (strlen($pwd) < 6 || strlen($pwd) > 32){
		return '{"state":false,"msg":"登录密码6-32位任意字符，请检查！"}';
	}
	
	$rs = $db->get_one("select * from h_member where h_userName = '{$username}'");
	if (!$rs){
		return '{"state":false,"msg":"用户不存在，请检查！"}';
	}

	$pwdhash = md5($pwd);
	if($pwdhash != $rs['h_passWord']){
		return '{"state":false,"msg":"账户或密码错误，请检查!" }';
	}

	if(!$rs['h_isPass']){
		return '{"state":false,"msg":"您的账户未激活，请联系上家激活再登录！"}';
	}

	if($rs['h_isLock']){
		return '{"state":false,"msg":"账户被限制登录！"}';
	}

	try {
		$expire = time() + 60 * 30;
		setcookie("m_username", $rs['h_userName'],$expire,'/');
		setcookie("m_password", $rs['h_passWord'],$expire,'/');
		setcookie("m_fullname", $rs['h_fullName'],NULL,'/');
		setcookie("m_level", $rs['h_level'],NULL,'/');
		setcookie("m_isPass", $rs['h_isPass'],NULL,'/');
		setcookie("m_userId", $rs['id'], NULL, '/');

		$sql = "update `h_member` set ";
		$sql .= "h_lastTime = '" . date('Y-m-d H:i:s') . "', ";
		$sql .= "h_lastIP = '" . $userIP . "', ";
		$sql .= "h_logins = h_logins + 1 ";
		$sql .= "where h_userName = '" . $rs['h_userName'] . "' ";
		error_log("Login update: " . $sql);
		$db->query($sql);

		$sql = "insert into `t_log_login_member` set ";
		$sql .= "h_userName = '" . $rs['h_userName'] . "', ";
		$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
		$sql .= "h_ip = '" . $userIP . "' ";
		error_log("Login logging: " . $sql);
		$db->query($sql);

		return '{"state":true,"msg":"登录成功"}';
	} catch (Throwable $e) {
		return '{"state":false,"msg":"' . $e->getMessage() . '"}';
	}
}

$username = $_POST['username'];
$password = $_POST['password'];
$userIP = getUserIP();
error_log("Login attemp by " . $username . " from " . $userIP);
$result_string = login($db, $username, $password, $userIP);
error_log("Login return " . $result_string);
header('Content-Type: application/json');
echo json_encode($result_string);

?>