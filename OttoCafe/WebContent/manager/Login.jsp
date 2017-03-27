<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오또카페</title>
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />

</head>
<body>
	<br>
	<br>
	<header class="major">
		<strong style="font-size: 25px">오또카페 재고관리 프로그램</strong>
	</header>

	<section>
		<form name="login" action="../manager/user_control.jsp?action=login"
			method="post">
			<br> <input type="text" name="managerId" placeholder="아이디"
				autofocus style="width: 400px; margin-bottom: 10px" required><br>
			<input type="password" name="managerPW" placeholder="비밀번호" required
				style="width: 400px; margin-bottom: 10px"> <br>
			<br>
			<div>
				<input type="submit" value="로그인" class="button"
					style="width: 150px;">
			</div>
			<br> <a href='../manager/idInquiry.jsp'>아이디 찾기</a>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href='../manager/passwdInquiry.jsp'>비밀번호
				찾기</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a
				href='../manager/Join.jsp'>회원가입</a>

		</form>
	</section>

	<br>


</body>
</html>