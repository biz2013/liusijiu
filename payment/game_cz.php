<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/conn.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/webConfig.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/member/logged_data.php';

?>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<script type="text/javascript" src="/static/scripts/jquery.3.2.1.min.js"></script>
<script type="text/javascript" src="/static/scripts/bootstrap.3.3.7.min.js"></script>
<script type="text/javascript" src="/static/scripts/liusijiu.js"></script>
<link rel="stylesheet" href="/static/css/bootstrap.3.3.7.min.css">
<link rel="stylesheet" href="/static/css/liusijiu.css">
<script
        src="https://www.paypal.com/sdk/js?client-id=<?php echo $DEFAULT_PAYPAL_CLIENT_ID;  ?>&currency=CAD&disable-funding=credit,card&debug=true">
</script>
<script language="JavaScript">

var cz_amount = 10;

function create_purchase_request(amount, api_key, api_secret){

}
function throw_if_fetch_error(response) {
  if (!response.ok) {
      throw Error(response.statusText);
  }
  return response;
}

function goback() {
  window.location.href = '/trading/purchase/';
}

function show_paypal_window(amount) {
    cz_amount = amount;
    $("#div_purchase_title").text("充值" + cz_amount + "加元");
    $("#paypal_modal").modal();
}


paypal.Buttons({
  createOrder: function (data, actions) {
    // directly call local api to relay the purchase request
    // to original payment system
    return fetch('/payment/game_cz.php', {
      method: 'POST',
      body: JSON.stringify({
        sessionId: "TBD",
        username: "<?php echo $memberLogged_userName; ?>",
        amount: cz_amount
      })
    }).then(function(res) {
      return throw_if_fetch_error(res)
    }).then(function(res) {
        return res.json();
    }).then(function(data) {
        //console.log(JSON.stringify(data))
        return data.orderID;
    }).catch(error => {
      console.log(error);
      alert("无法生成 PayPal支付， 请稍后再试")
    });
  },

  onApprove: function (data, actions) {
    return actions.order.capture().then(function (details) {
      return fetch('<?php echo $TRADESITE_URL; ?>/trading/paypal/confirm_payment/', {
        method: 'post',
        body: JSON.stringify({
          orderID: data.orderID,
          details: details,
          buy_order_id: details.purchase_units[0].reference_id,
          amount: details.purchase_units[0].amount
        }),
      }).then(function(res) {
        return throw_if_fetch_error(res)
      }).then(function(data) {
        alert("支付成功！")
      }).catch(error => {
        console.log(error);
        alert("无法确认 PayPal支付是否成功，请稍后查看")
      });
    });
  },

  style: {
    layout: 'vertical',
    color: 'gold',
    shape: 'rect',
    label: 'paypal',
    tagline: false
  }
}).render('#paypal-button-container');
</script>

</head>
<body>
<div class="container">
    <div class="row">
        <table class="table" width="50%">
        <tr>
            <td><a href="javascript:show_paypal_window(10);"><img src="/static/images/chip_10_dollar.png" width="120" height="120"/></a></td>
            <td><a href="#"><img src="/static/images/chip_25_dollar.png" width="120" height="120"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><img src="/static/images/chip_50_dollar.png" width="120" height="120"/></a></td>
            <td><a href="#"><img src="/static/images/chip_100_dollar.png" width="120" height="120"/></a></td>
        </tr>
        <tr>
            <td><a href="#"><img src="/static/images/chip_200_dollar.png" width="120" height="120"/></a></td>
            <td>&nbsp;</td>
        </tr>
        </table>
    </div>
</div>

<!-- Modal content-->
<div id="paypal_modal" class="modal modal-sm fade" role="dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 id="purchase-form-label">玩家充值</h4>
        </div>
        <div class="modal-body">
            <div id="div_purchase_title">充值</div>
            <div id="paypal-button-container"></div>
        </div>
    </div>
</div>
</body>

</html>