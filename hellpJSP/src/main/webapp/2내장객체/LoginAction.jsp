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
		// name 속성의 값을 매개값으로 넘겨주면 value 속성의 값을 반환합니다.
		String id = request.getParameter("userid");
		String pw = request.getParameter("userpw");
		
		if("abc".equalsIgnoreCase(id) && "123".equals(pw)){

			response.sendRedirect("login.jsp?name="+id);
			out.print("로그인 성공");
	%>
			// html을 출력
			<h1>로그인 성공</h1>
	<%
		} else {
			out.print("로그인 실패");
		}
	%>
</body>
</html>