<?php

require_once $_SERVER['DOCUMENT_ROOT'] . '/include/mysql.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/entities/GameDraw.php';

class GameDefinition {
    public $id;
    public $name;
    public $prize_config_json;
    public $close_draw_in_min;
    public $balance;
    public $prize_pool;
    public $next_draw_utc;
    public function __constructor() {

    }

    public static function getGame($db, $name) {
        $sql = "select * from `game` where name='" . $name . "'";
        $rs = $db->query($sql);
        if (!$rs) {
            return null;
        }

        $game = new GameDefinition();
        $game->id = $rs['id']; 
        $game->name = $rs['name'];
        $game->prize_config_json = json_encode($rs['prize_config']);
        $game->close_draw_in_min = $rs['bet_close_before_draw_in_min'];
        $game->balance = $rs['balance'];
        $game->prize_pool = $rs['prize_pool'];
        $game->next_draw = $rs['next_draw_utc'];
    }
}
?>