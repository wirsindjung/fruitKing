<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쿠키 저장하기</title>
</head>
<body>
        <%

        Cookie info = new Cookie("testCookie", "Hello Cookie");    // 쿠키를 생성한다. 이름:testCookie, 값 : Hello Cookie



        info.setMaxAge(365*24*60*60);                                 // 쿠키의 유효기간을 365일로 설정한다.

        info.setPath("/");                                                    // 쿠키의 유효한 디렉토리를 "/" 로 설정한다.



        response.addCookie(info);                                    // 클라이언트 응답에 쿠키를 추가한다.



        %>
</body>
</html>