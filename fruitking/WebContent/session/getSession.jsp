<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>세션 값 가져오기</title>
</head>
<body>
	<h3> 세션에 설정한 값 가져오기 </h3>
	<%
	// Object getAttribute(String name): 리턴 타입이 Object형이기 때문에 형 변환하여 사용한다.
	String id=(String)session.getAttribute("id");           // session의 id에 저장된 값을 변수 id에 저장
    String pwd = (String)session.getAttribute("pwd");       // session의 pwd에 저장된 값을 변수 pwd에 저장  
	Integer age = (Integer)session.getAttribute("age");     // session의 age에 저장된 값을 변수 age에 저장
	%>
	id : <%= id %><br>      <!-- id값 출력 -->
	pwd : <%= pwd %><br>    <!-- pwd값 출력 -->
	age : <%= age %><br>    <!-- age값 출력 -->
</body>
</html>
