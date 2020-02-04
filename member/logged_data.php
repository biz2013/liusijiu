<?php
$memberLogged_userName = isset($_COOKIE['m_username'])?$_COOKIE['m_username']:'';
$memberLogged_fullName = isset($_COOKIE['m_fullname'])?$_COOKIE['m_fullname']:'';
$memberLogged_level = isset($_COOKIE['m_level'])?$_COOKIE['m_level']:'';
$memberLogged_isPass = isset($_COOKIE['m_isPass'])?$_COOKIE['m_isPass']:'';
$memberLogged_userId = isset($_COOKIE['m_userId'])?$_COOKIE['m_userId']:0;

$memberLogged = false;
if(strlen($memberLogged_userName) > 0){
	$memberLogged = true;
	
	if(!$memberLogged_fullName)
		$memberLogged_fullName = $memberLogged_userName;

	$expire = time() + 60 * 30;
	setcookie("m_username", $memberLogged_userName,$expire,'/');
		
}
