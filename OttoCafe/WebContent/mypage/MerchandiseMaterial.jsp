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
	
	int uniqueKey = Integer.parseInt(request.getParameter("uniqueKey"));
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

	function cancelbutton() {
		self.opener = self;
		window.close();
	}
</script>
</head>
<body>
	<header>
		<h2>재료 추가</h2>
	</header>
	<section>
		<form name="addMerchandiseMaterial"
			action="../mypage/mypage_control.jsp?action=newMerchandiseMaterial&uniqueKey=<%=uniqueKey%>"
			method="post">
			<table>
				<tr>
					<td>재료명</td>
					<td><select id="materialUniqueKey" name="materialUniqueKey">

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
						name="materialUnitUniqueKey">

							<%
								for (Stock s : list3) {
							%>
							<option value="<%=s.getMaterialUnitUniqueKey()%>"><%=s.getMaterialUnitName()%></option>
							<%
								}
							%>
					</select></td>
				</tr>
			</table>
			<br> * 숫자만 입력하세요. <br> <br> <input type="image"
				src="../image/ok_small.jpg" id="재료 등록"> <img
				src="../image/cancle_small.jpg" onClick="cancelbutton()">
		</form>

	</section>
	<footer></footer>
</body>
</html>