<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="manager.Manager"%>
<%@ page import="manager.ManagerDao"%>
<%
	int cafeUniqueKey = Integer.parseInt(request
			.getParameter("cafeUniqueKey"));
	String name = request.getParameter("name");
%>
<%
	ManagerDao mdao = new ManagerDao();
	String id = mdao.searchId(cafeUniqueKey, name);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또카페</title>
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script>
	function cancelbutton() {
		self.opener = self;
		window.close();
	}
</script>
</head>
<body>
	<header>
		<br> <br>
		<h2>아이디 찾기</h2>
	</header>
	<section>
		<%
			if (id.equals("")) {
		%>
		존재하는 아이디가 없습니다.
		<%
			} else {
		%>
		해당 아이디는
		<%=id%>
		입니다.
		<%
			}
		%>
		<br> <br> <input type="button" value="확인" onclick="cancelbutton()">
	</section>
	<footer></footer>
</body>
</html>