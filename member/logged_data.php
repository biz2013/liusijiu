<?php
$memberLogged_userName = isset($_COOKIE['m_username'])?$_COOKIE['m_username']:'';
$memberLogged_passWord = isset($_COOKIE['m_password'])?$_COOKIE['m_password']:'';
$memberLogged_fullName = isset($_COOKIE['m_fullname'])?$_COOKIE['m_fullname']:'';
$memberLogged_level = isset($_COOKIE['m_level'])?$_COOKIE['m_level']:'';
$memberLogged_isPass = isset($_COOKIE['m_isPass'])?$_COOKIE['m_isPass']:'';
$memberLogged_userId = isset($_COOKIE['m_userId'])?$_COOKIE['m_userId']:0;

$memberLogged = false;
if(strlen($memberLogged_userName) > 0 && strlen($memberLogged_passWord) > 0){
	$memberLogged = true;
	
	if(!$memberLogged_fullName)
		$memberLogged_fullName = $memberLogged_userName;
}
