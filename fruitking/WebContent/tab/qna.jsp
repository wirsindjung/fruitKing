<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div>문의하기 입니다.</div>
	<form action="https://formspree.io/2mingju@naver.com" method="POST">
		<div>
        	<label for="name">이름:</label>
        	<input type="text" name="name">
    	</div>
    		
		<div>
        	<label for="name">이메일:</label>
        	<input type="email" name="_replyto">
    	</div>

		<div>
        	<label for="message">Message:</label>
        	<textarea name="message"></textarea>
    	</div>
    	<input type="submit" value="Send">
	</form>
</body>
</html>