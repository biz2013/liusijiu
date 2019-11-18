<?php
function web_top_main_menu()
{
	global $db;
	$location = '网站主栏目';
	$query = "select * from `h_menu` where h_location = '$location' and h_isPass = 1 order by h_order asc,id asc";
	$result = $db->query($query);
	while($list = $db->fetch_array($result))
	{
		$rs_list[]=$list;
	}
	
	$ci = 0;
	foreach ($rs_list as $key=>$val)
	{
		$ci++;
		
		if($val['h_type'] == 'link')
		{
			echo '<li>';
			echo '<a href="' . $val['h_href'] . '" target="' . $val['h_target'] . '" id="menu_' . $ci . '">' . $val['h_title']. '</a>';
			echo '</li>';
		}
		else
		{
			echo '<li>';
			echo '<a href="' . create_page_url_htaccess_or_not('menu',$val['h_type'],$val['id'],$val['h_pageKey'],0,'',0,'') . '" id="menu_' . $ci . '">' . $val['h_title'] . '</a>';
			echo "</li>";
		}
	}
}

function web_left_sub_menu($mType,$mid,$mPageKey,$mTitle,$cid,$cPageKey)
{
	global $db;

	switch($mType)
	{
		case 'articles':
		case 'pics':
			$urlType = 'detail';
			$sql = 'select id,h_title,h_pageKey from `h_article` where h_menuId = ' . $mid . ' order by h_order asc,id asc';
			break;
		case 'news':
		case 'album':
		case 'photos':
			$urlType = 'category';
			$sql = 'select id,h_title,h_pageKey from `h_category` where h_menuId = ' . $mid . ' order by h_order asc,id asc';
			break;
		default:
			return;
	}
	$result = $db->query($sql);
	while($list = $db->fetch_array($result))
	{
		$rs_list[]=$list;
	}
	
	if(count($rs_list) > 0)
	{
		echo '<div class="lBox">';
		echo '	<div class="t"><span class="l">' . $mTitle . '</span></div>';
		echo '	<div class="clear"></div>';
		echo '	<div class="i list">';

		foreach ($rs_list as $key=>$val)
		{
			if($urlType == 'detail')
				echo '<a href="' . create_page_url_htaccess_or_not($urlType,$mType,$mid,$mPageKey,$cid,$cPageKey,$val['id'],$val['h_pageKey']) . '">' . $val['h_title'] . '</a>';
			else
				echo '<a href="' . create_page_url_htaccess_or_not($urlType,$mType,$mid,$mPageKey,$val['id'],$val['h_pageKey'],0,'') . '">' . $val['h_title'] . '</a>';
		}
		
		echo '</div>';
		echo '	<div class="b"></div>';
		echo '</div>';
	}
}

function web_bottom_footer_menu()
{
	global $db;
	$location = '底部栏目';
	$query = "select * from `h_menu` where h_location = '$location' and h_isPass = 1 order by h_order asc,id asc";
	$result = $db->query($query);
	while($list = $db->fetch_array($result))
	{
		$rs_list[]=$list;
	}
	
	$ci = 0;
	if(count($rs_list) > 0)
	{
		foreach ($rs_list as $key=>$val)
		{
			$ci++;
			
			if($ci > 1)
				echo ' | ';

			if($val['h_type'] == 'link')
			{
				echo '<a href="' . $val['h_href'] . '" target="' . $val['h_target'] . '" id="menu_footer_' . $ci . '">' . $val['h_title']. '</a>';
			}
			else
			{
				echo '<a href="' . create_page_url_htaccess_or_not('menu',$val['h_type'],$val['id'],$val['h_pageKey'],0,'',0,'') . '" id="menu_footer_' . $ci . '">' . $val['h_title'] . '</a>';
			}
		}
	}
}

function create_page_url_htaccess_or_not($urlType,$mType,$mid,$mPageKey,$cid,$cPageKey,$id,$iPageKey)
{
	global $rewriteOpen;
	$temp = '';

	if($rewriteOpen == 1)
	{
		$temp = '/' . $mPageKey . '/';
		switch($urlType)
		{
			case 'menu':
				break;
			case 'category':
				if($cPageKey != '')
					$temp .= $cPageKey . '/';
				elseif($cid > 0)
					$temp .= $cid . '/';
					
				break;
			case 'detail':
				//有子分类的，要加上子分类的路径
				switch($mType)
				{
					case 'news':
					case 'album':
					case 'photos':
						if($cPageKey != '')
							$temp .= $cPageKey . '/';
						elseif($cid > 0)
							$temp .= $cid . '/';

						break;
				}
					
				if($iPageKey != '')
					$temp .= $iPageKey . '.html';
				elseif($id > 0)
					$temp .= $id . '.html';
					
				break;
		}
	}
	else
	{
		$temp = '/web/' . $mType . '.php';
		switch($urlType)
		{
			case 'menu':
				$temp .= '?mkey=' . $mPageKey;
					
				break;
			case 'category':
				if($cPageKey != '')
					$temp .= '?ckey=' . $cPageKey;
				elseif($cid > 0)
					$temp .= '?cid=' . $cid;
					
				break;
			case 'detail':
				if($iPageKey != '')
					$temp .= '?ikey=' . $iPageKey;
				elseif($id > 0)
					$temp .= '?id=' . $id;
					
				break;
		}
	}
	
	return $temp;
}

