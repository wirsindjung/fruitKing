<?php
	$token = "AAAAN4sMOXo/wYRZ02qJ6MsfPeIbt+ek87DjQjG4EQnLIA4s3K7/Cu+RQTdoPdQn3ovkluVg1dsgnZCU3Ll4mZWwN+E=";	//이곳에 엑세스 토큰을 넣어야 함
	$header = "Bearer ".$token; // Bearer 다음에 공백 추가
 	$url = "https://openapi.naver.com/v1/nid/me";
  	$is_post = false;
  	$ch = curl_init();
  	curl_setopt($ch, CURLOPT_URL, $url);
  	curl_setopt($ch, CURLOPT_POST, $is_post);
  	curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
  	$headers = array();
  	$headers[] = "Authorization: ".$header;
  	curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
  	$response = curl_exec ($ch);
  	$status_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  	echo "status_code:".$status_code."<br>";
  	curl_close ($ch);
  	if($status_code == 200) {
    	echo $response;
  	} else {
    	echo "Error 내용:".$response;
  	}
?>
