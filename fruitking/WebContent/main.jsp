<%@ page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import ="org.json.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>Fruit King</title>
<link rel="stylesheet" href="./css/maincss.css">
<style type="text/css">
	a, a:hover {
		color: #000000;
		text_decoration: none;
	}
</style>
</head>
<body onLoad="pagestart()">
	<h2><a href="index.jsp">Fruit King</a></h2><br>
	<%
	Cookie[] cookies = request.getCookies();                // 요청정보로부터 쿠키를 가져온다.
        String access_token = "";       // 네이버 엑세스 토큰
        String refresh_token = "";      // 리프레시 토큰        
	
        for(int i = 0 ; i<cookies.length; i++){          // 쿠키 배열을 반복문으로 돌린다.
                if(cookies[i].getName().toString().equals("access_token")){
                        access_token = cookies[i].getValue();  // 쿠키의 값을 가져온다.
                } else if(cookies[i].getName().toString().equals("refresh_token")){
                        refresh_token = cookies[i].getValue();
                }
        }
	if(!access_token.equals("")){	// access_token값이 존재한다면
        	String header = "Bearer " + access_token; // Bearer 다음에 공백 추가
        	try {
                	String apiURL = "https://openapi.naver.com/v1/nid/me";
                	URL url = new URL(apiURL);
	                HttpURLConnection con = (HttpURLConnection)url.openConnection();
	                con.setRequestMethod("GET");
	                con.setRequestProperty("Authorization", header);
	                int responseCode = con.getResponseCode();
	                BufferedReader br;
	                if(responseCode==200) { // 정상 호출
	                        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	                } else {  // 에러 발생
	                        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	                }
	                String inputLine;
	                StringBuffer response1 = new StringBuffer();
	                while ((inputLine = br.readLine()) != null) {
	                                response1.append(inputLine);
	                }
	                br.close();
	                //out.println(response1.toString());      // 네이버에서 받아온 회원 정보를 출력
	                String name = "";
	                
	                JSONParser parser = new JSONParser();
	                Object obj = parser.parse(response1.toString());
	                // response1에 저장된 json형식의 String을 파싱하여 object로
	                JSONObject jsonObj = (JSONObject) obj;  // jsonObj는 전체 json 오브젝트 
	                if(jsonObj.get("resultcode").toString().equals("00")){
				String response2 = jsonObj.get("response").toString();
	                	// 전체 json에서 response만 받아와서 String으로
	
	                	JSONParser parser2 = new JSONParser();
	                	Object obj2 = parser2.parse(response2);         // obj는 response 오브젝트
	                	JSONObject jsonObj2 = (JSONObject) obj2;        // 다시 그대로 반복하여 json 오브젝트로
	                	name = jsonObj2.get("name").toString();
			
				out.println(name+" 님 안녕하세요.");
	                }
		
		} catch (Exception e) {
                System.out.println(e);
        	}
	}else {	// 쿠키에 access_token이 없다면
	%>	
		<a href="./naverlogin.jsp">네이버로그인</a>
	<% } %>
	<div class="tab">
		<div class="tabmenu">
			<div class="tablinks" onclick="openTab(event)">사이트 소개</div>
			<div class="tablinks" onclick="openTab(event)">과일 거래량</div>
			<div class="tablinks" onclick="openTab(event)">날씨</div>
			<div class="tablinks" onclick="openTab(event)">조세</div>
			<div class="tablinks" onclick="openTab(event)">물류</div>
			<div class="tablinks" onclick="openTab(event)">경매가</div>
			<div class="tablinks" onclick="openTab(event)">판매가</div>
			<div class="tablinks" onclick="openTab(event)">관련뉴스</div>
			<div class="tablinks" onclick="openTab(event)">공지사항</div>
			<div class="tablinks" onclick="openTab(event)">문의하기</div>
		</div>
		<%String df = "걀걀걀"; %>
	
		<section class="content">
		</section>
	</div>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
		function autosize(){ //ifame 크기 맞춰주는 함수
		    var oFrame = top.document.getElementById("Iframe"); 
		    contentHeight = oFrame.contentWindow.document.body.scrollHeight;
		    if (contentHeight < 100) { //content 최소 높이
		    	contentHeight = 100;
		    }
		    oFrame.style.height = String(contentHeight + 30) + "px";	//content 높이 자동 맞춤
		}
		
		function openTab(evt) { //tab focus 함수
			var tablinks = document.getElementsByClassName("tablinks"); //탭을 불러옵니다. 
			for (var i = 0, len = tablinks.length; i < len; i++) { 
				tablinks[i].className = tablinks[i].className.replace(" active", ""); //탭을 초기화시킵니다.
			}
			evt.currentTarget.className += " active"; //클릭한 탭을 활성화시킵니다.
		}

		function pagestart() {
			window.setTimeout("pagereload()", 30000);
		}
		function pagereload() {
			location.reload();
		}

		function makeTemplate(data, clickedName) {
			var resultHTML = "";
			var html = document.getElementById("tabcontent").innerHTML;
			
			for (var i = 0, len = data.length; i < len; i++) {
				if (data[i].name === clickedName) {
					resultHTML = html.replace("{html}", data[i].html)
					break;
				}
			}
			document.querySelector(".content").innerHTML = resultHTML;
		}///
		
		function sendAjax(url, clickedName) {
			var oReq = new XMLHttpRequest();
				oReq.addEventListener("load", function() {
				var data = JSON.parse(oReq.responseText);
				makeTemplate(data, clickedName);
			});
			oReq.open("GET", url);
			oReq.send();
		}
	
		var tabmenu = document.querySelector(".tabmenu");
		tabmenu.addEventListener("click", function(evt){
			sendAjax("./url.txt", evt.target.innerHTML);
		})
	</script>
	<script id="tabcontent" type="my-template">
		<iframe src="./tab/{html}.jsp" id="Iframe" width="100%" height="100%" min-height="200px" scrolling="no" frameborder="0" onload="autosize()"></iframe> 
	</script>
</body>
</html>

        
