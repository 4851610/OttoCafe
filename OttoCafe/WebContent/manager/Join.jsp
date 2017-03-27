<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="manager.Manager"%>
<%@ page import="manager.ManagerDao"%>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	ManagerDao mdao = new ManagerDao();
	ArrayList<Manager> list = mdao.cafeList();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오또카페</title>
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />
<script>
	function showKeyCode(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 65 && keyID <= 90) || (keyID >= 97 && keyID <= 122)
				|| (keyID >= 48 && keyID <= 57) || (keyID == 8)
				|| (keyID >= 37 && keyID <= 40)) {
			return;
		} else {
			return false;
		}
	}

	function idCheck() {
		if (join.managerId.value == "") {
			alert("아이디를 입력하세요.");
		} else {
			location.href = '../manager/user_control.jsp?action=idcheck&managerId='
					+ join.managerId.value + '';
		}
	}

	function checkPwd() {
		var pw1 = join.managerPW.value;
		var pw2 = join.manager_pw_check.value;
		if (pw1 == pw2) {
			if (pw1 == "" || pw2 == "") {
				document.getElementById('checkPwd').innerHTML = "";
			} else {
				document.getElementById('checkPwd').style.color = "black";
				document.getElementById('checkPwd').innerHTML = "암호가 확인 되었습니다.";	
				return true;
			}
		} else {
			document.getElementById('checkPwd').style.color = "red";
			document.getElementById('checkPwd').innerHTML = "동일한 암호를 입력하세요.";
			join.manager_pw_check.focus();
			return false;
		}
		return true;
	}
</script>
<style type="text/css">
table {
	vertical-align: middle;
}
</style>
</head>
<body>
	<br>
	<br>
	<header class="major">
		<strong style="font-size: 25px">회원가입</strong>
	</header>

	<section>
		<form name="join" action="../manager/user_control.jsp?action=new"
			method="post" onSubmit="javascript:return checkPwd();">
			<input type="text" name="managerId" placeholder="아이디" autofocus
				required onkeydown="return showKeyCode(event)"
				style="width: 380px; margin-bottom: 10px">&nbsp;&nbsp;&nbsp;&nbsp;<input
				type="button" onClick="idCheck()" value="중복확인"
				style="width: 100px; margin-bottom: 10px" class="button"><br>
			<input type="password" style="width: 500px; margin-bottom: 10px"
				name="managerPW" placeholder="비밀번호" required class="text"> <br>
			<input type="password" style="width: 500px; margin-bottom: 10px"
				name="manager_pw_check" placeholder="비밀번호 확인" class="text" required>
			<br>
			<div id="checkPwd" style="font-size: 13px;margin-bottom:10px"></div>
			<br> <input type="text"
				style="width: 500px; margin-bottom: 10px" name="managerName"
				placeholder="이름" required class="text"><br> <select
				id="cafeUniqueKey" style="width: 500px; margin-bottom: 10px"
				name="cafeUniqueKey">

				<%
					for (Manager m : list) {
				%>
				<option value="<%=m.getCafeUniqueKey()%>"><%=m.getCafeName()%></option>
				<%
					}
				%>
			</select> <br> <br> <input type="submit" id="가입" value="회원가입"
				class="button" style="width: 80px" onclick="checkPwd()">&nbsp;&nbsp;
			<input type="button" value="취소" class="button"
				onClick="location.href='../manager/Login.jsp'">
		</form>
	</section>
</body>
</html>