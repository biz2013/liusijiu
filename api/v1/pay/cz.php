<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/conn.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/webConfig.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/api_util.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/member/logged_data.php';

if ($_SERVER['REQUEST_METHOD'] != 'POST') {
    return create_json_response("ERROR_BAD_METHOD", "系统只接受POST请求");  
}

$json = file_get_contents('php://input');
$data = json_decode($json);
$total_fee = $data['amount']*100;
$username = $data['username'];
$pay = new pay($api_key, $api_secret, $tradesite);
$out_trade_no = date('YmdHis').rand(100000,999999);
$notify_url = $TRADE_NOTIFY_URL;
$return_url = $TRADE_RETURN_URL;
$config['notify_url'] = $notify_url;
$config['return_url'] = $return_url;

$config['out_trade_no'] = $out_trade_no;
$config['subject'] = '游戏网站客户' . $username . '请求充值' . $amount . '加元';
$config['total_fee'] = $total_fee;
$config['attach'] = 'username=' . $username;

try {
    $data  = $pay->applypurchase($config, 'paypal');
    error_log(isset($data)? 'return data is ' . $data['return_code']: 'not returned from applypurchase');
    if ($data['return_code']=='FAIL') {
        error_log('return code say failed');
        $error_msg = '';
        if ($data['return_msg'] === '请您等您正在处理的充值购买请求被确认后再发新的请求') {
            $error_msg = '您还有未处理的充值，如已付款请耐心等待，如未付款请到充值记录里点记录后的【等待审核】链接，继续完成支付';
        } else {
            $error_msg = '充值错误: ' . $data['return_msg'];
        }
        create_json_response("FAIL", $error_msg, 503);
        return;

    }elseif ($data['return_code']=='SUCCESS') {
        if ($data['api_out_trade_no'] != $out_trade_no) {
            $error_msg = 'Data mismatch: api_out_trade_no ' . $data['api_out_trade_no'] . ' does not match original out_trade_no ' . $out_trade_no;
            error_log($error_msg);
            create_json_response("FAIL", $error_msg, 503);
            return;
        }
        $payment_url = array_key_exists('payment_url', $data)? $data['payment_url'] : "";
        $trx_bill_no = $data['orderID'];
        error_log('chongzhi: Call to applypurchase return code say succeeded, create purchase record');
        //记录充值记录
        $sql = "insert into `order` set ";
        $sql .= "username = '" . $username . "', ";
        $sql .= "out_trade_no = '{$out_trade_no}', ";
        $sql .= "subject = '{$subject}', ";
        $sql .= "total_fee = " . $amount . ", ";
        $sql .= "trx_bill_no = '" . $trx_bill_no . "',";
        $sql .= "submit_time = '" . date('Y-m-d H:i:s') . "', ";
        $sql .= "ip = '" . getUserIP() . "' ";
        error_log($sql);
        $db->query($sql);

        $pay_time = date('Y-m-d H:i:s');
        $sql = "insert into `h_recharge` set ";
        $sql .= "h_userName = '{$username}', ";
        $sql .= "h_money = '{$amount}', ";
        //	$sql .= "h_fee = '" . ($num * $webInfo['h_withdrawFee']) . "', ";
        $sql .= "h_bank = 0, ";
        $sql .= "h_bankFullname = 'out_trade_no:{$out_trade_no}', ";
        $sql .= "h_state = 0, h_isReturn=0, ";
        $sql .= "h_addTime = '{$pay_time}', ";
        $sql .= "out_trade_no = '{$out_trade_no}', ";
        $sql .= "h_actIP = '" . getUserIP() . "' ";
        $rc = $db->query($sql);
        error_log($sql);
    }else {
      error_log('return code say unknow');
      error_log("System return unknown response " . $data['return_code']);
      error_log(VAR_DUMP($data));
      $error_msg = '充值错误: 系统返回不正确的结果: ' . $data['return_code'];
    }

    $resp = new \stdClass();
    $resp->orderID = $data['orderID'];
    $resp->api_out_trade_no = $data['api_out_trade_no'];
    $resp->api_out_trade_no = $data['api_trans_id'];
    header('Content-Type: application/json');
    echo json_encode($resp);

    // return the json
}catch (PayException $pe) {
    $error_msg = '充值错误:' . $pe->getMessage() . ".  请稍后再试.";
    error_log("chongzhi: hit exception " . $pe->getMessage());
    create_json_response("FAIL", $error_msg, 503);
}

?>