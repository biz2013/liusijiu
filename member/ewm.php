<?php
	$url = empty($_REQUEST['url'])?"":$_REQUEST['url'];
	require_once $_SERVER['DOCUMENT_ROOT'] . '/include/phpqrcode/phpqrcode.php';
	
	$img = md5($url) . ".png";
	
	$file = "../images/ewm/$img";
	$bg = "../images/ewm_tg1.png";
	QRcode::png($url,$file,5,20);
	
	$imgs = array(
			'dst' => $bg,
			'src' =>$file
	);
	 
	$im = mergerImg($imgs);
	
	header("Content-type: image/png");
	//$im  = imagecreatefrompng($bg);
	imagepng($im);
	imagedestroy($im);
	
function mergerImg($imgs) {
        list($max_width, $max_height) = getimagesize($imgs['dst']);
        $dests = imagecreatetruecolor($max_width, $max_height);
 
        $dst_im = imagecreatefrompng($imgs['dst']);
 
        imagecopy($dests,$dst_im,0,0,0,0,$max_width,$max_height);
        imagedestroy($dst_im);
 
        $src_im = imagecreatefrompng($imgs['src']);
        $src_info = getimagesize($imgs['src']);
        imagecopy($dests,$src_im,393,$max_height/1.34 - -70,0,0,$src_info[0],$src_info[1]);
        imagedestroy($src_im);
 
        return $dests;
}
?>