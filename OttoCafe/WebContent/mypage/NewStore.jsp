<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
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
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>오또카페</title>
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />

<style>
b {
	color: red;
}
</style>
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
						<strong style="font-size: 25px">거래처 등록</strong>
					</header>

					<article>

						<div class="content">
							<form name="enrollStore"
								action="../mypage/mypage_control.jsp?action=newStore"
								method="post">

								<table class="tg"
									style="table-layout: fixed; width: 560px; align: center">
									<tr>
										<td>거래처명</td>
										<td colspan="2"><input type="text" name="storeName"
											autofocus required></td>
									</tr>
									<tr>
										<td>거래처 홈페이지</td>
										<td colspan="2"><input type="text" name="storeHomepage"
											autofocus required></td>
									</tr>
									<tr>
										<td>전화번호</td>
										<td colspan="2"><input type="text" name="storeTel"
											required></td>
									</tr>
									<tr>
										<td>대표자명</td>
										<td colspan="2"><input type="text"
											name="storeRepresentative" required></td>
									</tr>

								</table>
								<br> <br> <input type="submit" value="확인"> <a
									href="../mypage/MyPageEnrollStore.jsp" class="button">취소</a>
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