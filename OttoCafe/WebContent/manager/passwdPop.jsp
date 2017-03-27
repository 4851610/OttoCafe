<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="manager.Manager"%>
<%@ page import="manager.ManagerDao"%>
<%
	int cafeUniqueKey = Integer.parseInt(request
			.getParameter("cafeUniqueKey"));
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	System.out.println(cafeUniqueKey);
	System.out.println(name);
	System.out.println(id);
%>
<%
	ManagerDao mdao = new ManagerDao();
	String passwd = mdao.searchPasswd(cafeUniqueKey, name, id);
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
		<h2>비밀번호 찾기</h2>
	</header>
	<section>
		<%
			if (passwd.equals("")) {
		%>
		존재하는 아이디가 없습니다.
		<%
			} else {
		%>
		<%
			String password = "";
				for (int i = 0; i < 8; i++) {
					char lowerStr = (char) (Math.random() * 26 + 97);
					if (i % 2 == 0) {
						password += (int) (Math.random() * 10);
					} else {
						password += lowerStr;
					}
				}

			mdao.updatePw(password, cafeUniqueKey, name, id);
		%> 
		임시 비밀번호
		<%=password%>
		입니다. <br> 로그인 후 변경해주세요.
		<%
			}
		%>
		<br> <br> <input type="button" value="확인"
			onclick="cancelbutton()">
	</section>
	<footer></footer>
</body>
</html>