<%@page import="dto.Criteria"%>
<%@page import="dto.Board"%>
<%@page import="java.util.List"%>
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
	// 검색조건
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	String pageNo = request.getParameter("pageNo");
	
	// 검색어가 null인 경우 빈문자열로 치환(Criteria.java에서 처리해버림)
	// searchWord = searchWord == null ? "" : searchWord;
	
	/*
	if(searchWord == null){
		searchWord = "";
	}
	*/

	// 검색어가 null이 아니면 검색 기능을 추가!!!
	// out.print("검색어 : " + searchWord + "<br>");
	// out.print("검색필드 : " + searchField);

	// 검색조건 객체로 생성
	Criteria criteria = new Criteria(searchField, searchWord, pageNo);
	
	// 게시판 DB 작업 - DAO 생성
	BoardDao dao = new BoardDao();
	
	// 리스트 조회
	// List<Board> boardList = dao.getList(searchField, searchWord);
	List<Board> boardList = dao.getListPage(criteria);
	
	// 총 건수 조회
	int totalCnt = dao.getTotalCnt(criteria);
	
%>

<jsp:include page="Link.jsp"></jsp:include>

<h2>목록보기(List)</h2>

총 건수 : <%=totalCnt %>

<!-- 검색폼 -->
<form name='searchForm'>
<input type='text' name='pageNo' value='1'>
<table border="1" width="90%">
	<tr>
		<td align = "center">
			<select name = "searchField">
				<option value='title'>제목</option>
				<option value='content'>내용</option>
			</select>
			<input type="text" name="searchWord" value="<%=criteria.getSearchWord()%>">
			<input type="submit" value="검색하기">
		</td>
	</tr>
</table>
</form>

<table border='1' width="90%">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일</th>
	</tr>
	
<%
	if(boardList.isEmpty()){
		// 게시글이 하나도 없을때
%>
<tr>
	<td colspan="5" align="center"> 등록된 게시물이 없습니다.</td>
</tr>
<% 
} else { 
	for(Board board : boardList){
%>
	<tr>
		<td><%=board.getNum() %></td>
		<td><a href="View.jsp?num=<%=board.getNum() %>"><%=board.getTitle() %></a></td>
		<td><%=board.getId() %></td>
		<td><%=board.getVisitcount() %></td>
		<td><%=board.getPostdate() %></td>
	</tr>
	
<%
	} 
}
%>
</table>

<%
	if(session.getAttribute("UserId") != null){ 
%>
<table border="1" width="90%">
	<tr>
		<td align = "right">
			<input type="submit" value="글쓰기" onclick="location.href='Write.jsp'">
		</td>
	</tr>
</table>
<% } %>
<!-- 
페이지 블럭 생성 시작 
- 총 건수
- 쿼리 수정
- form의 이름을 searchForm으로 지정
- pageNO 필드를 생성
-->
<%
	PageDto pageDto = new PageDto(totalCnt,criteria);
%>
<table border="1" width="90%">
	<tr>
		<td align="center">
			<%@include file="PageNavi.jsp" %>
		</td>
	</tr> 
</table>
<!-- 페이지 블럭 생성 끝 -->
</body>
</html>