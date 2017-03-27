<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="stock" class="stock.Stock" />
<jsp:setProperty name="stock" property="*" />
<jsp:useBean id="sdao" class="stock.StockDao" />
<jsp:useBean id="manager" class="manager.Manager" />
<jsp:setProperty name="manager" property="*" />
<jsp:useBean id="mdao" class="manager.ManagerDao" />

<%
	// 컨트롤러 요청 action 코드값
	String action = request.getParameter("action");
	String managerId = (String) session.getAttribute("managerId");
	String materialUniqueKey = request.getParameter("materialUniqueKey");
	String orderAmount = request.getParameter("orderAmount");
	String putBasketUniqueKey = request.getParameter("putBasketUniqueKey");
	String orderUniqueKey=request.getParameter("orderUniqueKey");
	String volume = request.getParameter("volume");
	String materialUnitUniqueKey = request.getParameter("materialUnitUniqueKey");
	String minimum = request.getParameter("minimum");

	//장바구니 취소
	if (action.equals("cancel")) {
		if (sdao.putBasketCancel(Integer.parseInt(putBasketUniqueKey)))
			out.println("<script>alert('취소 되었습니다.');location.href='../salesstatus/SalesStatus.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}

	if (action.equals("addPutBasket")) {
		if (sdao.addPutBasket(managerId, Integer.parseInt(materialUniqueKey), Integer.parseInt(orderAmount)))
			out.println("<script>alert('주문 되었습니다.');history.go(-1);</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}
	
	if (action.equals("complete")) { 
		if (sdao.complete(Integer.parseInt(orderUniqueKey)))
			out.println("<script>alert('"+orderUniqueKey+"번 음료 제작완료');location.href='../salesstatus/SalesStatus.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}
 
	if (action.equals("addStock")) {
		if (sdao.addStock(managerId, Integer.parseInt(materialUniqueKey), Integer.parseInt(volume), Integer.parseInt(materialUnitUniqueKey), Integer.parseInt(minimum)))
			out.println("<script>alert('추가 되었습니다.');location.href='../stockstatus/NewStock.jsp'</script>");
		else
			out.println("<script>alert('실패하였습니다!!');history.go(-1);</script>");
	}
 %>