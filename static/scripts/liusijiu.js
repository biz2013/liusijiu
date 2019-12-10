var current_selected = [];
var selection_prefix_text = '您选择的号码: ';
var balance_title = '您的余额: ';
var winning_title = '您的奖金: ';
var userId = '11010';
var mybets = [];

function get_user_info(uId) {
    return {
        "userId": "11111",
        "alias": "张涛",
        "balance": 1000.0,
        "winning": 200,
        "credit": 0,
        "bets": [
            { "id": 45, "selection": [1, 5, 7, 11, 34, 35], "submit_time": 1582837529 },
            { "id": 46, "selection": [33, 34, 40, 41, 43, 46], "submit_time": 1582837529 }
        ]
    };
}

function makebet(sessionId, username, bets) {
    var payload = { "userId": username, "bets": [] }
    bets.forEach(bet => payload.bets.push(bet));
    $.ajax({
        type: "post",
        data: payload,
        url: "/api/v1/game/bet/",
        contentType: 'application/json; charset=utf-8',
        success: function(json, status, jqXHR) {
            var response = JSON.parse(json);
            if (!response.state) {
                $("#errorTitle").text("登陆错误");
                $("#errorBody").text(response.msg);
                $("#errorMessage").modal({ backdrop: "static" });
                return;
            } else {
                refresh_page();
            }
        },
        error: function(json, status, jqXHR) {
            alert("redeem failed " + json.responseText);
        }
    });

}

function show_balance(userInfo) {
    $("#balance").text(balance_title + userInfo.balance);
    $("#winning").text(winning_title + userInfo.winning);
}

function display_current_selection() {
    current_selected.sort(function(a, b) { return a - b });
    var selection = selection_prefix_text + current_selected;
    $("#selection").text(selection);
}

function get_next_draw_info() {
    return { "next_draw_time": 1573934400000, "pool_size": 1000000, "first_prize": 75000 };
}

function show_next_draw_info(info) {
    var draw_date = new Date(0);
    draw_date.setUTCMilliseconds(info.next_draw_time);
    $("#nextdraw").text("下次抽奖时间: " + draw_date.toLocaleString('zh-CN'));
    //$("#prize").text("现有奖金: " + info.first_prize);
}

function show_mybets(bets) {
    if (bets === undefined || bets.length == 0) {
        console.log("show_mybets encounter empty bets array");
        return;
    }

    bets.forEach(item => $("#mybets tbody").append("<tr><td>" + item.selection + "</td></tr>"));
}

function select_number(num) {
    var pos = current_selected.indexOf(num);
    if (pos > -1) {
        current_selected.splice(pos, 1);
        display_selected_number(num, false);
    } else {
        if (current_selected.length < 6) {
            current_selected.push(num);
            current_selected.sort();
            display_selected_number(num, true);
        }
    }
    display_current_selection();
}

function display_selected_number(num, highlight) {
    if (highlight) {
        $("#block" + num).css('background', 'green');
        $("#block" + num + ' a').css('color', 'white');
    } else {
        $("#block" + num).css('background', 'white');
        $("#block" + num + ' a').css('color', '#0066CC');;
    }
}

function refresh_page() {
    userInfo = get_user_info();
    show_balance(userInfo);
    show_next_draw_info(get_next_draw_info());
    display_current_selection();
    show_mybets(userInfo.bets)

}
$(document).ready(function() {
    refresh_page();
});