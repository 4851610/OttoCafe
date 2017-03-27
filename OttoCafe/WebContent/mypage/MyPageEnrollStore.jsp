<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="store.Store"%>
<%@ page import="store.StoreDao"%>
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
	StoreDao sdao = new StoreDao();
	ArrayList<Store> list = sdao.StoreList();
	int totalRecord = sdao.totalRecord();
%>
<%
	int total_record = totalRecord;
	int page_per_record_cnt = 10;
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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>오또카페</title>
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />

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
			document.deleteStore.submit();
		} else {
			alert('삭제할 상품을 선택하세요.');
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
						<strong style="font-size: 25px">거래처 조회</strong>
					</header>

					<article>

						<div class="content">
							<form name="deleteStore" method="post"
								action="../mypage/mypage_control.jsp?action=materialStoreDelete"
								id="delete">
								<table class="tg" style="table-layout: fixed; width: 680px">

									<colgroup>
										<col style="width: 50.111111px">
										<col style="width: 92.111111px">
										<col style="width: 113.111111px">
										<col style="width: 230.111111px">
										<col style="width: 127.111111px">
										<col style="width: 67.111111px">
									</colgroup>
									<tr>
										<td><b>선택</b></td>
										<td><b>거래처 코드</b></td>
										<td><b>거래처명</b></td>
										<td><b>거래처 홈페이지</b></td>
										<td><b>전화번호</b></td>
										<td><b>대표자명</b></td>
									</tr>

									<%
										for (Store s : list) {
									%>

									<tr>

										<td><input type="checkbox" name="select"
											value=<%=s.getStoreUniqueKey()%>></td>
										<td><%=s.getStoreUniqueKey()%></td>
										<td><%=s.getStoreName()%></td>
										<td><a href=<%=s.getStoreHomepage()%> target="_blank"><%=s.getStoreHomepage()%></a></td>
										<td><%=s.getStoreTel()%></td>
										<td><%=s.getStoreRepresentative()%></td>
									</tr>

									<%
										}
									%>

								</table>
								<%
									for (int i = page_sno; i <= page_eno; i++) {
								%>
								<a href="../mypage/MyPageEnrollStore.jsp?pageno=<%=i%>"> <%
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
								<br> <br> <a href="../mypage/NewStore.jsp"
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