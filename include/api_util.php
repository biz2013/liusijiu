<?php

function create_json_response($status, $msg, $http_resp_code = 403) {
    $resp = new \stdClass();
    $resp->status = $status;
    $resp->message = $msg;
	header('Content-Type: application/json');
	http_response_code($http_resp_code);
    echo json_encode($resp);
}

?>