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



        for(int i = 0 ; i<cookies.length; i++){                            // 쿠키 배열을 반복문으로 돌린다.



        cookies[i].setMaxAge(0);                        // 특정 쿠키를 더 이상 사용하지 못하게 하기 위해서는 

        // 쿠키의 유효시간을 만료시킨다.

        response.addCookie(cookies[i]);            // 해당 쿠키를 응답에 추가(수정)한다.

        }

        %>
</body>
</html>