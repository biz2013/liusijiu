<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/entities/GameDraw.php';

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    session_start();
    if (!isset($_COOKIE['sessionId'])){
        //return 403 
    }

    try {
        $game = new Game649();
        $game->getGame($db, '649');
        $latest_draw = new GameDraw();
        $latest_draw->getCurrentDraw($db, $game->id);
        $resp = new \stdClass();
        $resp->id = $latest_draw->id;
        $resp->game = new \stdClass();
        $resp->game->id = $game->id;
        $resp->game->name = $game->name;
        $resp->draw_time = $latest_draw->draw_time;
        $resp->status = $latest_draw->status;
        header('Content-Type: application/json');
        http_response_code(200);
        echo json_encode($resp);    

    } catch (GameException $ge) {
        error_log('Failed to find info of current draw:' . $ge->getMessage());
        http_response_code(412);
        echo('你的SESSION已经过时了，需要重新登陆');
    }
    
} else if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    try {
        //TODO: check IP whitelist
        $game = new Game649();
        $game->getGame($db, '649');
        $latest_draw = new GameDraw();
        $latest_draw->getCurrentDraw($db, $game->id);
        if (null == $latest_draw) {
            $draw = new GameDraw();
            $draw->create($db, $game->id);
            $resp = new \stdClass();
            $resp->returnCode = "SUCCEED";
            $resp->returnMsg = "SUCCEED";
            header('Content-Type: application/json');
            http_response_code(200);
            echo json_encode($resp);
        } else {
            http_response_code(409);
            echo('下一次开盘记录已经产生');
        }

    } catch (GameException $ge) {
        error_log('Failed to create next game draw' . $ge->getMessage());
        http_response_code(500);
        echo('产生下一个开盘发生错误:' . $ge->getMessage());
    }
} else if ($_SERVER['REQUEST_METHOD'] == 'PATCH') {
    try {
        $requestBody = file_get_contents('php://input');
        $request = json_encode($requestBody);
        $game = new Game649();
        $game->getGame($db, '649');
        $latest_draw = new GameDraw();
        $draw = $latest_draw->getCurrentDraw($db, $request->game_id);
        if (null == $draw) {
            throw new GameException("Draw Patch: 没有找到当前开盘记录");
        }
        
        if (isset($request->status)) {
            $draw->status = $request->status;
        }
        if (isset($request->result)) {
            $draw->result = $request->result;
        }

        $rows = $draw->update($db);
        if ($rows > 1) {
            http_response_code(404);
            echo("更新" . $draw->id . "结果更新了多于一个记录");
        } else if ($row == 0) {
            http_response_code(404);
            echo('更新开盘记录:' . $draw->id . "不存在或者已经被更新了");
        } else {
            if ($request->status == 'DRAW') {
               $game->draw($db); 
            }
            $resp = new \stdClass();
            $resp->returnCode = "SUCCEED";
            $resp->returnMsg = "SUCCEED";
            header('Content-Type: application/json');
            http_response_code(200);
            echo json_encode($resp);
        }
    } catch (GameException $ge) {
        error_log('Failed to update game draw' . $ge->getMessage());
        http_response_code(500);
        echo('更新开盘记录发生错误:' . $ge->getMessage());

    } catch (Exception $e) {
        error_log('Failed to update game draw' . $e->getMessage());
        http_response_code(500);
        echo('更新开盘记录发生错误:' . $e->getMessage());

    }
} else {

}
?>