function web_create_record_and_url_for_pic($isLink,$href,$target,$id,$title,$img,$pageKey,$cTarget,$mType,$mid,$mPageKey,$cid,$cPageKey,$shortNum,$w,$h,$pageUrl = '')
{
	if($isLink == 1)
	{
		$href_ = $href;
		$target_ = $target;
	}
	else
	{
		$href_ = create_page_url_htaccess_or_not('detail',$mType,$mid,$mPageKey,$cid,$cPageKey,$id,$pageKey);
		$target_ = $cTarget;
	}

	echo '<div class="pic">';
		echo '<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td valign="middle" align="center" class="i">';
			echo '<a href="' . $pageUrl . '" target="' . $target_ . '">';
			echo '<img src="' . $img . '" alt="' . $title . '" onload="imgSizeReSet(this,' . $w . ',' . $h . ')" />';
			echo '</a>';
		echo '</td></tr></table>';
		echo '<div class="t">';
			echo '<a href="' . $pageUrl . '" target="' . $target_ . '">';
			if($shortNum > 0)
				echo shortStringCn($title,$shortNum);
			else
				echo $title;
			echo '</a>';
		echo '</div>';
	echo '</div>';
}

function web_create_record_and_url_for_news($isLink,$href,$target,$id,$title,$pageKey,$time,$cTarget,$mType,$mid,$mPageKey,$cid,$cPageKey,$shortNum)
{
	if($isLink == 1)
	{
		$href_ = $href;
		$target_ = $target;
	}
	else
	{
		$href_ = create_page_url_htaccess_or_not('detail',$mType,$mid,$mPageKey,$cid,$cPageKey,$id,$pageKey);
		$target_ = $cTarget;
	}

	echo '<a href="' . $href_ . '" target="' . $target_ . '">';
	if($shortNum > 0)
		echo shortStringCn($title,$shortNum);
	else
		echo $title;
	if($time != ''){echo '<span>' . $time . '</span>';}
	echo '</a>';
}

function replace_menu_type_key_to_name($key)
{
	$temp = $key;
	$temp = replace($temp,'articles','无子分类，多篇文章');
	$temp = replace($temp,'article','一篇文章');
	$temp = replace($temp,'news','有子分类，多篇文章');
	$temp = replace($temp,'pics','无子分类，多张图片');
	$temp = replace($temp,'album','有子分类，多张图片');
	$temp = replace($temp,'imgs','无子分类，多张纯图片');
	$temp = replace($temp,'photos','有子分类，多张纯图片');
	$temp = replace($temp,'links','友情链接');
	$temp = replace($temp,'link','外部链接');
	return $temp;
}

function get_member_level_name($rsOrLevel){
	if(is_array($rsOrLevel)){
		$level = $rsOrLevel['h_level'];
	}else{
		$level = $rsOrLevel;
	}
	$level = intval($level);
	$levelName = 'VIP';
	if($level > 0){
		$levelName = 'VIP' . $level;
	}

	return $levelName;
}

function get_member_level_span($rsOrLevel){
	if(is_array($rsOrLevel)){
		$level = $rsOrLevel['h_level'];
	}else{
		$level = $rsOrLevel;
	}
	$level = intval($level);
	if($level <= 0){
		$html = '<span class="label label-default">VIP</span>';
	}else{
		$html = '<span class="label label-danger">VIP' . $level . '</span>';
	}

	return $html;
}

function get_member_level_selector($selId,$rsOrLevel){
	if(is_array($rsOrLevel)){
		$level = $rsOrLevel['h_level'];
	}else{
		$level = $rsOrLevel;
	}
	$level = intval($level);
	
	$html = '<select name="' . $selId . '" id="' . $selId . '">';
	$html .= '<option value="">-=VIP等级=-</option>';
	for($ci = 0;$ci <= 4;$ci++){
		$html .= '<option value="' . $ci . '"';
		if($level == $ci){
			$html .= ' selected="selected"';
		}
		$html .= '>VIP';
		if($ci > 0){
			$html .= $ci;
		}
		$html .= '</option>';
	}
    $html .= '</select>';

	return $html;
}

