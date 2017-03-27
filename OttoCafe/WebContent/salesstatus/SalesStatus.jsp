<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="sales.Sales"%>
<%@ page import="sales.SalesDao"%>
<%@ page import="stock.Stock"%>
<%@ page import="stock.StockDao"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>


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
%>
<%
	Date d = new Date();
	String clock = d.toString();

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String today = sdf.format(d);

	Calendar cal = Calendar.getInstance();//오늘 날짜를 기준으루..

	String date1 = request.getParameter("date1");
	String date2 = request.getParameter("date2");

	if (date1 == null || date1.equals("")) {
		date1 = today;
	} else if (date1.equals("mon1")) {
		cal.add(Calendar.MONTH, -1);
	} else if (date1.equals("mon3")) {
		cal.add(Calendar.MONTH, -3);
	} else if (date1.equals("mon6")) {
		cal.add(Calendar.MONTH, -6);
	} else if (date1.equals("total")) {
		cal.add(Calendar.YEAR, -6);
	}

	date1 = sdf.format(cal.getTime());

	int pageno = toInt(request.getParameter("pageno"));
	if (pageno < 1) {
		pageno = 1;
	}
%>
<%
	SalesDao sdao = new SalesDao();
	ArrayList<Sales> list = sdao.getAll(managerId, date1, today);
	ArrayList<Sales> orderLists = sdao.selectOrder();
%>
<%
	StockDao stockdao = new StockDao();
	ArrayList<Stock> list2 = stockdao.stockList(managerId);
	int i = 0;
%>
<%
	StockDao sdao2 = new StockDao();
	ArrayList<Stock> list3 = sdao2.cartList(managerId);
	int totalRecord = sdao2.totalRecord(managerId);
%>

<%
	int total_record = totalRecord; //데이터베이스에서 가져온 값으로 변경해야됨
	int page_per_record_cnt = 3;
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
<title>오또카페</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link href="../assets/css/main.css" rel="stylesheet" type="text/css">
<link rel="shortcut icon" type="image/x-icon"
	href="../image/favicon.ico" />
<style>
body {
	margin: 0px auto;
}

header {
	margin: 0 auto;
	text-align: center;
}

table {
	text-align: center;
	vertical-align: middle;
	margin: 0 auto;
}

footer {
	text-align: center;
}

#s img {
	vertical-align: middle;
}

section {
	text-align: center;
}

path {
	stroke: #fff;
}

path:hover {
	opacity: 0.9;
}

rect:hover {
	fill: blue;
}

.axis {
	font-size: 10px;
}

.legend tr {
	border-bottom: 1px solid grey;
}

.legend tr:first-child {
	border-top: 1px solid grey;
}

.axis path, .axis line {
	fill: none;
	stroke: #000;
	shape-rendering: crispEdges;
}

.x.axis path {
	display: none;
}

.legend {
	margin: 0px auto;
	margin-bottom: 200px;
	display: inline-block;
	border-collapse: collapse;
	border-spacing: 0px;
	opacity: 0.8;
}

.legend td {
	padding: 4px 5px;
	vertical-align: bottom;
}

.legendFreq, .legendPerc {
	align: bottom;
	width: 50px;
}

.axis path, .axis line {
	fill: none;
	stroke: black;
	shape-rendering: crispEdges;
}

.axis text {
	font-size: 10px;
}

a {
	text-decoration: none;
}
</style>

<script type="text/javascript">
	setTimeout("history.go(0)", 50000);
	
	<!-- function salesGraph(date) {
		location.href="../salesstatus/graph_control.jsp?action=graphReload"+date+"";
	} -->
</script>
<script type="text/javascript">

function cancel_click(putBasketUniqueKey) {
	location.href='../stockstatus/stockstatus_control.jsp?action=cancel&putBasketUniqueKey='+putBasketUniqueKey+'';
}

