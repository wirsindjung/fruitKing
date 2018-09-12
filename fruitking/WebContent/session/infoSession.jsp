<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>세션 관련 메서드</title>
</head>
<body>
	<h3> 세션 정보를 가져오는 메서드들 </h3>
	<%
	String id_str = session.getId();        // 세션의 id(고유번호) 값 리턴
	long lasttime = session.getLastAccessedTime();  // 세션에 마지막으로 접근한 시간
	long createdtime = session.getCreationTime();   // 세션에 처음으로 접근한 시간
	long time_used = (lasttime - createdtime) / 60000;      // 세션에 머문 시간
	int inactive = session.getMaxInactiveInterval() / 60;   // 세션의 유효기간, 기본값을 30분
	boolean b_new = session.isNew();        // 새로운 세션이면 true, 아니면 false 리턴
	%>
	[1] 세션 ID는 [<%= session.getId() %>] 입니다. <br> <hr>
	[2] 당신이 웹 사이트에 머문 시간은 [<%= time_used %>] 분입니다. <br> <hr>
	[3] 세션의 유효 시간은 [<%= inactive %>] 분입니다. <br> <hr>
 	[4] 세션이 새로 만들어졌나요? <br>
	<%
		if(b_new)
			out.print("예! 새로운 세션을 만들었습니다.");
		else
			out.print("아니오! 새로운 세션을 만들지 않았습니다.");
	%>
</body>
</html>
