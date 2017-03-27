<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="stock.Stock"%>
<%@ page import="stock.StockDao"%>
<%@ page import="java.util.ArrayList"%>
<%
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
	StockDao sdao = new StockDao(); 
	ArrayList<Stock> list = sdao.selectMaterial();
 
	StockDao stockdao = new StockDao();
	ArrayList<Stock> list3 = stockdao.unitList();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또카페</title>
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link href="../css/style.css" rel="stylesheet" type="text/css">
<script>
	function showKeyCode(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 48 && keyID <= 57) || (keyID == 8)
				|| (keyID >= 37 && keyID <= 40)) {
			return;
		} else {
			return false;
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

				<!-- Header -->
				<header id="header">
					<a style="text-align: left; font-size: 20px;" class="icon fa-home"
						href="../salesstatus/SalesStatus.jsp"><strong> 오또카페
							재고관리 프로그램 </strong></a>
					<ul class="icons">
						<li><a href="../manager/user_control.jsp?action=logout"
							style="margin-right: 20px">로그아웃</a></li>
						<!--  <li><a href="../mypage/NewMerchandise.jsp" >로그아웃</a></li>-->
					</ul>
				</header>

				<section>
					<header class="major">
						<strong style="font-size: 25px">재고 현황 등록</strong>
					</header>
					<article>

						<div class="content">

							<form name="addMerchandiseMaterial"
								action="../stockstatus/stockstatus_control.jsp?action=addStock"
								method="post">
								<table>
									<tr>
										<td>재료명</td>
										<td><select id="materialUniqueKey"
											name="materialUniqueKey" style="width: 770px;">

												<%
													for (Stock s : list) {
												%>
												<option value="<%=s.getMaterialCategoryUniqueKey()%>"><%=s.getCategoryName()%></option>
												<%
													}
												%>
										</select></td>
									</tr>
									<tr>
										<td><b> * </b>용량</td>
										<td><input type="text" name="volume"
											onkeydown="return showKeyCode(event)" required></td>
									</tr>
									<tr>
										<td>단위</td>
										<td><select id="materialUnitUniqueKey"
											name="materialUnitUniqueKey" style="width: 770px;">

												<%
													for (Stock s : list3) {
												%>
												<option value="<%=s.getMaterialUnitUniqueKey()%>"><%=s.getMaterialUnitName()%></option>
												<%
													}
												%>
										</select></td>
									</tr>
									<tr>
										<td><b>*</b> 최소 필요량</td>
										<td><input type="text" name="minimum"
											onkeydown="return showKeyCode(event)" required></td>
									</tr>
								</table>
								<br> * 숫자만 입력하세요. <br> <br> <input type="submit" value="등록" id="재료 등록"> <input
									type="button" value="취소" onClick="location.href='../stockstatus/StockStatus.jsp'">
							</form>
						</div>
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
						<li><a href="../mypage/MyPageEnrollStock.jsp"
							class="sans-serif" style="font-size: 18px">재료</a></li>
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

	<!-- Scripts -->
	<script src="../assets/js/jquery.min.js"></script>
	<script src="../assets/js/skel.min.js"></script>
	<script src="../assets/js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="../assets/js/main.js"></script>
</body>
</html>