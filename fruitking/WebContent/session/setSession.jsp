<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>세션 값 설정하기</title>
</head>
<body>
	<%
	session.setAttribute("id","minju");     // gildong 값을 id에 저장
	session.setAttribute("pwd","test1234"); // test1234 값을 pwd에 저장
	session.setAttribute("age",27);
	%>
	<h3> 세션에 값 설정 </h3>
</body>
</html>
