<%@page import="dto.Criteria"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
<%@page import="dao.NewBoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
</head>
<%
	// 검색조건
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	
	// 페이지 번호
	int pageNo = request.getParameter("pageNo")==null
			? 1:Integer.parseInt(request.getParameter("pageNo"));
	
	Criteria criteria = new Criteria(searchField, searchWord, pageNo);
	
	NewBoardDao dao = new NewBoardDao();
	List<Board> list = dao.getList(criteria);
%>
<body>
<%@include file="../6세션/Link.jsp" %>
	<h1>new</h1>
    <h2>목록 보기(List)</h2>
    <!-- 검색폼 --> 
    <form method="get">  
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
    <!-- 게시물 목록 테이블(표) --> 
    <table border="1" width="90%">
        <!-- 각 칼럼의 이름 --> 
        <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
        <!-- 목록의 내용 -->
<%
	if(list.isEmpty()){
		// 게시글이 하나도 없으면
%> 
<tr>
	<td colspan="5" align="center">등록된 게시물 없음</td>
</tr>
<%
	} else {
		// 리스트목록을 돌면서 board객체를 꺼내옵니다
		for(Board board : list){
%>
        <tr align="center">
            <td><%=board.getNum() %></td>  <!--게시물 번호-->
            <td align="left">  <!--제목(+ 하이퍼링크)-->
                <%=board.getTitle() %> 
            </td>
            <td align="center"><%=board.getId() %></td>          <!--작성자 아이디-->
            <td align="center"><%=board.getVisitcount() %></td>  <!--조회수-->
            <td align="center"><%=board.getPostdate() %></td>    <!--작성일-->
        </tr>
<% 
	}
}
%>
    </table>
    <!--목록 하단의 [글쓰기] 버튼-->
    <%
    if(session.getAttribute("UserId") != null
    	&& !"".equals(session.getAttribute("UserId"))){ 
    %>
    <table border="1" width="90%">
        <tr align="right">
            <td><button type="button">글쓰기</button></td>
        </tr>
    </table>
	<% } %>
</body>
</html>
