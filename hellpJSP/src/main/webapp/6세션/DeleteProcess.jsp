<%@page import="common.JSFunction"%>
<%@page import="dto.Board"%>
<%@page import="dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
	request.setCharacterEncoding("utf-8");
	
	String num = request.getParameter("num");
	out.print(num);
	
	BoardDao dao = new BoardDao();
	int res = dao.delete(num);
	
	if(res > 0){
		// 성공 : 메세지 출력 상세페이지로 이동
		JSFunction.alertLocation("삭제완료", "Board.jsp", out);
	} else {
		// 실패 : 메세지 출력
		JSFunction.alertBack("삭제 중 오류가 발생했습니다.", out);
	}
%>	
</body>
</html>