//会员购买物品时的提成，5级
/*
function bonus_farm_buy($buyUserName,$buyMoney,$currUserName,$floorIndex = 1){
	global $db;
	
	if($floorIndex > 5){
		return;
	}
	
	//奖金
	$bonus = floatval($buyMoney) * floatval($webInfo['h_point2Com' . $floorIndex]);
	
	$rs = $db->get_one("select * from `h_member` where h_userName = '{$currUserName}'");
	//会员存在
	if($rs){
		//推荐人存在，结算给推荐人
		if(strlen($rs['h_parentUserName']) > 0){
			//奖金 > 0 才发放和记录
			if($bonus > 0){
				//加款
				$sql = "update `h_member` set ";
				$sql .= "h_point2 = h_point2 + ({$bonus}) ";
				$sql .= "where h_userName = '" . $rs['h_parentUserName'] . "' ";
				$db->query($sql);
				
				//记录
				$sql = "insert into `h_log_point2` set ";
				$sql .= "h_userName = '" . $rs['h_parentUserName'] . "', ";
				$sql .= "h_price = '" . $bonus . "', ";
				$sql .= "h_type = '分红分红', ";
				$sql .= "h_about = '" . $rs_list['h_title'] . "，数量：" . $goodsIN[$rs_list['id']] . "', ";
				$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
				$sql .= "h_actIP = '" . getUserIP() . "' ";
				$db->query($sql);
			}
			
			//下一轮
			bonus_farm_buy($buyUserName,$buyMoney,$rs['h_parentUserName'],$floorIndex + 1);
		}
	}
}
*/

