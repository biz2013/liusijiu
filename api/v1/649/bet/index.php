<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/entities/Game649.php';

function validate($request) {
    if (!isset($request->gameId)) {
        return "请求没有GameId";
    }

    if (!isset($request->drawId)) {
        return "请求没有DrawId";
    }

    if (!isset($request->username)) {
        return "请求没有用户名";
    }

    if (!isset($request->bets) || sizeof($request->bets)) {
        return "请求没有下注内容";
    }

    foreach($bets as $bet) {
        if (!isset($bet->id)) {
            return "下注没有ID";
        }
        if (!isset($bet->selection)) {
            return "下注没有号码选择";
        }
    }
    if (!isset($request->action)) {
        return "请求没有操作说明";
    }

    return 'OK';
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $requestBody = file_get_contents('php://input');
    $request = json_encode($requestBody);
    $errMsg = validate($request);
    if ($errMsg != 'OK') {
        http_response_code('400');
        echo($errMsg);
        exit();
    }

    $game = new Game649();
    $game->getGame($db);
    $latest_draw = new GameDraw();
    $latest_draw->getCurrentDraw($db, $game->id);
    if ($latest_draw->id != $request->drawId) {
        http_response_code('400');
        echo("下注的开盘号码". $latest_draw->id . "不对");
        exit();
    }
    $game->bet($request->username, $request->drawId, $request->bets, $request->action);
}

?>
