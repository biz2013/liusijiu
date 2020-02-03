<?php //Utf-8 encoded
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/conn.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/webConfig.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/pay/pay.php';

header("content-type:text/html;charset=UTF-8");
$exit_str = '';
$raw_input = file_get_contents('php://input');
$log = array(
	'POST'=>$_POST,
	'GET'=>$_GET,
	'REQUEST_URI'=>isset($_SERVER['REQUEST_URI'])?$_SERVER['REQUEST_URI']:'',
	'HTTP_USER_AGENT'=>isset($_SERVER['HTTP_USER_AGENT'])?$_SERVER['HTTP_USER_AGENT']:'',
	'HTTP_RAW_POST_DATA'=>$raw_input,
	'IP'=>getUserIP()
);

$data = json_decode($raw_input,true);
$out_trade_no = isset($data['out_trade_no'])?$data['out_trade_no']:'';
error_log("notify.php: try to find out_trade_no " . $out_trade_no . " trade status " . $data['trade_status']);
if ($out_trade_no === '') exit($exit_str);

try {
    $sql = "insert into `log` set ";
    $sql .= "logtime = '" . date('Y-m-d H:i:s') . "',";
    $sql .= "data = '" . json_encode($log, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK) . "' ";
    error_log("notify.php: about to insert to log" . $sql);
    $db->query($sql);

}catch (Exception $e) {
    error_log("notify.php:  hit exception " . $e->getMessage());
    http_response_code(500);
    echo("Error");
}

//{"POST":[],"GET":[],"REQUEST_URI":"/notify.php","HTTP_USER_AGENT":"python-requests/2.18.4","HTTP_RAW_POST_DATA":"{"out_trade_no": "20180813094351916146", "sign": "36ABA3461FA8135CB5BB1BB348A23002", "trx_bill_no": "API_TX_20180813094354_297943", "api_key": "1K3IO1TXWPOOTE45ASAX1CDYLE3CLKBQ", "payment_provider": "heepay", "received_time": "20180813014406", "trade_status": "Success", "real_fee": 1, "subject": "chongzhi", "from_account": "13910978598", "attach": "username=13800138000", "version": "1.0", "total_amount": 1}","IP":"54.203.195.52"}	

$sql = "select * from `order` where out_trade_no ='{$out_trade_no}'  LIMIT 1";
error_log("notify.php: get order " . $out_trade_no);
$rs = @$db->get_one($sql);

if(!$rs) exit(utf8_encode('not find the order ' . $out_trade_no));
//if($rs['total_fee'] != $data['real_fee']/100) exit('total_fee FAILED');

$trade_status = strtolower($data['trade_status']);
$pay_time = date('Y-m-d H:i:s');
		$sql = "update `order` set ";
		$sql .= "pay_time = '{$pay_time}',";
		$sql .= "trx_bill_no = '{$data['trx_bill_no']}',";
		$sql .= "status = '{$trade_status}' ";
		$sql .= "where out_trade_no = '" .$rs['out_trade_no']."' ";
		error_log("notify.php: about to update status " . $sql);
		@$db->query($sql);

		if($trade_status=='paidsuccess' || $trade_status=='success'){
			if($rs['type']=='recharge' && $rs['status']!='success'){
				$sql = "update `h_member` set  h_point2 = h_point2 + {$rs['total_fee']}  where h_userName = '{$rs['username']}' ";
				@$db->query($sql);
				
				//记录加钱
				$sql = "insert into `h_log_point2` set ";
				$sql .= "h_userName = '{$rs['username']}', ";
				$sql .= "h_price = '{$rs['total_fee']}', ";
				$sql .= "h_type = '充值', ";
				$sql .= "h_about = 'out_trade_no:{$out_trade_no}', ";
				$sql .= "h_addTime = '{$pay_time}', ";
				$sql .= "h_actIP = '{$rs['ip']}' ";
				error_log("notify.php: about to create purchase log point2 to log" . $sql);
				@$db->query($sql);
				//充值记录
				$query = "update `h_recharge` SET h_state = 1,h_isReturn=1,h_addTime = '{$pay_time}' where out_trade_no ='{$rs['out_trade_no']}'";
				error_log("notify.php: about to update recharge " . $sql);
				@$db->query($query);
				
				//充值记录
				/*
				$sql = "insert into `h_recharge` set ";
				$sql .= "h_userName = '{$rs['username']}', ";
				$sql .= "h_money = '{$rs['total_fee']}', ";
			//	$sql .= "h_fee = '" . ($num * $webInfo['h_withdrawFee']) . "', ";
				$sql .= "h_bank = '" . $pay . "', ";
				$sql .= "h_bankFullname = 'out_trade_no:{$out_trade_no}', ";
				$sql .= "h_state = 1, h_isReturn=1, ";
				$sql .= "h_addTime = '{$pay_time}', ";
				$sql .= "h_actIP = '{$rs['ip']}' ";
				@$db->query($sql);*/
				
			}elseif($rs['type']=='withdraw'){
				//提现
				$query = "update `h_withdraw` SET h_state = '已打款' where out_trade_no ='{$rs['out_trade_no']}'";

				@$db->query($query);
			}
		}elseif ($trade_status=='badreceiveaccount' || $trade_status == 'userabandon') {
			if ($rs['type'] == 'recharge') {
				$sql = "update `h_recharge` Set h_state=2 where out_trade_no='{$rs['out_trade_no']}'";
				@$db->query($sql);
				error_log("notify.php: cancel recharge record for order {$rs['out_trade_no']} with `{$sql}`");
			} elseif ($rs['type']=='withdraw'){
				//提现失败
				$query = "update `h_withdraw` SET h_state = '审核失败',h_isReturn = '1' where out_trade_no ='{$rs['out_trade_no']}'";
				@$db->query($query);
				
				//返款
				$sql = "update `h_member` set ";
				$sql .= "h_point2 = h_point2 + {$rs['total_fee']} ";
				$sql .= "where h_userName = '{$rs['username']}' ";
				@$db->query($sql);
				
				//记录加钱
				$sql = "insert into `h_log_point2` set ";
				$sql .= "h_userName = '{$rs['username']}', ";
				$sql .= "h_price = '{$rs['total_fee']}', ";
				$sql .= "h_type = '申请提现', ";
				$sql .= "h_about = '提现失败，原因：网关转账失败', ";
				$sql .= "h_addTime = '{$pay_time}', ";
				$sql .= "h_actIP = '{$rs['ip']}' ";
				@$db->query($sql);
			}
		}
echo(utf8_encode('ok'));
?>
