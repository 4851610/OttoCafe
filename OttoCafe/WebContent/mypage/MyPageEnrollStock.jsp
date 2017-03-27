<%@page import="jdk.management.resource.internal.TotalResourceContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="stock.Stock"%>
<%@ page import="stock.StockDao"%>
<%
	String managerId = "";
	try {
		managerId = (String) session.getAttribute("managerId");
	} catch (Exception e) {

	}
	if (managerId == null || managerId.equals("")) {
		response.sendRedirect("../manager/Login.jsp");
	}

	int pageno = toInt(request.getParameter("pageno"));
	if (pageno < 1) {
		pageno = 1;
	}
%>
<%!public Integer toInt(String x) {
		int a = 0;
		try {
			a = Integer.parseInt(x);
		} catch (Exception e) {
		}
		return a;
	}%>
<%
	StockDao sdao = new StockDao();
	ArrayList<Stock> list = sdao.stockList(pageno);
	int totalRecord = sdao.totalRecord();
%>
<%
	int total_record = totalRecord; //데이터베이스에서 가져온 값으로 변경해야됨
	int page_per_record_cnt = 5;
	int group_per_page_cnt = 10;

	int record_end_no = pageno * page_per_record_cnt;
	int record_start_no = record_end_no - (page_per_record_cnt - 1);
	if (record_end_no > total_record) {
		record_end_no = total_record;
	}

	int total_page = total_record / page_per_record_cnt + (total_record % page_per_record_cnt > 0 ? 1 : 0);
	if (pageno > total_page) {
		pageno = total_page;
	}

	int group_no = pageno / group_per_page_cnt + (pageno % group_per_page_cnt > 0 ? 1 : 0);
	int page_eno = group_no * group_per_page_cnt;
	int page_sno = page_eno - (group_per_page_cnt - 1);

	if (page_eno > total_page) {
		page_eno = total_page;
	}

	int prev_pageno = page_sno - group_per_page_cnt;
	int next_pageno = page_sno + group_per_page_cnt;

	if (prev_pageno < 1) {
		prev_pageno = 1;
	}
	if (next_pageno > total_page) {
		next_pageno = total_page / group_per_page_cnt * group_per_page_cnt + 1;
	}
%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
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
			alert('삭제할 재고를 선택하세요.');
			return;
		}
	}
</script>
<head>
<title>오또카페</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />
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


				<!-- Section -->
				<section>
					<header class="major">
						<strong style="font-size: 25px">재료 등록</strong>
					</header>

					<article>

						<div class="content">
							<form name="deleteMer" method="post"
								action="../mypage/mypage_control.jsp?action=materialDelete"
								id="delete">
								<table class="tg" style="table-layout: fixed; width: 746px;">
									<colgroup>
										<col style="width: 45.111111px">
										<col style="width: 74.111111px">
										<col style="width: 76.111111px">
										<col style="width: 84.111111px">
										<col style="width: 217.111111px">
										<col style="width: 92.111111px">
										<col style="width: 71.111111px">
										<col style="width: 52.111111px">
										<col style="width: 39.111111px">
									</colgroup>
									<tr>
										<td><b>선택</b></td>
										<td><b>재료 코드</b></td>
										<td><b>카테고리</b></td>
										<td><b>거래처</b></td>
										<td><b>제품명</b></td>
										<td><b>제품 이미지</b></td>
										<td><b>입고 단가</b></td>
										<td><b>용량</b></td>
										<td><b>단위</b></td>
									</tr>

									<%
										for (Stock s : list) {
									%>
									<tr>
										<td><input type="checkbox" name="select"
											value=<%=s.getMaterialUniqueKey()%>></td>
										<td><%=s.getMaterialUniqueKey()%></td>
										<td><%=s.getCategoryName()%></td>
										<td><%=s.getMaterialStoreName()%></td>
										<td><%=s.getMaterialName()%></td>
										<td><img src=<%=s.getImage()%> width="80px" height="80px"></td>
										<td><%=s.getPrice()%></td>
										<td><%=s.getVolume()%></td>
										<td><%=s.getMaterialUnitName()%></td>
									</tr>
									<%
										}
									%>
								</table>
								<%
									for (int i = page_sno; i <= page_eno; i++) {
								%>
								<a href="../mypage/MyPageEnrollStock.jsp?pageno=<%=i%>"> <%
 	if (pageno == i) {
 %><span> [<%=i%>]
								</span> <%
 	} else {
 %> <%=i%> <%
 	}
 %>
								</a>
								<%--	콤마	 --%>
								<%
									if (i < page_eno) {
								%>

								<%
									}
								%>
								<%
									}
								%>

								<br> <br> <a href="../mypage/NewMaterial.jsp"
									class="button">등록</a> <a class="button" onclick="checkDel()">삭제</a>
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

	<!-- Scripts -->
	<script src="../assets/js/jquery.min.js"></script>
	<script src="../assets/js/skel.min.js"></script>
	<script src="../assets/js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="../assets/js/main.js"></script>
</body>
</html>