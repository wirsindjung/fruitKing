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
<link rel="stylesheet" href="../css/bootstrap.css">
<style type="text/css">
	a, a:hover {
		color: #000000;
		text_decoration: none;
	}
</style>
</head>
<body>
	<%
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<div>
		<div style="background-color: rgb(253,255,244);">
			<table class="table table-striped" style="text-align: center;	border: 1px solid #dddddd;">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						NotifyDAO notifyDAO = new NotifyDAO();
						ArrayList<NotifyDTO> notify = notifyDAO.getNotify(pageNumber);
						for(int i = 0, len = notify.size(); i < len; i++) {
					%>
					<tr>
						<td><%= notify.get(i).getId() %></td>
						<td><a href="view.jsp?id=<%= notify.get(i).getId() %>"><%= notify.get(i).getTitle() %></a></td>
						<td><%= notify.get(i).getDate() %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber >= 6) {
			%>
				<a href="notify.jsp?pageNumber=<%=pageNumber - (pageNumber % 5) %>"><<</a>
			<% 
				}
				if(pageNumber != 1) {
					for(int i = 0; i < 5; i++){
						%>
						
							<a href="notify.jsp?pageNumber=<%=i%>" ><%=i %></a>
						<%
						if(!notifyDAO.nextPage(pageNumber + 1)) break;
					}
				}
				if(notifyDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="notify.jsp?pageNumber=<%=pageNumber + 1 %>">>></a>
			<%
				}
			%>
			<a href="writeNotify.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>

</body>
</html>