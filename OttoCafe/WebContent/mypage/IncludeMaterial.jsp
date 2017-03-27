<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ page import="java.util.ArrayList"%>
<%@ page import="merchandise.Merchandise"%>
<%@ page import="merchandise.MerchandiseDao"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	int uniqueKey = Integer.parseInt(request.getParameter("uniqueKey"));
	String name = request.getParameter("name");

	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");
	} catch (Exception e) {

	}
	if (managerId == null || managerId.equals("")) {
		response.sendRedirect("../manager/Login.jsp");
	}
%>
<%
	MerchandiseDao mdao = new MerchandiseDao();
	ArrayList<Merchandise> list = mdao.includeMaterialList(uniqueKey);
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또카페</title>
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />
<style type="text/css">
body {
	
}

table {
	text-align: center;
	vertical-align: middle;
	border: 1;
	border-collapse: collapse;
	margin: 0 auto;
}
</style>
<script type="text/javascript">
	function addMaterial() {
		var winHeight = document.body.clientHeight;	// 현재창의 높이
		var winWidth = document.body.clientWidth;	// 현재창의 너비
		var winX = window.screenLeft;	// 현재창의 x좌표
		var winY = window.screenTop;	// 현재창의 y좌표

		var popX = winX + (winWidth - 300)/2;
		var popY = winY + (winHeight - 500)/2;
		
		open("../mypage/MerchandiseMaterial.jsp?uniqueKey=<%=uniqueKey%>", "confirm", "toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=300,height=300px,top="	+ popY + ",left=" + popX)
	}

	function checkDel() {
		var chkFirList = document.getElementsByName('select');
		var arrFir = new Array();
		var cnt = 0;
		for (var idx = chkFirList.length - 1; 0 <= idx; idx--) {
			if (chkFirList[idx].checked) {
				arrFir[cnt] = chkFirList[idx].value;
				cnt++;
			}
		}
		if (arrFir.length != 0) {
			document.deleteMer.submit();
		} else {
			alert('삭제할 재료를 선택하세요.');
			return;
		}
	}
</script>
</head>
<body>
	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<header id="header">
					<a style="text-align: left; font-size: 20px;" class="icon fa-home"
						href="../salesstatus/SalesStatus.jsp"><strong> 오또카페
							재고관리 프로그램 </strong></a>
					<ul class="icons">
						<li><a href="../manager/user_control.jsp?action=logout"
							style="margin-right: 20px">로그아웃</a></li>
					</ul>
				</header>

				<section>
					<header class="major">
						<strong style="font-size: 25px">사용되는 재료 조회</strong>
					</header>

					<article>
						<form name="deleteMer" method="post"
								action="../mypage/mypage_control.jsp?action=delMaterial"
								id="delete">
							상품코드 :
							<input type="text" id="<%=uniqueKey%>" value="<%=uniqueKey%>" name="<%=uniqueKey%>" style="width:100px;" readonly>  
							상품명 : <input type="text" id="<%=name%>" value="<%=name%>" name="<%=name%>" style="width:300px;" readonly> <br> <br>
							<table>
								<tr>
									<td><b>선택</b></td>
									<td><b>재료코드</b></td>
									<td><b>재료명</b></td>
									<td><b>카테고리</b></td>
									<td><b>필요량</b></td>
									<td><b>단위</b></td>
									<td><b>재료이미지</b></td>
								</tr>

								<%
									for (Merchandise m : list) {
								%>

								<tr>
									<td><input type="checkbox" name="select"
										value=<%=m.getIncludeMaterialUniqueKey()%>></td>
									<td><%=m.getMaterialUniqueKey()%></td>
									<td><%=m.getMaterialName()%></td>
									<td><%=m.getCategoryName()%></td>
									<td><%=m.getAmount()%></td>
									<td><%=m.getMaterialUnitName()%></td>
									<td><img src=<%=m.getImage()%> width="80" height="80"></td>
								</tr>
								<%
									}
								%>
							</table>
							<br> <br> <a class="button" onclick="addMaterial()">재료
								추가</a> <a class="button" onclick="checkDel()">삭제 </a> <a
								class="button" onclick="history.back()">확인</a>
						</form>
					</article>
				</section>

			</div>
		</div>

		<!-- Sidebar -->
		<div id="sidebar">

			<div class="inner">

				<!-- Menu -->
				<nav id="menu">
					<header class="major">
						<strong style="font-size: 25px">Menu</strong>
					</header>
					<ul>
						<li><span class="opener" style="font-size: 18px">재료</span>
							<ul>
								<li><a href="../mypage/MyPageEnrollStock.jsp"
									class="sans-serif" style="font-size: 18px">재료 등록</a></li>
								<li><a href="../stockstatus/StockStatus.jsp"
									class="sans-serif" style="font-size: 18px">재고 현황</a></li>
							</ul></li>
						<li><a href="../mypage/MyPageEnrollMerchandise.jsp"
							class="sans-serif" style="font-size: 18px">메뉴</a></li>
						<li><a href="../mypage/MyPageEnrollStore.jsp"
							class="sans-serif" style="font-size: 18px">거래처</a></li>
					</ul>
				</nav>

				<!-- Footer -->
				<footer id="footer">
					<p class="copyright">&copy; copyright 2016, 김포(金4)공항 All rights
						reserved.</p>
				</footer>

			</div>
		</div>

	</div>
</body>
</html>