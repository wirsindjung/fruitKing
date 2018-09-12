<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="notify.NotifyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="notify" class="notify.NotifyDTO" scope="page" />
<jsp:setProperty name="notify" property="title" />
<jsp:setProperty name="notify" property="content" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>z</title>
</head>
<body>
<%
	PrintWriter script = response.getWriter();
	if(notify.getTitle() == null || notify.getContent() ==null) {
		script.println("<script>");
		script.println("alert('입력 안된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		NotifyDAO notifyDAO = new NotifyDAO();
		int result = notifyDAO.write(notify.getTitle(), notify.getContent());
		if (result == -1){
			script.println("<script>");
			script.println("alert('글쓰기 실패')");
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