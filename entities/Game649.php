<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/include/conn.php';
require_once $_SERVER['DOCUMENT_ROOT'] . '/entities/GameDefinition.php';

class Game649 extends GameDefinition
{
    public $current_draw;
    public $next_draw;

    public function getGame($db) {
        GameDefinition::loadGame($db, '649');
    }

    private function match($draw, $bet) {
        $i = 0; 
        $j = 0;
        $count = 0;
        while ($i< 6 && $j<6) {
            if ($draw[$i] == $bet[$j]) {
                $count = $count + 1;
            } else if ($draw[$i] < $bet[$j]) {
                $i = $i + 1;
            } else {
                $j = $j + 1;
            }
        }
        return $count;
    }

    private function distribute4matches($db, $userIds_matched) {

    }

    private function distribute5matches($db, $userIds_matched_5) {

    }

    private function distribute6matches($db, $userIds_matched_6) {

    }

    private function getParents($db, $userIds) {

    }

    private function distributeFixReward($db, $count, $reward) {
        $sql = "select * from current_match_bet where match=" . $count;
        error_log("Game649::distributeFixReward(): " . $sql);
        $rs = $db->query($sql);
        while($list = $db->fetch_array($result))
        {
            $sql = "update h_member set reward = reward + " . ($reward * $list['match_count']);
            $sql = $sql . " where h_username='" . $list['username'] . "'";
            error_log("Game649::distributeFixReward: " . $sql);
            $db->query($sql);
            //TODO: add logger record
        }
    }

    private function distributeReward($db, $count, $total_reward_pool) {
        $sql = "select sum(match_count) as total_winner from current_match_bet where match=" . $count;
        error_log("Game649::distributeFixReward(): " . $sql);
        $rs = $db->query($sql);
        $total_winner = $rs['total_winner'];

        $sql = "select * from current_match_bet where match=" . $count;
        error_log("Game649::distributeFixReward(): " . $sql);
        $rs = $db->query($sql);
        while($list = $db->fetch_array($result))
        {
            $reward = ($total_reward_pool * $list['match_count']) / $total_winner;
            $sql = "update h_member set reward = reward + " . $reward ;
            $sql = $sql . " where h_username='" . $list['username'] . "'";
            error_log("Game649::distributeFixReward: " . $sql);
            $db->query($sql);
            //TODO: add logger record
        }
    }

    public function draw($db, $draw)
    {
        $this->current_draw = $draw;
        $draw_number = $this->current_draw->draw($db);
        $sql = "select * from gamebet where game_draw_id='" . $this->current_draw->id . "'";
        $sql = $sql . " and status='COMMITTED'";
        error_log("Game649::draw(): " . $sql);
        $rs = $db->query($sql);
        $rs_list = array();
        while($list = $db->fetch_array($result))
        {
            $rs_list[]=$list;
        }

        $winners = array(
            "3"=>array(),
            "4"=>array(),
            "5"=>array(),
            "6"=>array()
        );
        $count = 0;
        $count_3 = 0;
        $count_4 = 0;
        $count_5 = 0;
        $count_6 = 0;

        foreach($rs_list as $key=>$val) {
            $bet = json_encode(val['bet']);
            $betId = val['id'];
            $match = $this->match($draw_number, $bet);
            if ($match > 0) {
                $sql = "update gamebet set match=" . $match . " where id=" . $betId;
                error_log("Game649::draw(): " . $sql);
                // handle error ?
                $db->quer($sql);
            }
        }

        $sql = "select count(id) as match3 from gaembet where game_draw_id='" . $this->current_draw->id  . "' and match=3";
        error_log("Game649::draw(): " . $sql);
        $rs = $db->query($sql);
        $count_3 = $rs['match3'];

        $sql = "select count(id) as match4 from gaembet where game_draw_id='" . $this->current_draw->id  . "' and match=4";
        error_log("Game649::draw(): " . $sql);
        $rs = $db->query($sql);
        $count_3 = $rs['match4'];

        $sql = "select count(id) as match5 from gaembet where game_draw_id='" . $this->current_draw->id  . "' and match=5";
        error_log("Game649::draw(): " . $sql);
        $rs = $db->query($sql);
        $count_5 = $rs['match5'];

        $sql = "select count(id) as match6 from gaembet where game_draw_id='" . $this->current_draw->id  . "' and match=6";
        error_log("Game649::draw(): " . $sql);
        $rs = $db->query($sql);
        $count_6 = $rs['match6'];

        $distribution_pool = $count * 0.6;
        $this->balance = $this->balance + $count - $distribution_pool;
        $this->prize_pool = $this->prize_pool + $distribution_pool;
        $distribute_3 = $count_3 * 10.0;
        if ($this->prize_pool < $distribute_3) {
            error_log("Game649::draw() match 3 wining of " . $distribute_3 . " is more than the pool of " . $this->prize_pool);
            $this->prize_pool = 0;
        } else {
            $this->prize_pool = $this->prize_pool - $distribute_3;
        }

        $distribution_4 = ($count_4 > 0) ? $this->prize_prize * 0.12 : 0.0;
        $distribution_5 = ($count_5 > 0) ? $this->prize_prize * 0.08 : 0.0;
        $distribution_6 = ($count_6 > 0) ? $this->prize_prize * 0.8 : 0.0;
        $this->prize_pool = $this->prize_pool - $distribution_4 - $distribution_5 - $distribution_6;

        distributeFixReward($db, 3, 10.0);
        distributeReward($db, 4, $distribution_4);
        distributeReward($db, 5, $distribution_5);
        distributeReward($db, 6, $distribution_6);

        $sql = "update game set balance=" . $balance . ", prize_pool=" . $prize_pool . " where id=" . $this->id;
        error_log("Game649::draw() " . $sql);
        $db->query($sql);
    }

