<%@ page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>세션 삭제하기</title>
</head>
<body>
	<%
	// java.util 소슥의 Enumeration 인터페이스
	// Enumeration : 열거형, 순서를 가지고 있는 배열의 한 종류
	// hasMoreEnumeration() : 커서 바로 앞에 데이터가 있는지 체크하는 것, 데이터가 있으면 true, 아니면 false 리턴
	// nextElement() : 다음 데이터를 가리킨다.

	session.setAttribute("s_name1","첫번째 세션에 저장된 값");      // s_name1 세션 설정
	session.setAttribute("s_name2","두번째 세션에 저장된 값");      // s_name2 세션 설정
	session.setAttribute("s_name3","세번쨰 세션에 저장된 값");      // s_name3 세션 설정

	// 여러 개의 세션값을 출력할 때
	Enumeration names;      // Enumeration 인터페이스 사용

	names = session.getAttributeNames();

	while(names.hasMoreElements()) {        // 3개의 세션값 출력, 값이 있는 동안 출력
		String name = names.nextElement().toString();
		String value = session.getAttribute(name).toString();
		out.println(name + ":" + value + "<br>");
	}
        
	session.removeAttribute("s_name2");     // s_name2(두번째 세션)의 값 삭제
	out.print("<hr> <h3> == 두번째 세션값을 삭제한 후 == </h3>");

	names = session.getAttributeNames();

	while(names.hasMoreElements()) {
		String name = names.nextElement().toString();
		String value = session.getAttribute(name).toString();
		out.println(name + ":" + value + "<br>");
	}

	session.invalidate();   // 모든 세션 값을 한꺼번에 삭제
	out.print("<hr> <h3> == 세션값을 모두 삭제한 후 == </h3>");

	while(names.hasMoreElements()) {
		String name = names.nextElement().toString();
		String value = session.getAttribute(name).toString();
		out.println(name + ":" + value + "<br>");
	}

	%>
</body>
</html>
        