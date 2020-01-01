<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/conn.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/webConfig.php';

$pageTitle = '推广海报—';

require_once 'inc_header.php';
?>
<?php
$sql = "select *";
$sql .= ",(select count(id) from `h_member` where h_parentUserName = a.h_userName and h_isPass = 1) as comMembers";
$sql .= ",(select sum(h_price) from `h_log_point2` where h_userName = a.h_userName and h_price > 0) as point2sum";
$sql .= " from `h_member` a where h_userName = '{$memberLogged_userName}' LIMIT 1";
$rs = $db->get_one($sql);
?>
<div class="a_text">
	<div class="box">
    <?php
        $url = GetUrl(1) . '/member/reg.php?t=' . $rs['h_userName'];
	?>
<p></p>
	<p>二维码海报(截图或长按保存到手机)：</p>
	<img src="/images/ewm/<?php echo md5($url);?>.png" width="100%"/>
 <div>点击复制以下链接:</div>
            <div style="border: 1px solid #e3d1d1;width: 100%;background-color: #eae4e4;
    margin: auto; margin-top: 12px; padding-left: 15px;" >
              
                <textarea name="textarea" id="biao1" style="color: #333;background: none repeat scroll 0 0 #eae4e4;border: 0 none;
     hidden;font-size:14px; width: 100%;
    outline: none;" onclick="this.select();"><?php
        $url = GetUrl(1) . '/member/reg.php?t=' . $rs['h_userName'];
		echo $url;
	?>
    </textarea>
</div>
    </div>
</div>

<?php
require_once 'inc_footer.php';
?>