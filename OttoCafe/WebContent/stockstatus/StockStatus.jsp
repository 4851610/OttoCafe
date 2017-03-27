<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="stock.Stock"%>
<%@ page import="stock.StockDao"%>
<%!public Integer toInt(String x) {
		int a = 0;
		try {
			a = Integer.parseInt(x);
		} catch (Exception e) {
		}
		return a;
	}%>
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
<%
	StockDao sdao = new StockDao();
	ArrayList<Stock> list = sdao.stockStatus(managerId, pageno);
	int totalRecord = sdao.totalRecord(managerId);
%>
<%
	int total_record = totalRecord; //데이터베이스에서 가져온 값으로 변경해야됨
	int page_per_record_cnt = 5;
	int group_per_page_cnt = 5;

	int record_end_no = pageno * page_per_record_cnt;
	int record_start_no = record_end_no - (page_per_record_cnt - 1);
	if (record_end_no > total_record) {
		record_end_no = total_record;
	}

	int total_page = total_record / page_per_record_cnt
	+ (total_record % page_per_record_cnt > 0 ? 1 : 0);
	if (pageno > total_page) {
		pageno = total_page;
	}

	int group_no = pageno / group_per_page_cnt
	+ (pageno % group_per_page_cnt > 0 ? 1 : 0);
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
		next_pageno = total_page / group_per_page_cnt
		* group_per_page_cnt + 1;
	}
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
	border: 1;
	border-collapse: collapse;
	margin: 0 auto;
	vertical-align: middle;
}

span {
	font-weight: bold;
}
</style>
<script type="text/javascript">
	function order(materialUniqueKey) {
		var orderAmount = prompt('주문할 수량을 입력하세요.');
		location.href='../stockstatus/stockstatus_control.jsp?action=addPutBasket&orderAmount='+ orderAmount +'&materialUniqueKey='+materialUniqueKey+'';
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
						<!--  <li><a href="../mypage/NewMerchandise.jsp" >로그아웃</a></li>-->
					</ul>
				</header>

				<section>
					<header class="major">
						<strong style="font-size: 25px">재고 현황</strong>
					</header>
					<article>
						<table>
							<tr>
								<td><b>제품코드</b></td>
								<td><b>제품명</b></td>
								<td><b>총 용량</b></td>
								<td><b>단위</b></td>
								<td><b>제품이미지</b></td>
								<td><b>입고단가</b></td>
								<td><b>주문</b></td>
							</tr>
							<%
								for (Stock s : list) {
							%>
							<tr>

								<td><%=s.getMaterialUniqueKey()%></td>
								<td><%=s.getMaterialName()%></td>
								<td><%=s.getAmount()%></td>
								<td><%=s.getMaterialUnitName()%></td>
								<td><img src=<%=s.getImage()%> width="80px" height="80px"></td>
								<td><%=s.getPrice()%></td>
								<td><input type="button" value="주문"
									onclick="order(<%=s.getMaterialUniqueKey()%>)"></td>

							</tr>
							<%
								}
							%>



						</table>
						
						<br>

						<%
							for (int i = page_sno; i <= page_eno; i++) {
						%>
						<a href="../stockstatus/StockStatus.jsp?pageno=<%=i%>"> <%
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
						<br> <br>
						<input type="button" onclick="location.href='../stockstatus/NewStock.jsp'" value="재고 등록">
					</article>
				</section>
			</div>
		</div>

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
									class="sans-serif" style="font-size: 18px">재고 조회</a></li>
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
	<script src="../assets/js/main.js"></script>
</body>
</html>