function complete(orderUniqueKey) {
	location.href='../stockstatus/stockstatus_control.jsp?action=complete&orderUniqueKey='+orderUniqueKey+'';
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
				<header id=header>
					<a style="text-align: left; font-size: 20px;" class="icon fa-home"
						href="../salesstatus/SalesStatus.jsp?date1=<%=today%>&date2=<%=today%>"><strong> 오또카페
							재고관리 프로그램 </strong></a>
					<ul class="icons">
						<li><a href="../manager/user_control.jsp?action=logout"
							style="margin-right: 20px">로그아웃</a></li>
						<!--  <li><a href="../mypage/NewMerchandise.jsp" >로그아웃</a></li>-->
					</ul>
				</header>

				<!-- Banner -->
				<section id="banner">

					<div class="content">
						<header class="major" style="text-align: left;">
							<strong style="font-size: 25px;">판매 현황</strong>
						</header>
						<table style="width:300px;">
							<tr>
								<td><a
									href="../salesstatus/SalesStatus.jsp?date1=<%=today%>&date2=<%=today%>">당일</a></td>
								<td><a
									href="../salesstatus/SalesStatus.jsp?date1=mon1&date2=<%=today%>">한달</a></td>
								<td><a
									href="../salesstatus/SalesStatus.jsp?date1=mon3&date2=<%=today%>">3개월</a></td>
								<td><a
									href="../salesstatus/SalesStatus.jsp?date1=mon6&date2=<%=today%>">6개월</a></td>
								<td><a
									href="../salesstatus/SalesStatus.jsp?date1=total&date2=<%=today%>">전체</a></td>
							</tr>
						</table>


						<div id='dashboard'></div>

					</div>
					<form name="deleteMer" method="post"
								action="../stockstatus/stockstatus_control.jsp?action=complete"
								id="delete">
						<span class="content"> <header class="major"
								style="text-align: left;">
								<strong style="font-size: 25px">주문 내역</strong>
							</header>

							<table class="tg" style="table-layout: fixed; width: 582px">
								<colgroup>
									<col style="width: 76.111111px">
									<col style="width: 211.111111px">
									<col style="width: 52.111111px">
									<col style="width: 115.111111px">
								</colgroup>

								<tr>
									<td><b>주문번호</b></td>
									<td><b>메뉴명</b></td>
									<td><b>개수</b></td>
									<td><b>제작확인</b></td>
								</tr>

								<%
									for (int z = 0; z < orderLists.size(); z++) {
								%>
								<%
									String[] menus = orderLists.get(z).getOrderMenus().split("\\|");
								%>
								<%
									String[] counts = orderLists.get(z).getOrderCounts().split("\\|");
								%>
								<tr>
									<td><%=orderLists.get(z).getOrderUniqueKey()%>
									<td>
										<%
											for (int m = 0; m < menus.length; m++) {
										%> <%=menus[m]%> <br /> <%
 	}
 %>
									</td>
									<td>
										<%
											for (int m = 0; m < counts.length; m++) {
										%> <%=counts[m]%> <br /> <%
 	}
 %>
									</td>
									<td><input type="button"
										id="<%=orderLists.get(z).getOrderUniqueKey()%>"
										onclick="complete(<%=orderLists.get(z).getOrderUniqueKey()%>);"
										value="제작완료" /></td>
								</tr>
								<%
									}
								%>

							</table>


						</span>
					</form>
					<br> <br> <br> <br>



				</section>


				<!-- Banner -->
				<section id="banner">

					<div class="content">
						<header class="major" style="text-align: left;">
							<strong style="font-size: 25px">재고 현황</strong>
						</header>
						<div id='div'></div>
					</div>
					<span class="content"> <header class="major"
							style="text-align: left;">
							<strong style="font-size: 25px">장바구니 목록</strong>
						</header>
						<table class="tg" style="table-layout: fixed; width: 582px">
							<colgroup>
								<col style="width: 69.111111px">
								<col style="width: 100.111111px">
								<col style="width: 97.111111px">
								<col style="width: 75.111111px">
								<col style="width: 75.111111px">
								<col style="width: 61.111111px">
								<col style="width: 70.111111px">
							</colgroup>
							<tr>
								<td><b>제품코드</b></td>
								<td><b>제품명</b></td>
								<td><b>제품 이미지</b></td>
								<td><b>입고단가</b></td>
								<td><b>주문수량</b></td>
								<td><b>총 가격</b></td>
								<td><b>주문</b></td>
							</tr>
							<%
								for (Stock s : list3) {
							%>
							<tr>
								<td><%=s.getMaterialUniqueKey()%></td>
								<td><%=s.getMaterialName()%></td>
								<td><img src=<%=s.getImage()%> width="80" height="80"></td>
								<td><%=s.getPrice()%></td>
								<td><%=s.getAmount()%></td>
								<td><%=s.getTotal()%></td>


								<td><input type="button" id="<%=s.getMaterialUniqueKey()%>"
									onclick="cancel_click(<%=s.getPutBasketUniqueKey()%>);"
									value="취소" /></td>
							</tr>
							<%
								}
							%>
						</table>
					</span>
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
	<script src="http://d3js.org/d3.v3.min.js"></script>
	<script>
	function dashboard(id, fData){
	    var barColor = d3.scale.ordinal().range(["#EA2E49", "#F6F792", "#DAEDE2", "#77C4D3", "#FF8598", "#046380", "#98abc5", "#8a89a6"]);
	    function segColor(c){ return {total:"#41ab5d"}[c]; }
	    
	    // compute total for each state.
	    fData.forEach(function(d){d.total=d.freq.total;});
	    
	    // function to handle histogram.
	    function histoGram(fD){
	        var hG={},    hGDim = {t: 60, r: 0, b: 30, l: 0};
	        hGDim.w = 400 - hGDim.l - hGDim.r, 
	        hGDim.h = 300 - hGDim.t - hGDim.b;
	            
	        //create svg for histogram. id:dashboard
	        var hGsvg = d3.select(id).append("svg")
	            .attr("width", hGDim.w + hGDim.l + hGDim.r)
	            .attr("height", hGDim.h + hGDim.t + hGDim.b).append("g")
	            .attr("transform", "translate(" + hGDim.l + "," + hGDim.t + ")");

	        // create function for x-axis mapping.
	        var x = d3.scale.ordinal().rangeRoundBands([0, hGDim.w], 0.1)
	                .domain(fD.map(function(d) { return d[0]; }));

	        // Add x-axis to the histogram svg.
	        hGsvg.append("g").attr("class", "x axis")
	            .attr("transform", "translate(0," + hGDim.h + ")")
	            .call(d3.svg.axis().scale(x).orient("bottom"));

	        // Create function for y-axis map.
	        var y = d3.scale.linear().range([hGDim.h, 0])
	                .domain([0, d3.max(fD, function(d) { return d[1]; })]);

	        // Create bars for histogram to contain rectangles and freq labels.
	        var bars = hGsvg.selectAll(".bar").data(fD).enter()
	                .append("g").attr("class", "bar");
	        
	        //create the rectangles.
	        bars.append("rect")
	            .attr("x", function(d) { return x(d[0]); })
	            .attr("y", function(d) { return y(d[1]); })
	            .attr("width", x.rangeBand())
	            .attr("height", function(d) { return hGDim.h - y(d[1]); })
	            .attr('fill',barColor)
	            
	        //Create the frequency labels above the rectangles. 각 음료당 판매 개수 출력
	        bars.append("text").text(function(d){ return d3.format(",")(d[1])})
	            .attr("x", function(d) { return x(d[0])+x.rangeBand()/2; })
	            .attr("y", function(d) { return y(d[1])-5; })
	            .attr("text-anchor", "middle");
	    }	    
	    
	    // calculate total frequency by state for all segment.
	    var sF = fData.map(function(d){return [d.State,d.total];});

	    var hG = histoGram(sF)
	}
	</script>

	<script>
		var freqData = [ <%for (Sales s : list) {%> {
			State : '<%=s.getMerchandiseName()%>',
			freq : {
				total : <%=s.getCount()%>,
				mid : 0, 
				high : 0
			}
		},
		<%}%>];

		dashboard('#dashboard', freqData);
	</script>

	<!-- 재고 그래프 -->
	<script>
		function div(id, dataset) {
			//Width and height
			var w = 400;
			var h = 300;
			
			//Set up stack method
			var stack = d3.layout.stack();

			//Data, stacked
			stack(dataset);
			
			var materialNames = [ <%for (Stock s : list2) {%> "<%=s.getMaterialName()%>",<%}%>];
			 
			var x = d3.scale.ordinal().rangeRoundBands([0, 400], 0.1)
            .domain(materialNames);

			//Set up scales
			var xScale = d3.scale.ordinal()
				.domain(d3.range(dataset[0].length))
				.rangeRoundBands([0, w], 0.1);
		
			var yScale = d3.scale.linear()
				.domain([0,100
				]) 
				.range([0, h-30]);
			
			var xAxis = d3.svg.axis().scale(xScale).orient("bottom"); //yScale
			
			//y축
			var yAxis = d3.svg.axis().scale(yScale).orient("left");
				
			//Easy colors accessible via a 10-step ordinal scale
			var colors = d3.scale.ordinal().range(["#3498DB", "#E74C3C"]);
		
			//Create SVG element
			var svg = d3.select("#div")
						.append("svg")
						.attr("width", w)
						.attr("height", h);
			
			
			// Add a group for each row of data
			var groups = svg.selectAll("g")
				.data(dataset)
				.enter()
				.append("g").attr("class","axis").call(yAxis).style("fill", function(d, i) {
					return colors(i);
				});

			// Add a rect for each data value
			var rects = groups.selectAll("rect")
				.data(function(d) { return d; })
				.enter()
				.append("rect")
				.attr("x", function(d, i) {
					return xScale(i);
				})
				.attr("y", function(d) {
					return yScale(d.y0);
				})
				.attr("height", function(d) {
					return yScale(d.y);//150; //210
				})
				.attr("width", xScale.rangeBand());
			
			svg.append("g").attr("class", "x axis")
            .attr("transform", "translate(0," + 270 + ")")
            .call(d3.svg.axis().scale(x).orient("bottom"));
			
		}
		</script>

	<script>
		var dataset = [
		    			[ <%for (Stock s : list2) {%> 
		    				{ x: <%=i%>, y: <%=s.getUsable()%> },
		    				<%i += 1;
			}%>
		    			],
		    			[ <%for (Stock s : list2) {%>
		    				{ x: <%=i%>, y: <%=s.getPercentage()%> },
		    				<%i += 1;
			}%>
		    			]
		    		  ];

		div('#div', dataset);
	</script>

	<script src="../assets/js/jquery.min.js"></script>
	<script src="../assets/js/skel.min.js"></script>
	<script src="../assets/js/util.js"></script>
	<script src="../assets/js/main.js"></script>

</body>
</html>