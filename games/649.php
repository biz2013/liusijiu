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

<body>
<div class="container">
<div class="row">
    <div id="balance"></div> 
</div>
<div class="row">
    <div id="winning"></div> 
</div>
<div class="row">
    <button type="button" class="btn btn-primary">充值</button>
    <button type="button" class="btn btn-primary">提现</button>
</div>

<div class="row">
    <div id="nextdraw"></div>
    <!--<div id="prize"></div>-->
</div>
<div class="row">
    <div id="selection"></div>
    <button type="button" id="btn_bet" class="btn btn-primary">下注（¥1）</button>
    <button type="button" class="btn btn-default">清除当前选择</button>
</div>
<div class="row">
    <div id="block1" class="number_block"><a href="javascript:select_number(1);">1</a></div>
    <div id="block2" class="number_block"><a href="javascript:select_number(2);">2</a></div>
    <div id="block3" class="number_block"><a href="javascript:select_number(3);">3</a></div>
    <div id="block4" class="number_block"><a href="javascript:select_number(4);">4</a></div>
    <div id="block5" class="number_block"><a href="javascript:select_number(5);">5</a></div>
    <div id="block6" class="number_block"><a href="javascript:select_number(6);">6</a></div>
    <div id="block7" class="number_block"><a href="javascript:select_number(7);">7</a></div>
</div>
<div class="row">
    <div id="block8" class="number_block"><a href="javascript:select_number(8);">8</a></div>
    <div id="block9" class="number_block"><a href="javascript:select_number(9);">9</a></div>
    <div id="block10" class="number_block"><a href="javascript:select_number(10);">10</a></div>
    <div id="block11" class="number_block"><a href="javascript:select_number(11);">11</a></div>
    <div id="block12" class="number_block"><a href="javascript:select_number(12);">12</a></div>
    <div id="block13" class="number_block"><a href="javascript:select_number(13);">13</a></div>
    <div id="block14" class="number_block"><a href="javascript:select_number(14);">14</a></div>
</div>
<div class="row">
    <div id="block15" class="number_block"><a href="javascript:select_number(15);">15</a></div>
    <div id="block16" class="number_block"><a href="javascript:select_number(16);">16</a></div>
    <div id="block17" class="number_block"><a href="javascript:select_number(17);">17</a></div>
    <div id="block18" class="number_block"><a href="javascript:select_number(18);">18</a></div>
    <div id="block19" class="number_block"><a href="javascript:select_number(19);">19</a></div>
    <div id="block20" class="number_block"><a href="javascript:select_number(20);">20</a></div>
    <div id="block21" class="number_block"><a href="javascript:select_number(21);">21</a></div>
</div>
<div class="row">
    <div id="block22" class="number_block"><a href="javascript:select_number(22);">22</a></div>
    <div id="block23" class="number_block"><a href="javascript:select_number(23);">23</a></div>
    <div id="block24" class="number_block"><a href="javascript:select_number(24);">24</a></div>
    <div id="block25" class="number_block"><a href="javascript:select_number(25);">25</a></div>
    <div id="block26" class="number_block"><a href="javascript:select_number(26);">26</a></div>
    <div id="block27" class="number_block"><a href="javascript:select_number(27);">27</a></div>
    <div id="block28" class="number_block"><a href="javascript:select_number(28);">28</a></div>
</div>
<div class="row">
    <div id="block29" class="number_block"><a href="javascript:select_number(29);">29</a></div>
    <div id="block30" class="number_block"><a href="javascript:select_number(30);">30</a></div>
    <div id="block31" class="number_block"><a href="javascript:select_number(31);">31</a></div>
    <div id="block32" class="number_block"><a href="javascript:select_number(32);">32</a></div>
    <div id="block33" class="number_block"><a href="javascript:select_number(33);">33</a></div>
    <div id="block34" class="number_block"><a href="javascript:select_number(34);">34</a></div>
    <div id="block35" class="number_block"><a href="javascript:select_number(35);">35</a></div>
</div>
<div class="row">
    <div id="block36" class="number_block"><a href="javascript:select_number(36);">36</a></div>
    <div id="block37" class="number_block"><a href="javascript:select_number(37);">37</a></div>
    <div id="block38" class="number_block"><a href="javascript:select_number(38);">38</a></div>
    <div id="block39" class="number_block"><a href="javascript:select_number(39);">39</a></div>
    <div id="block40" class="number_block"><a href="javascript:select_number(40);">40</a></div>
    <div id="block41" class="number_block"><a href="javascript:select_number(41);">41</a></div>
    <div id="block42" class="number_block"><a href="javascript:select_number(42);">42</a></div>
</div>
<div class="row">
    <div id="block43" class="number_block"><a href="javascript:select_number(43);">43</a></div>
    <div id="block44" class="number_block"><a href="javascript:select_number(44);">44</a></div>
    <div id="block45" class="number_block"><a href="javascript:select_number(45);">45</a></div>
    <div id="block46" class="number_block"><a href="javascript:select_number(46);">46</a></div>
    <div id="block47" class="number_block"><a href="javascript:select_number(47);">47</a></div>
    <div id="block48" class="number_block"><a href="javascript:select_number(48);">48</a></div>
    <div id="block49" class="number_block"><a href="javascript:select_number(49);">49</a></div>
</div>
<div class="row">
    <table id="mybets" class="table">
        <thead>
            <tr>
            <td><h4>您已经下的注</h4></td>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>
    <!-- End Message Modal -->
    <?php require_once $_SERVER['DOCUMENT_ROOT'] . '/include/inc_popup_msgbox.php'; ?>
    <div id="wait" style="display:none;width:64px;height:64px; position:absolute;top:50%;left:50%;padding:2px;">
         <img src='/static/images/Loading_blue.gif' width="50" height="50" /><br>处理中</div>
</div>
</body>
</html>
