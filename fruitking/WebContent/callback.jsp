<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.StringTokenizer" %>
<%@ page import = "org.json.*" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser" %>

<html>
	<head>
  	<meta charset="UTF-8">
    	<title>네이버로그인</title>
  	</head>
  	<body>
  	<%
    	String clientId = "ravoW4uifW7U6hs5l8QL";//애플리케이션 클라이언트 아이디값";
    	String clientSecret = "d0HHEwl4dF";//애플리케이션 클라이언트 시크릿값";
    	String code = request.getParameter("code");
    	String state = request.getParameter("state");
    	String redirectURI = URLEncoder.encode("http://fruitking.cf/callback.jsp", "UTF-8");
    	String apiURL;

    	apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
    	apiURL += "client_id=" + clientId;
    	apiURL += "&client_secret=" + clientSecret;
    	apiURL += "&redirect_uri=" + redirectURI;
    	apiURL += "&code=" + code;
    	apiURL += "&state=" + state;
    	String access_token = "";
    	String refresh_token = "";
    	System.out.println("apiURL="+apiURL);
    	try {
        	URL url = new URL(apiURL);
        	HttpURLConnection con = (HttpURLConnection)url.openConnection();
        	con.setRequestMethod("GET");
        	int responseCode = con.getResponseCode();
        	BufferedReader br;
        	System.out.print("responseCode="+responseCode);
        	if(responseCode==200) { // 정상 호출
          	br = new BufferedReader(new InputStreamReader(con.getInputStream()));
        	} else {  // 에러 발생
          	br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        	}
        	String inputLine;
        	StringBuffer res = new StringBuffer();
        	while ((inputLine = br.readLine()) != null) {
          	res.append(inputLine);
        	}
        	br.close();
        	if(responseCode==200) {
          	//out.println(res.toString());	// res에 들어있는 문자열 출력	
          	JSONParser parser = new JSONParser();	
          	Object obj = parser.parse(res.toString());	
		// res에 저장된 json형식의 String을 파싱하여 object로
          	JSONObject jsonObj2 = (JSONObject) obj;	// obj를 json 전용 object으로 변환하여 저장

          	String access_token2 = "";			// 엑세스 토큰을 저장하기 위한 String 변수
          	String refresh_token2 = "";			// 리프레시 토큰을 저자하기 위한 String 변수

          	access_token2 = (String)jsonObj2.get("access_token");	// 엑세스 토큰을 변수에 저장함
          	out.println("<br><br>access_token : "+access_token2);	

          	refresh_token2 = (String)jsonObj2.get("refresh_token");	// 리프레시 토큰을 저장함
          	out.println("<br>refresh_token : "+refresh_token2);

          	Cookie access_token_cookie = new Cookie("access_token", access_token2);    
		// 쿠키를 생성한다. 이름: accesstoken, 값 : String 변수 access_token2에 저장된 문자열
          	access_token_cookie.setMaxAge(60*60);   // 쿠키의 유효기간을 1시간으로 설정한다.
          	access_token_cookie.setPath("/");       // 쿠키의 유효한 디렉토리를 "/" 로 설정한다.

          	Cookie refresh_token_cookie = new Cookie("refresh_token", refresh_token2);
          	refresh_token_cookie.setMaxAge(60*60);
          	refresh_token_cookie.setPath("/");


          	response.addCookie(access_token_cookie);        // 클라이언트 응답에 쿠키를 추가한다.
          	response.addCookie(refresh_token_cookie);
		
		response.sendRedirect("userinfo.jsp");
	  	}
      	} catch (Exception e) {
       	out.println(e);
      	}
  	%>
  	</body>
</html>