    public function bet($user, $draw_id, $bets, $action)
    {
        $sql = "select id, h_point2, locked_balance, available_balance h_lastUpdatedAt from `h_member` where h_userName='" . $user . "'";
        $rs = $db->get_one($sql);
        if (!$rs) {
            throw new GameException("下注用户找不到");
        }

        $uId = $rs['id'];
        $balance = $rs['h_point2'];
        $locked = $rs['locked_balance'];
        $available_balance = $rs['available_balance'];
        $user_lastUpdatedAt = $rs['h_lastUpdatedAt'];
        $db->set_autocommit(FALSE);
        $db->begin_trans();
        try {
            if ($action == "ADD") {
                foreach ($bets as $bet) {
                    $bet = new GameBet();
                    $bet->username = $user;
                    $bet->game_draw_id = $draw_id;
                    $bet->bet = $bet->selection;
                    $bet->status = 'OPEN';
                    $bet->save($db);
                }

                $amount = sizeof($bets);
                $locked = $locked + $amount;
                $balance = $balance - $amount;
                $available_balance = $balance - $amount;
                $sql = "update `h_member` set ";
                $sql = $sql . "h_point2=" . $balance . ",";
                $sql = $sql . "locked_balance=" . $locked . ",";
                $sql = $sql . "available_balance=" . $available_balance . " ";
                $sql = $sql . "where h_userName='" . $user . "' and ";
                $sql = $sql . "h_lastUpdatedAt='" . date("Y-m-d H:i:s.v", $user_lastUpdatedAt);
                error_log("Game649::bet:" . $sql);
                $query = $db->query($sql);
                $rows = $db->row_num($query);
                if ($rows != 1) {
                    error_log("Game649::bet:add bets, update user balance, updated " . $row . " rows");
                    $db->rollback();
                    throw new GameException("下注更新客户余额失败");
                }
            } else if ($action == "DELETE") {
                $amount = 0;
                foreach ($bets as $bet) {
                    $sql = "delete from gamedraw where id=" . $bet->id . " and status='OPEN'";
                    $query = $db->query($sql);
                    $rows = $db->row_num($query);
                    if ($rows != 1) {
                        error_log("Game649::bet:delete bets id " . $bet->id . " deleted " . $row . " rows");
                    } else {
                        $amount = $amount + 1;
                    }
                }
                $locked = $locked - $amount;
                $balance = $balance + $amount;
                $available_balance = $balance + $amount;
                $sql = "update `h_member` set ";
                $sql = $sql . "h_point2=" . $balance . ",";
                $sql = $sql . "locked_balance=" . $locked . ",";
                $sql = $sql . "available_balance=" . $available_balance . " ";
                $sql = $sql . "where h_userName='" . $user . "' and ";
                $sql = $sql . "h_lastUpdatedAt='" . date("Y-m-d H:i:s.v", $user_lastUpdatedAt);
                error_log("Game649::bet:" . $sql);
                $query = $db->query($sql);
                $rows = $db->row_num($query);
                if ($rows != 1) {
                    error_log("Game649::bet:delete bets, update user balance, updated " . $row . " rows");
                    throw new GameException("下注更新客户余额失败");
                }
            } else if ($action =="SUBMIT") {
                $amount = 0;
                foreach ($bets as $bet) {
                    $sql = "update gamedraw set ";
                    $sql = $sql . "set status='COMMITTED' where id=" . $bet->id . " and status='OPEN'";
                    $query = $db->query($sql);
                    $rows = $db->row_num($query);
                    if ($rows != 1) {
                        error_log("Game649::bet:submit bets id " . $bet->id . " submitted " . $row . " rows");
                    } else {
                        $amount = $amount + 1;
                    }
                }

                $locked = $locked - $amount;
                $sql = "update `h_member` set ";
                $sql = $sql . "locked_balance=" . $locked . " ";
                $sql = $sql . "where h_userName='" . $user . "' and ";
                $sql = $sql . "h_lastUpdatedAt='" . date("Y-m-d H:i:s.v", $user_lastUpdatedAt);
                error_log("Game649::bet:" . $sql);
                $query = $db->query($sql);
                $rows = $db->row_num($query);
                if ($rows != 1) {
                    error_log("Game649::bet:submit bets, update user balance, updated " . $row . " rows");
                    throw new GameException("下注更新客户余额失败");
                }

                $sql = "select * from user_and_parents where userId=" . $uId;
                $rs = $db->query($sql);
                if (!$rs) {
                    error_log("Game649::bet:submit bets, cannot find user_and_parents record for user " . $uId . " username " . $user);
                    throw new GameException("下注操作找不到用户推荐人记录");
                }

                if (is_null($rs['parent1Id'])){
                    return;
                }

                $parent1Id = $rs['parent1Id'];
                $parent1Commission = $amount * 0.05;
                $sql = "update `h_member` set";
                $sql = $sql . "h_point2= h_point2 + " . $parent1Commission . ",";
                $sql = $sql . "available_balance = available_balance + " . $parent1Commission . " ";
                $sql = $sql . "where id=" . $parent1Id;
                $rows = $db->row_num($query);
                if ($rows != 1) {
                    error_log("Game649::bet:submit bets, update user parent by " . $row . " rows");
                    throw new GameException("下注更新客户推荐人余额失败");
                }

                if (is_null($rs['parent1Id'])){
                    return;
                }

                $parent2Id = $rs['parent2Id'];
                $parent2Commission = $amount * 0.03;
                $sql = "update `h_member` set";
                $sql = $sql . "h_point2= h_point2 + " . $parent2Commission . ",";
                $sql = $sql . "available_balance = available_balance + " . $parent2Commission . " ";
                $sql = $sql . "where id=" . $parent2Id;
                $rows = $db->row_num($query);
                if ($rows != 1) {
                    error_log("Game649::bet:submit bets, update user parent by " . $row . " rows");
                    throw new GameException("下注更新客户推荐人2余额失败");
                }
                if (is_null($rs['parent1Id'])){
                    return;
                }

                $parent3Id = $rs['parent3Id'];
                $parent3Commission = $amount * 0.02;
                $sql = "update `h_member` set";
                $sql = $sql . "h_point2= h_point2 + " . $parent3Commission . ",";
                $sql = $sql . "available_balance = available_balance + " . $parent3Commission . " ";
                $sql = $sql . "where id=" . $parent3Id;
                $rows = $db->row_num($query);
                if ($rows != 1) {
                    error_log("Game649::bet:submit bets, update user parent by " . $row . " rows");
                    throw new GameException("下注更新客户推荐人3余额失败");
                }

            } else {
                throw new GameException("下注操作非法");
            }
            $db->commit();
            $db->set_autocommit(TRUE);

        } catch (Exception $e){
            error_log("Bet operation hit issue: " . $e->getMessage());
            $db->rollback();
            throw new GameException($e->getMessage());
        }

    }
}

?>