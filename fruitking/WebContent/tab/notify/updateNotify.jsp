<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="notify.NotifyDAO" %>
<%@ page import="notify.NotifyDTO" %>
<%@ page import="java.util.ArrayList"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notify</title>
<link rel="stylesheet" href="../../css/bootstrap.css">
</head>
<body>
	<%
		int id = 0;
		if(request.getParameter("id") != null) {
			id = Integer.parseInt(request.getParameter("id"));
		}
		if(id == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		NotifyDTO notify = new NotifyDAO().getNotifyDTO(id);
	%>
	<div style="background-color: rgb(253,255,244);">
		<div>
			<form method="post" action="updateAction.jsp?id=<%=id %>">
				<table class="table table-striped" style="text-align: center;	border: 1px solid #dddddd;">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">공지사항 작성</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="title" maxlength="20" value="<%= notify.getTitle() %>"></td>
						</tr>
						<tr>			
							<td><textarea class="form-control" placeholder="글 내용" name="content" style="height: 350px"><%= notify.getContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="수정">
			</form>
		</div>
	</div>



</body>
</html>