//结算会员的分红
function settle_farm_day($userName){
	global $db;
        error_log("settle_farm_day(" . $userName . ")");	
	$bonusAll = 0;
	$now = date('Y-m-d H:i:s');
	
	$sql = "select * from `h_member_farm` where h_userName = '{$userName}' and h_isEnd = 0 and timestampdiff(hour,h_addTime,sysdate() + interval 8 hour) >= 23 and (timestampdiff(hour, h_lastSettleTime,sysdate() + interval 8 hour) > 0 or h_lastSettleTime is null)";
	$query = $db->query($sql);
	//遍历
	while($rs = $db->fetch_array($query)){
		//计算上次结算与今天的时间差（天数）
		//如果上次未结算，默认为购买时便已结算（虚拟
		if(is_null($rs['h_lastSettleTime'])){
			$rs['h_lastSettleTime'] = $rs['h_addTime'];
		}
                $currentTime = time();
		$dateDiffDay = FDateDiff0($rs['h_lastSettleTime'], $currentTime+3600,'d');
		
		//剩余需要结算的天数
		$ShengYuDay = $rs['h_life'] - $rs['h_settleLen'];//剩余生存天数
		
		if($dateDiffDay > 0 && $dateDiffDay <= $ShengYuDay){
		  $mustSettleDay = $dateDiffDay;	
		}elseif($dateDiffDay > 0 && $dateDiffDay > $ShengYuDay){
		  $mustSettleDay = $ShengYuDay;
		}else{
		  $mustSettleDay = 1;
		}
 
		// remember which farm purchase that this settlement is about
                $farmId = $rs['id'];
                error_log("Settle for " . $userName . ": farmId=>" . $farmId . " lastSettleTime=>" . $rs['h_lastSettleTime'] . " " . $rs['h_life'] . "/" . $rs['h_settleLen'] . " mustSettleDay=>" . $mustSettleDay);
		if($mustSettleDay > 0){
                        error_log("Settle for " . $userName . " has something to settle...");
			//是否死亡
			if(($mustSettleDay + $rs['h_settleLen']) >= $rs['h_life']){
                                error_log("Settle for " . $userName . " 出局返利");
				$isEnd = 1;
				//出局返利
				$rebate = $rs['h_num'] * $rs['h_money'];
				
				//加款
				$sql = "update `h_member` set ";
				$sql .= "h_point2 = h_point2 + ({$rebate}) ";
				$sql .= "where h_userName = '" . $userName . "' ";
				$db->query($sql);
				
				//记录
				$sql = "insert into `h_log_point2` set ";
				$sql .= "h_userName = '" . $userName . "', ";
				$sql .= "h_price = '" . $rebate . "', ";
				$sql .= "h_type = '出局返利', ";
				$sql .= "h_about = '{$rs['h_title']} 出局返利', ";
				$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
                                $sql .= "h_member_farm_id = " . $farmId . ", ";
                                $sql .= "h_additional_info = 'settle_farm_day()', ";
				$sql .= "h_actIP = '" . getUserIP() . "' ";
				$db->query($sql);
			}else{
                                error_log("Settle for " . $userName . "计算购买的矿机" . $farmId . "的每日利息");
				$isEnd = 0;
			
				//需要结算的元
			   	$mustSettleMoney = $mustSettleDay * $rs['h_point2Day'] * intval($rs['h_num']);
			
                        	//记录
                        	$sql = "insert into `h_log_point2` set ";
                        	$sql .= "h_userName = '" . $userName . "', ";
                        	$sql .= "h_price = '" . $mustSettleMoney . "', ";
                        	$sql .= "h_type = '计算每个购买的矿机每日利息', ";
                        	$sql .= "h_about = '{$rs['h_title']} 计算每个购买的矿机每日利息', ";
                        	$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
                        	$sql .= "h_member_farm_id = " . $farmId . ", ";
                        	$sql .= "h_additional_info = 'settle_farm_day()', ";
                        	$sql .= "h_actIP = '" . getUserIP() . "' ";
				//累加，最后一次性发放
				$bonusAll += $mustSettleMoney;
		        }	
			//更新为已发放
			$sql = "update `h_member_farm` set h_settleLen = h_settleLen + ({$mustSettleDay}),h_lastSettleTime = '{$now}',h_isEnd = '{$isEnd}' where id = '{$rs['id']}'";
			$db->query($sql);
		}
	
		//echo $rs['h_lastSettleTime'] . '|';
		//echo $dateDiffDay . '|';
		//echo $mustSettleDay . '|';
		//echo $mustSettleMoney . '|';
		//echo $isEnd . '|';
		//echo '<br />';
	}
	
	//echo '总额：';
	//echo $bonusAll . '|';
	//echo '<br />';
	
	//一次性发放
	if($bonusAll > 0){
		//加款
		$sql = "update `h_member` set ";
		$sql .= "h_point2 = h_point2 + ({$bonusAll}) ";
		$sql .= "where h_userName = '" . $userName . "' ";
		$db->query($sql);
		
		//记录
		$sql = "insert into `h_log_point2` set ";
		$sql .= "h_userName = '" . $userName . "', ";
		$sql .= "h_price = '" . $bonusAll . "', ";
		$sql .= "h_type = '分红', ";
		$sql .= "h_about = '每日分红，下次分红24小时到账', ";
		$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
		$sql .= "h_actIP = '" . getUserIP() . "' ";
		$db->query($sql);
		
		//发放奖金
		bonus_farm_day($userName,$bonusAll,$userName);
	}
}

//结算直推奖，3+无限级
function settle_farm_ztj($buyUserName,$bonusAll,$floorIndex = 2){
	global $db;
	global $webInfo;
	//奖金
	if($floorIndex<=4){
		$bonus = floatval($bonusAll) * floatval($webInfo['h_point'. $floorIndex.'ComBuy']);
	}else{
		$bonus = floatval($bonusAll) * floatval($webInfo['h_point5ComBuy']);
	}
	$rs = $db->get_one("select * from `h_member` where h_userName = '{$buyUserName}'");
	//会员存在
	if($rs){
		//推荐人存在，结算给推荐人
		if(strlen($rs['h_parentUserName']) > 0){
			//奖金 > 0 才发放和记录
			if($bonus > 0){
				//加款
				$sql = "update `h_member` set ";
				$sql .= "h_point2 = h_point2 + ({$bonus}) ";
				$sql .= "where h_userName = '" . $rs['h_parentUserName'] . "' ";
				$db->query($sql);
				
			//记录
				$sql = "insert into `h_log_point2` set ";
				$sql .= "h_userName = '" . $rs['h_parentUserName'] . "', ";
				$sql .= "h_price = '" . $bonus . "', ";
				$sql .= "h_type = '奖励', ";
				$sql .= "h_about = '第" . $floorIndex-1 . "代会员" . $buyUserName . "下级下单获得直推奖收入', ";
				$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
				$sql .= "h_actIP = '" . getUserIP() . "' ";
				$db->query($sql);
				//echo $sql . '<br />';
			}
			//下一轮
			bonus_farm_day($rs['h_parentUserName'],$bonusAll,$floorIndex + 1);
		}
	}
	
}




