<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="manager.Manager"%>
<%@ page import="manager.ManagerDao"%>
<%@ page import="java.util.ArrayList"%>
<%
	ManagerDao mdao = new ManagerDao();
	ArrayList<Manager> list = mdao.cafeList();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또 카페</title>
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />
<script type="text/javascript">
	function addMaterial() {
		var winHeight = document.body.clientHeight; // 현재창의 높이
		var winWidth = document.body.clientWidth; // 현재창의 너비
		var winX = window.screenLeft; // 현재창의 x좌표
		var winY = window.screenTop; // 현재창의 y좌표

		var popX = winX + (winWidth - 400) / 2;
		var popY = winY + (winHeight - 200) / 2;

		var cafeUniqueKey = document.getElementById("cafeUniqueKey");
		var name = document.getElementById("managerName");
		var id = document.getElementById("managerId");

		open(
				"../manager/passwdPop.jsp?cafeUniqueKey=" + cafeUniqueKey.value
						+ "&name=" + name.value + "&id=" + id.value + "",
				"confirm",
				"toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=400,height=200px,top="
						+ popY + ",left=" + popX)

	}
</script>
</head>
<body>
	<header class="major">
		<br> <br> <strong style="font-size: 25px">비밀번호 찾기</strong>
	</header>

	<section>
		<form name="idInquiry" action="../manager/idPop.jsp" method="post">
			<select id="cafeUniqueKey" style="width: 500px; margin-bottom: 10px"
				name="cafeUniqueKey">

				<%
					for (Manager m : list) {
				%>
				<option value="<%=m.getCafeUniqueKey()%>"><%=m.getCafeName()%></option>
				<%
					}
				%>
			</select> <br> <input type="text"
				style="width: 500px; margin-bottom: 10px" name="managerId"
				id="managerId" placeholder="아이디" required class="text"> <br> <input
				type="text" style="width: 500px; margin-bottom: 10px"
				name="managerName" id="managerName" placeholder="이름" required
				class="text"><br> <br> <br> <input
				type="button" id="비밀번호 찾기" value="비밀번호 찾기" class="button"
				style="width: 80px" onclick="addMaterial()">&nbsp;&nbsp; <input
				type="button" value="취소" class="button"
				onClick="location.href='../manager/Login.jsp'">
		</form>
	</section>

</body>
</html>