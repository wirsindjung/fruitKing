<%@ page import="java.util.Enumeration" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="notify.NotifyDAO" %>
<%@ page import="notify.NotifyDTO" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>Fruit King</title>
<link rel="stylesheet" href="./css/maincss.css">
<link rel="stylesheet" href="../css/bootstrap.css">
</head>
<body>
	<h2>Fruit King</h2><br><a href="./naverlogin.jsp">네이버로그인</a>

	<div class="tab">
		<div class="tabmenu">
			<div class="tablinks" onclick="openTab(event)">사이트 소개</div>
			<div class="tablinks" onclick="openTab(event)">과일 거래량</div>
			<div class="tablinks" onclick="openTab(event)">날씨</div>
			<div class="tablinks" onclick="openTab(event)">조세</div>
			<div class="tablinks" onclick="openTab(event)">물류</div>
			<div class="tablinks" onclick="openTab(event)">경매가</div>
			<div class="tablinks" onclick="openTab(event)">판매가</div>
			<div class="tablinks" onclick="openTab(event)">관련뉴스</div>
			<div class="tablinks" onclick="openTab(event)">공지사항</div>
			<div class="tablinks" onclick="openTab(event)">문의하기</div>
		</div>
		
		<section class="content"></section>
	</div>
	
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
	<script>
		//ifame 크기 맞춰주는 함수
		function autosize(){
		    var oFrame = top.document.getElementById("Iframe"); 
		    contentHeight = oFrame.contentWindow.document.body.scrollHeight;
		    if (contentHeight < 500) { //content 최소 높이
		    	contentHeight = 500;
		    }
		    oFrame.style.height = String(contentHeight + 50) + "px";	//content 높이 자동 맞춤
		}
		
		//tab focus 함수	
		function openTab(evt) {		
			var tablinks = document.getElementsByClassName("tablinks"); //탭을 불러옵니다. 
			for (var i = 0, len = tablinks.length; i < len; i++) { 
				tablinks[i].className = tablinks[i].className.replace(" active", ""); //탭을 초기화시킵니다.
			}
			evt.currentTarget.className += " active"; //클릭한 탭을 활성화시킵니다.
		}
		
		function makeTemplate(data, clickedName) {
			var resultHTML = "";
			var html = document.getElementById("tabcontent").innerHTML;
			
			for (var i = 0, len = data.length; i < len; i++) {
				if (data[i].name === clickedName) {
					resultHTML = html.replace("{html}", data[i].html)
					break;
				}
			}
			document.querySelector(".content").innerHTML = resultHTML;
		}
		
		function sendAjax(url, clickedName) {
			var oReq = new XMLHttpRequest();
				oReq.addEventListener("load", function() {
				var data = JSON.parse(oReq.responseText);
				makeTemplate(data, clickedName);
			});
			oReq.open("GET", url);
			oReq.send();
		}
	
		var tabmenu = document.querySelector(".tabmenu");
		tabmenu.addEventListener("click", function(evt){
			sendAjax("./url.txt", evt.target.innerHTML);
		})
	</script>
	<script id="tabcontent" type="my-template">
		<iframe src="./tab/{html}.jsp" id="Iframe" width="100%" height="100%" min-height="200px" scrolling="no" frameborder="0" onload="autosize()"></iframe> 
	</script>
</body>
</html>

        