//会员分红时的提成，8级
function bonus_farm_day($buyUserName,$bonusAll,$currUserName,$floorIndex = 1){
	global $db;
	global $webInfo;
	
	if($floorIndex > 3){
		return;
	}
	
	//奖金
	$bonus = floatval($bonusAll) * floatval($webInfo['h_point2Com' . $floorIndex]);
	
	$rs = $db->get_one("select * from `h_member` where h_userName = '{$currUserName}'");
	//会员存在
	if($rs){
		//推荐人存在，结算给推荐人
		if(strlen($rs['h_parentUserName']) > 0){
			//奖金 > 0 才发放和记录
			if($bonus > 0){
				//加款
				$sql = "update `h_member` set ";
				$sql .= "h_point2 = h_point2 + ({$bonus}) ";
				$sql .= "where h_userName = '" . $rs['h_parentUserName'] . "' ";
				$db->query($sql);
				
			//记录
				$sql = "insert into `h_log_point2` set ";
				$sql .= "h_userName = '" . $rs['h_parentUserName'] . "', ";
				$sql .= "h_price = '" . $bonus . "', ";
				$sql .= "h_type = '动态奖励', ";
				$sql .= "h_about = '第" . $floorIndex . "代会员" . $buyUserName . "下级下单获得提成收入', ";
				$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
				$sql .= "h_actIP = '" . getUserIP() . "' ";
				$db->query($sql);
				//echo $sql . '<br />';
			}
			
			//下一轮
			bonus_farm_day($buyUserName,$bonusAll,$rs['h_parentUserName'],$floorIndex + 1);
		}
	}
}

//检测其上家是否达到升级的条件
function member_chk_update_level($actParentMember){
	global $db;
	global $webInfo;
	
	$temp = false;
	
	$sql = "select *";
	$sql .= ",(select count(id) from `h_member` where h_parentUserName = a.h_userName and h_isPass = 1) as comMembers";
	$sql .= " from `h_member` a where h_userName = '{$actParentMember}' LIMIT 1";
	$rs = $db->get_one($sql);
	$upToLevel = 0;
	if($rs){
		for($ci = 1;$ci <= 4;$ci++){
			if($rs['comMembers'] >= $webInfo['h_levelUpTo' . $ci]){
				$upToLevel = $ci;
			}
		}
		
		if($upToLevel > $rs['h_level']){
			//需要升级
			$sql = "update `h_member` set ";
			$sql .= "h_level = {$upToLevel} ";
			$sql .= "where h_userName = '{$actParentMember}' ";
			$db->query($sql);
			
			$temp = true;
		}
	}
	
	return $temp;
}

//注册赠送
function bonus_member_reg($regUserName,$parentUserName){
	global $db;
	global $webInfo;
	
	if($webInfo['h_point2ComReg'] > 0){
		$bonus = $webInfo['h_point2ComReg'];
		
		//加款
		$sql = "update `h_member` set ";
		$sql .= "h_point2 = h_point2 + ({$bonus}) ";
		$sql .= "where h_userName = '" . $parentUserName . "' ";
		$db->query($sql);
		
		//记录
		$sql = "insert into `h_log_point2` set ";
		$sql .= "h_userName = '" . $parentUserName . "', ";
		$sql .= "h_price = '" . $bonus . "', ";
		$sql .= "h_type = '直接推荐奖', ";
		$sql .= "h_about = '直接推荐会员" . $regUserName . "注册', ";
		$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
		$sql .= "h_actIP = '" . getUserIP() . "' ";
		$db->query($sql);
		//echo $sql . '<br />';
	}
}

//激活会员时，其上家得到奖励
function bonus_member_act($regUserName,$parentUserName){
	global $db;
	global $webInfo;
	
	if($webInfo['h_point2ComRegAct'] > 0){
		$bonus = $webInfo['h_point2ComRegAct'];
		
		//加款
		$sql = "update `h_member` set ";
		$sql .= "h_point2 = h_point2 + ({$bonus}) ";
		$sql .= "where h_userName = '" . $parentUserName . "' ";
		$db->query($sql);
		
		//记录
		$sql = "insert into `h_log_point2` set ";
		$sql .= "h_userName = '" . $parentUserName . "', ";
		$sql .= "h_price = '" . $bonus . "', ";
		$sql .= "h_type = '直荐激活奖', ";
		$sql .= "h_about = '直接推荐的会员" . $regUserName . "激活', ";
		$sql .= "h_addTime = '" . date('Y-m-d H:i:s') . "', ";
		$sql .= "h_actIP = '" . getUserIP() . "' ";
		$db->query($sql);
		//echo $sql . '<br />';
	}
}
