<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠키를 이용한 팝업창 제어 ver2.0</title>
<style>
    div#popup {
        position: absolute; top:100px; left:50px; color:yellow;  
        width:270px; height:100px; background-color:gray;
    }
    div#popup>div {
        position: relative; background-color:#ffffff; top:0px;
        border:1px solid gray; padding:10px; color:black;
    }
    .off{
    	display:none;
    }
</style>
<script>
// 페이지가 로드되면 실행
window.onload = function(){
	// 버튼이 클릭되면 함수를 실행
	closeBtn.onclick = function(){
		// 버튼이 클릭되면 팝업창 숨기기
		popup.style.display='none';
		
		var chkVal = document.querySelector("input[id=inactiveToday]:checked");
		
		if(chkVal != null && chkVal.value == 1){
			// 쿠키 생성
			console.log("쿠키생성 요청");
			fetch('PopupCookie.jsp')
			.then((data)=>data.json)
			.then((json) => {
				console.log("PopupCookie.jsp 호출");
			});
		}
	}
}
</script>
</head>
<body>
<%
String popupClose = CookieManager.readCookie(request, "PopupClose");
// 쿠키에 popupClose가 등록되어 있으면 class 속성을 이용해 팝업창을 출력하지 않도록 처리
String off = popupClose.equals("")? "" : "off";
%>
<h2>쿠키를 이용한 팝업창 제어 ver2.0</h2>
	<div id="popup" class="<%=off%>">
        <h2 align="center">공지사항 팝업입니다.</h2>
        <div align="right">
	        <form name="popFrm">
	            <input type="checkbox" id="inactiveToday" value="1" /> 
	            하루 동안 열지 않음
	            <input type="button" value="닫기" id="closeBtn" /> 
	        </form>
        </div>
    </div>
</body>
</html>