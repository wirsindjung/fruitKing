<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="notify.NotifyDAO" %>
<%@ page import="notify.NotifyDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notify</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<style type="text/css">
	#content {
		min-height: 300px;
		text-align: left;
	}
</style>
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
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center;	border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th colspan="4" style="background-color: #eeeeee; text-align: center;">공지사항 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= notify.getTitle() %></td>
					</tr>
					<tr>
						<td>작성 일자</td>
						<td colspan="2"><%= notify.getDate() %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td id="content" colspan="2" style="min-height: 300px; text-align: left;"><%= notify.getContent() %></td>
					</tr>
					<tr>
						<td>윗 글</td>
						<td colspan="2""><a href="view.jsp?id=<%=id + 1 %>">
						<% NotifyDTO notifyNext = new NotifyDAO().getNotifyDTO(id + 1); %>
						<%= notifyNext.getTitle() %>
						</a></td>
					</tr>
					<tr>
						<td>아랫 글</td>
						<td colspan="2""><a href="view.jsp?id=<%=id - 1 %>">
						<% NotifyDTO notifyPrior = new NotifyDAO().getNotifyDTO(id - 1); %>
						<%= notifyPrior.getTitle() %>
						</a></td>
					</tr>
				</tbody>
			</table>
			<a href="notify.jsp" class="btn btn-primary">목록</a>
			<a href="update.jsp?id=<%=id %>" class="btn btn-primary">수정</a>
			<a href="deleteAction.jsp?id=<%=id %>" class="btn btn-primary">삭제</a>
		</div>
	</div>



</body>
</html>