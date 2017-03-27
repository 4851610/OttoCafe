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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>

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
<script>
	$(document).ready(
			function() {
				var fileTarget = $('.filebox .upload-hidden');

				fileTarget.on('change', function() { // 값이 변경되면
					if (window.FileReader) { // modern browser
						var filename = $(this)[0].files[0].name;
					} else { // old IE
						var filename = $(this).val().split('/').pop().split(
								'\\').pop(); // 파일명만 추출
					}

					// 추출한 파일명 삽입
					$(this).siblings('.upload-name').val(filename);
				});
			});
</script>
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
						<strong style="font-size: 25px">메뉴 등록</strong>
					</header>

					<article>

						<div class="content">
							<form name="enrollMerchandise" enctype="multipart/form-data"
								action="../mypage/mypage_control.jsp?action=newMerchandise&managerId=<%=managerId%>"
								method="post">

								<table class="tg"
									style="table-layout: fixed; width: 359px; align: center">
									<colgroup>
										<col style="width: 100.111111px">
										<col style="width: 259.111111px">
									</colgroup>

									<tr>
										<td>상품명</td>
										<td colspan="2"><input type="text" name="merchandiseName"
											autofocus required></td>
									</tr>
									<tr>
										<td><b>*</b> 가격</td>
										<td colspan="2"><input type="text" name="price"
											onkeydown="return showKeyCode(event)" autofocus required></td>
									</tr>
									<tr>
										<td>상품이미지</td>
										<td colspan="2"><div class="filebox">
												<input class="upload-name" value="파일선택" disabled="disabled">

												<label for="ex_filename">업로드</label> <input type="file"
													id="ex_filename" class="upload-hidden" name="image"
													required>
											</div></td>

									</tr>
								</table>
								<br> <b>*</b> 숫자만 입력하세요. <br> <br> <input
									type="submit" value="확인"> <a
									href="../mypage/MyPageEnrollMerchandise.jsp" class="button">취소</a>
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