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
		NotifyDTO nextNotify = new NotifyDAO().getNextNotify(id);
		NotifyDTO priorNotify = new NotifyDAO().getPriorNotify(id);
	%>
	<div>
		<div style="background-color: rgb(253,255,244);">
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
						<td colspan="2"><div style="min-height: 200px; text-align: left;"><%= notify.getContent() %></div></td>
					</tr>
					<%
						if(nextNotify.getId() == notify.getId()){
					%>
						<tr>
							<td>윗글</td>
							<td colspan="2">윗글이 없습니다.</td>
						</tr>
					<%
						} else {
					%>
						<tr>
							<td>윗글</td>
							<td colspan="2"><a href="view.jsp?id=<%=nextNotify.getId() %>"><%= nextNotify.getTitle() %></a></td>
						</tr>
					<%
						}
						if(priorNotify.getId() == notify.getId()){
					%>
						<tr>
							<td>아랫글</td>
							<td colspan="2">아랫글이 없습니다.</td>
						</tr>
					<%
						} else {
					%>
						<tr>
							<td>아랫글</td>
							<td colspan="2"><a href="view.jsp?id=<%=priorNotify.getId()%>"><%= priorNotify.getTitle() %></a></td>
						</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<a href="../notify.jsp" class="btn btn-primary">목록</a>
			<a href="updateNotify.jsp?id=<%=id %>" class="btn btn-primary">수정</a>
			<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?id=<%=id %>" class="btn btn-primary pull-right">삭제</a>
		</div>
	</div>



</body>
</html>