<%@ page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import = "java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>

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
<link rel="stylesheet" href="../css/bootstrap.css">
</head>
<body onLoad="pagestart()">
	<h2><a href="index.jsp">Fruit King</a></h2><br>
	<%
	Cookie[] cookies = request.getCookies();                // 요청정보로부터 쿠키를 가져온다.
        String access_token = "";       // 네이버 엑세스 토큰
        String refresh_token = "";      // 리프레시 토큰        
	
	try{
        	for(int i = 0 ; i<cookies.length; i++){          // 쿠키 배열을 반복문으로 돌린다.
                	if(cookies[i].getName().toString().equals("access_token")){
                        	access_token = cookies[i].getValue();  // 쿠키의 값을 가져온다.
                	} else if(cookies[i].getName().toString().equals("refresh_token")){
                       	 	refresh_token = cookies[i].getValue();
                	}
        	}
	} catch (Exception e){

	}
	if(!access_token.equals("")){	// access_token값이 존재한다면
        	//out.println(access_token + "<br><br>");
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
	               	
			String resultcode = jsonObj.get("resultcode").toString();
			if(resultcode.equals("00")){	// resultcode가 00이면 정상적으로 받아온 거
				String response2 = jsonObj.get("response").toString();
	                	// 전체 json에서 response만 받아와서 String으로
	
	                	JSONParser parser2 = new JSONParser();
	                	Object obj2 = parser2.parse(response2);         // obj는 response 오브젝트
	                	JSONObject jsonObj2 = (JSONObject) obj2;        // 다시 그대로 반복하여 json 오브젝트로
	                	name = jsonObj2.get("name").toString();
				 
				out.println(name+" 님 안녕하세요.");
				%> 
				<a href = "./logout.jsp">로그아웃</a>
				<%

	                } else if (resultcode.equals("024")){	// 인증에 실패했다면?
				String clientId = "ravoW4uifW7U6hs5l8QL";//애플리케이션 클라이언트 아이디값";
        			String clientSecret = "d0HHEwl4dF";//애플리케이션 클라이언트 시크릿값";
				String refresh_URL = "https://nid.naver.com/oauth2.0/token?grant_type=refresh_token";
				refresh_URL += "&client_id=" + clientId;
				refresh_URL += "&client_secret=" + clientSecret;
				refresh_URL += "&refresh_token=" + refresh_token;

				URL url_2 = new URL(refresh_URL);
                		HttpURLConnection con_2 = (HttpURLConnection)url_2.openConnection();
                		con_2.setRequestMethod("GET");
                		int responseCode_2 = con_2.getResponseCode();
				
				BufferedReader br_2;
               			//System.out.print("responseCode="+responseCode_2);
		                if(responseCode_2==200) { // 정상 호출
		                	br_2 = new BufferedReader(new InputStreamReader(con_2.getInputStream()));
		                	out.println("<h3>갱신했습니다.</h3><br>");
				} else {  // 에러 발생
		                	br_2 = new BufferedReader(new InputStreamReader(con_2.getErrorStream()));
					out.println("갱신 실패<br>");
		                }
		                String inputLine_2;
		                StringBuffer res_2 = new StringBuffer();
		                while ((inputLine = br_2.readLine()) != null) {
		                res_2.append(inputLine);
		                }
		                br.close();
		                if(responseCode_2==200) {
			                //out.println(res.toString());  // res에 들어있는 문자열 출력   
			                
			                JSONParser parser_2 = new JSONParser();
			                Object obj_2 = parser.parse(res_2.toString());      
			                // res에 저장된 json형식의 String을 파싱하여 object로
			                JSONObject jsonObj2_2 = (JSONObject) obj_2; // obj를 json 전용 object으로 변환하여 저장
			
			                String access_token2_2 = "";                      // 엑세스 토큰을 저장하기 위한 String 변수
			                String refresh_token2_2 = "";                     // 리프레시 토큰을 저자하기 위한 String 변수
			
			                access_token2_2 = (String)jsonObj2_2.get("access_token");   // 엑세스 토큰을 변수에 저장함
			                out.println("<br><br>새로운 access_token : "+access_token2_2);
			
			                refresh_token2_2 = (String)jsonObj2_2.get("refresh_token"); // 리프레시 토큰을 저장함
			                out.println("<br>새로운 refresh_token : "+refresh_token2_2);
			
			                Cookie access_token_cookie_2 = new Cookie("access_token", access_token2_2);
			                // 쿠키를 생성한다. 이름: accesstoken, 값 : String 변수 access_token2에 저장된 문자열
			                access_token_cookie_2.setMaxAge(60*60);   // 쿠키의 유효기간을 1시간으로 설정한다.
			                access_token_cookie_2.setPath("/");       // 쿠키의 유효한 디렉토리를 "/" 로 설정한다.
		
			                Cookie refresh_token_cookie_2 = new Cookie("refresh_token", refresh_token2_2);
			                refresh_token_cookie_2.setMaxAge(60*60);
			                refresh_token_cookie_2.setPath("/");
		

		                	response.addCookie(access_token_cookie_2);        // 클라이언트 응답에 쿠키를 추가한다.
                			response.addCookie(refresh_token_cookie_2);
				
				}
			}
		} catch (Exception e) {
                System.out.println(e);
        	}
	}else {	// 쿠키에 access_token이 없다면
		String clientId = "ravoW4uifW7U6hs5l8QL";//애플리케이션 클라이언트 아이디값";
	    	String redirectURI = URLEncoder.encode("http://fruitking.cf/callback.jsp", "UTF-8");
	    	SecureRandom random = new SecureRandom();
	    	String state = new BigInteger(130, random).toString();
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id=" + clientId;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&state=" + state;
		session.setAttribute("state", state);
 		%>
  		<a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>	
	
		<!--<a href="./naverlogin.jsp">네이버로그인</a>-->
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
		
		<section class="content"></section>
	</div>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
		function autosize(){ //ifame 크기 맞춰주는 함수
		    var oFrame = top.document.getElementById("Iframe"); 
		    contentHeight = oFrame.contentWindow.document.body.scrollHeight;
		    if (contentHeight < 500) { //content 최소 높이
		    	contentHeight = 500;
		    }
		    oFrame.style.height = String(contentHeight + 50) + "px";	//content 높이 자동 맞춤
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
		}
		
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

        