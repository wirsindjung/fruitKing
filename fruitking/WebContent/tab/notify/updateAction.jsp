<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notify.NotifyDAO" %>
<%@ page import="notify.NotifyDTO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>z</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();

	int id = 0;
	if(request.getParameter("id") != null) {
		id = Integer.parseInt(request.getParameter("id"));
	}
	if(id == 0) {
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	if(request.getParameter("title") == null || request.getParameter("content") == null) {
		script.println("<script>");
		script.println("alert('입력 안된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		NotifyDAO notifyDAO = new NotifyDAO();
		int result = notifyDAO.update(id, request.getParameter("title"), request.getParameter("content"));
		if (result == -1){
			script.println("<script>");
			script.println("alert('글수정 실패')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("location.href = '../notify.jsp'");
			script.println("</script>");
		}
	}
%>
</body>
</html>