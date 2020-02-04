<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<script type="text/javascript" src="/static/scripts/jquery.3.2.1.min.js"></script>
<script type="text/javascript" src="/static/scripts/bootstrap.3.3.7.min.js"></script>
<script type="text/javascript" src="/static/scripts/utils.js"></script>
<link rel="stylesheet" href="/static/css/bootstrap.3.3.7.min.css">
<link rel="stylesheet" href="/static/css/liusijiu.css">

<script type="text/javascript" >
    $(document).ajaxStart(function(){
        $("#wait").css("display", "block");
    });

    $(document).ajaxComplete(function(){
        $("#wait").css("display", "none");
    });

    $(document).ready(function(){
        $("#div_error").hide();
        $("#login_btn").click(function() {
            var username = $("#username").val();
            var password = $("#username").val();
            if (username.trim().length == 0){
                $("#div_error").val("请输入您的玩家号码（您的手机号）");
                return;
            } 
            if (password.trim().length == 0){
                $("#div_error").val("请输入您的密码");
                return;
            }

            if (!checkMobile(username)){
                $("#div_error").val("您的玩家号码需要是手机号");
                return;
            }

            $.ajax({
                type: "post",
                data: $("form#form_login").serialize(),
                url: "/api/v1/auth/auth.php",
                contentType: 'application/x-www-form-urlencoded',
                success: function(json, status, jqXHR){
                    var response = JSON.parse(json);
                    if (!response.state) {
                        $("#errorTitle").text("登陆错误");
                        $("#errorBody").text(response.msg);
                        $("#errorMessage").modal({backdrop: "static"});
                        return;
                    } else {
                        window.location.href = '/games/649.php';
                    }
                },
                error: function(json, status, jqXHR) {
                    alert("login failed " + json.responseText);
                }
            });            
        });
    });
</script>

<body>
<div class="container">
<div class="row center-block ">
    <div id="login-body">
        <div class="row"><h2 class="col-sm-offset-2 col-sm-4" >彩票游戏登陆</h2></div>
        <div class="error" id="div_error"></div>
        <form method="post" class="form-horizontal" id="form_login" action="">
            <input type="hidden" id="csrftoken" name="csrftoken" value=""/>

            <div class="form-group">
                <label class="control-label col-sm-2 requiredField" for="username">登陆名：</label>
                <div class="col-sm-4">
                    <input id="username" type="text" class="form-control" placeholder="用户手机" name="username">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2 requiredField" for="password">密码：</label>
                <div class="col-sm-4">
                    <input type="password" class="form-control" id="password" placeholder="请输入密码" name="password">
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-4">
                    <button type="button" id="login_btn" class="btn btn-primary">登录</button>
                </div>
            </div>

      </form>
    </div>
    <!-- End Message Modal -->
    <?php require_once $_SERVER['DOCUMENT_ROOT'] . '/include/inc_popup_msgbox.php'; ?>
    <div id="wait" style="display:none;width:64px;height:64px; position:absolute;top:50%;left:50%;padding:2px;">
         <img src='/static/images/Loading_blue.gif' width="50" height="50" /><br>处理中</div>
</div>
</body>
</html>