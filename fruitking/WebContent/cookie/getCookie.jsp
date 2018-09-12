<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%

        Cookie[] cookies = request.getCookies();            // 요청정보로부터 쿠키를 가져온다.



        out.println("현재 설정된 쿠키의 개수 : " + cookies.length+"<br>");    // 쿠키가 저장된 배열의 길이를 가져온다.



        for(int i = 0 ; i<cookies.length; i++){                            // 쿠키 배열을 반복문으로 돌린다.



        out.println(i + "번째 쿠키 이름 : " + cookies[i].getName()+"<br>");            // 쿠키의 이름을 가져온다.

        out.println(i + "번째 쿠키에 설정된 값 : " + cookies[i].getValue()+"<br>");    // 쿠키의 값을 가져온다.



        }

        %>
	
</body>
</html>