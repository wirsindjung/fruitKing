<%@ page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import = "java.net.URLEncoder" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>로그아웃</title>
</head>
<body>
	<%
	Cookie[] cookies = request.getCookies();                // 요청정보로부터 쿠키를 가져온다.
        String access_token = "";       // 네이버 엑세스 토큰
        for(int i = 0 ; i<cookies.length; i++){          // 쿠키 배열을 반복문으로 돌린다.
                if(cookies[i].getName().toString().equals("access_token")){
                        access_token = cookies[i].getValue();  // 쿠키의 값을 가져온다.
                }
        }
	String logout_URL = "https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id=ravoW4uifW7U6hs5l8QL&client_secret=d0HHEwl4dF&access_token=" + URLEncoder.encode(access_token, "UTF-8") + "&service_provider=NAVER";
	
        URL url = new URL(logout_URL);
        HttpURLConnection con = (HttpURLConnection)url.openConnection();
        con.setRequestMethod("GET");
        int responseCode = con.getResponseCode();
	
	// 로그아웃했으므로 쿠키를 다 지운다.
	try{	
		for(int i = 0 ; i<cookies.length; i++){ // 쿠키 배열을 반복문으로 돌린다.
                	cookies[i].setMaxAge(0);        // 특정 쿠키를 더 이상 사용하지 못하게 하기 위해서는 
                                                                                 // 쿠키의 유효시간을 만료시킨다.
                	response.addCookie(cookies[i]);         // 해당 쿠키를 응답에 추가(수정)한다.
        	}
	} catch(Exception e){
		
	}
	
	%>
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>
