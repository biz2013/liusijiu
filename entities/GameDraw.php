<?php

require_once $_SERVER['DOCUMENT_ROOT'] . '/include/mysql.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/games/GameException.php';

class GameDraw {
    public $id;
    public $game_id;
    public $draw_time;
    public $result;
    public $status;
    public $lastupdatedat;

    public function __constructor() {

    }

    private function getNextDrawTime(){
        $now  = new DateTime("now");
        $hour = date('H', $now);
        $min = date('M', $now);
        if ($hour > 18 || ($hour == 18 && $min > 49)) {
            $now=Date('y:m:d', strtotime("+1 days"));
        }

        $now->setTime(18, 49);
        return $now;
    }

    private function make_seed()
    {
        list($usec, $sec) = explode(' ', microtime());
        return $sec + $usec * 1000000;
    }

    private function getNextDrawId() {
        return $now->format('YmdHM') . $this->$game->name;

    }

    public function getCurrentDraw($db, $gameId) {
        $sql = "select draw_id, game_id, name, draw_time, draw_result, lastupdatedat from gamedraw inner join game on gamedraw.game_id=game.id where game_id=" . $gameId . " and status <> 'Closed'";
        error_log("GameDraw::getCurrentDraw(" . $gameId . ": " . $sql);
        $rs = $db->query($sql);
        if (!$rs) {
            return null;
        }

        if ($rs->num_rows > 1) {
            throw new GameException("GameDraw:getCurrentDraw(): There are still " . $rs->num_rows . " draw that is not closed");
        }

        $this->id = $rs['draw_id'];

        $this->game = $rs['game_id'];
        $this->draw_time = $rs['draw_time'];
        $this->result = $rs['draw_result'];
        $this->lastupdatedat = $rs['lastupdatedat'];
        return $this;
    }

    public function create($db, $gameId) {
        $sql = "select cnt=count(*) from gamedraw where status<> 'Closed'";
        $rs = $db->query($sql);

        if ($rs && $rs['cnt'] > 0) {
            throw new GameException("GameDraw:create(): There still " . $rs['cnt'] . " draws not closed");
        }

        $draw = array(
            'draw_id' => $this->getNextDrawId(),
            'game_id' => $gameId,
            'status' => 'NotStarted',
        );

        $db->insert($draw);
        $this->getCurrentDraw($db, $gameId);
        return $this;
    }

    public function update($db) {
        if (!isset($this->status) && isset($this->result)) {
            error_log("GameDraw::update(" . $this->draw_id . "): Nothing to update");
            return;
        }

        $count = 0;
        $sql = "udpate ganmedraw set ";
        if (isset($this->status)) {
            $sql = $sql . "status='" . $this->status . "'";
            $count = $count + 1;
        }
        if (isset($this->result)) {
            if ($count > 0) {
                $sql = $sql . ",";
            }
            $sql = $sql . "result='" . $this->result . "'";
            $count = $count + 1;
        }

        if (isset($this->draw_time)) {
            if ($count > 0) {
                $sql = $sql . ",";
            }
            $sql = $sql . "draw_time='" . $this->draw_time . "'";
            $count = $count + 1;
        }

        $sql = $sql . " where draw_id='" . $this->id . "'";
        $sql = $sql . " and lastupdatedat='" . date('Y-m-d H:i:s.v', $this->lastupdatedat) . "'";
        error_log("GameDraw::update(): " . $sql);
        $db->set_autocommit(FALSE);
        $db->begin_trans();
        $query = $db->query($sql);
        $rows = $db->num_rows($query);
        error_log("GameDraw::update(): update " . $rows . " rows in draw " . $this->id);
        if ($row > 1) {
            error_log("GameDraw:update(): udpated more then one, it is not acceptable!");
            $db->rollback();
            return $row;
        }
        $db->commit();
        $db->set_autocommit(TRUE);

        if ($row == 0) {
            error_log("GameDraw:update(): nothing is updated, maybe id is wrong or someone has updated the record");
        }

        return $row;
    }

    public function draw($db) {
        srand(make_seed());
        $draw_numbers = array();
        for ($i = 0; $i< 6; $i++) {
            array_push($draw_numbers, random_int(1,49));
        }
        $bet_str = "[" . implode(",", $draw_numbers) . "]";
        $sql = "update gamedraw set ";
        $sql = $sql . "set draw_result='" . $bet_str . "' and status='DRAW'";
        $sql = $sql . " where id=" . $this->id;
        error_log("Game649:draw " . $sql);
        $db->query($sql);
        return $draw_number;
    }
}
?>