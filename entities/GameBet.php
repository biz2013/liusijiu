<?php

require_once $_SERVER['DOCUMENT_ROOT'] . '/include/mysql.php';

class GameBet {
    public $id;
    public $username;
    public $game_draw_id;
    public $bet;
    public $betAmount;
    public $betAmountCurrency;
    public $lastupdatedat;
    public $matchCount;
    public $matchBonus;
    public $prize;
    public $status;

    public function __constructor() {

    }

    public function save($db) {
        $data = array(
            'username' => $this->username,
            'game_draw_id' => $this->game_draw_id,
            'bet' => $this->bet,
            'bet_amount' => $this->bet_amount,
            'bet_amount_currency' => $this->bet_amount_currency,
            'match' => $this->match,
            'match_bonus' => $this->matchBonus,
            'status' => $this->status,
            'lastupdatedat' => $this->date('Y-m-d H:M:s')
        );

        $this->id = $db->insert($data);

    }

    public static function getBetsByUser($db, $game_draw_id, $username) {
        $sql = "select * from gamebet where game_draw_id ='" . $game_draw_id . "' and username='" . $username . "'";
        $rs = $db->query($sql);
        
        $bets = array();
        while ($row = $rs->fetch_array($rs)) {
            $bet = new GameBet();
            $bet->id = $row['id'];
            $bet->username = $row['username'];
            $bet->game_draw_id = $row['game_draw_id'];
            $bet->bet = $row['bet'];
            $bet->betAmount = $row['bet_amount'];
            $bet->betAmountCurrency = $row['bet_amount_currency'];
            $bet->matchCount = $row['match'];
            $bet->matchBonus = $row['match_bonus'];
            $bet->prize = $row['prize'];
            $bet->status = $row['status'];
            $bet->lastupdatedat = $row['lastupdatedat'];
            array_push($bets, $bet);
        }

        return $bets;
    }

    public static function getAllBets($db, $game_draw_id) {
        $sql = "select * from gamebet where game_draw_id ='" . $game_draw_id . "'";
        $rs = $db->query($sql);
        
        $bets = array();
        while ($row = $rs->fetch_array($rs)) {
            $bet = new GameBet();
            $bet->id = $row['id'];
            $bet->username = $row['username'];
            $bet->game_draw_id = $row['game_draw_id'];
            $bet->bet = $row['bet'];
            $bet->betAmount = $row['bet_amount'];
            $bet->betAmountCurrency = $row['bet_amount_currency'];
            $bet->matchCount = $row['match'];
            $bet->matchBonus = $row['match_bonus'];
            $bet->prize = $row['prize'];
            $bet->status = $row['status'];
            $bet->lastupdatedat = $row['lastupdatedat'];
            array_push($bets, $bet);
        }
        return $bets;
    }

}

?>