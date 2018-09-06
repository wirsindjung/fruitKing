<?php
        $token = "AAAANySoOPyYR/q11j0A74wro79KexkT5vZmAFBTakupj3krySeq3Jxow68QZ+3w16PD+kVG2CIdqiVo4lXV1fS4c9c=";        //이곳에 엑세스
 토큰을 넣어야 함
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
        $result_value;
        if($status_code == 200) {
                //echo $response; 

                $json = json_decode($response, true);
                $info = $json['response'];
                echo "<br><br>회원 id : ".$info['id']."<br>이메일 : ".$info['email']."<br>이름 : ".$info['name']."<br>별명 : ".$info['nickname']."<br>나이 : ".$info['age']."<br>생일 : ".$info['birthday']."<br>성별 : ".$info['gender']."<br>프로필 이미지 경로 : ".$info['profile_image'];

        } else {
                echo "Error 내용:".$response;
        }
?>