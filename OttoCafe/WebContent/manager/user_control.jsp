<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="manager" class="manager.Manager" />
<jsp:setProperty name="manager" property="*" />
<jsp:useBean id="mdao" class="manager.ManagerDao" />

<%
	// 컨트롤러 요청 action 코드값
	String action = request.getParameter("action");
	String managerId = request.getParameter("managerId");

	//아이디 중복확인
	if (action.equals("idcheck")) {
		if (mdao.checkId(managerId))
			out.println("<script>alert('사용중인 아이디입니다!');history.go(-1);key=0;</script>");
		else
			out.println("<script>alert('사용가능한 아이디입니다!');history.go(-1);key=1;</script>");
	}

	// 신규 회원등록
	if (action.equals("new")) {
		if (mdao.addManager(manager))
			out.println("<script>alert('정상적으로 등록 되었습니다. 로그인 하세요!!');location.href='../manager/Login.jsp'</script>");
		else
			out.println("<script>alert('회원가입에 실패하였습니다!!');history.go(-1);</script>");
	}
	// 로그인
	if (action.equals("login")) {
		if (mdao.login(manager.getManagerId(), manager.getManagerPW())) {
			session.setAttribute("managerId", manager.getManagerId());
			response.sendRedirect("../salesstatus/SalesStatus.jsp");
		} else {
			out.println("<script>alert('아이디나 비밀번호가 틀렸습니다.!!');history.go(-1);</script>");
		}
	}
	// 로그아웃
	if (action.equals("logout")) {
		// 세션에 저장된 값 초기화
		session.removeAttribute("managerId");
		response.sendRedirect("../manager/Login.jsp");
	}
	
	//아이디 찾기
	
%>