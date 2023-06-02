<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style><%@ include file = "css/gogreen.css" %></style>
</head>
<body> 
    <div class="wrap">

        <%@ include file = "header.jsp" %>
        
        <main>
            <aside id='leftside'>

            </aside>
            <div id='maincontent'>
                <ul>
                    <li><img src="images/main_img1.jpg" alt="">ëë¬´ë¥¼ ì¬ë ì¬ëë¤</li>
                    <li><img src="images/main_img2.jpg" alt="">ìì´ë¤ìê² ë¹ì ë¯¸ëë¥¼..</li>
                    <li><img src="images/main_img3.jpg" alt="">ì¤ìì°ì ì¬ë¦¬ë ê¸¸</li>
                    <li><img src="images/main_img4.jpg" alt="">ì¬ë¼ì§ë ë¶ê·¹ê³°ë¤</li>
                </ul>
            </div>

            <aside id='rightside'>
                <div class='side1'>
                    <div class='loginbox'>
                        <div id='login'>
                            <input type="text" name="userid" id="userpw" placeholder='IDë¥¼ ìë ¥í´ì£¼ì¸ì.'>
                            <input type="password" name="userpw" id="userpw" placeholder='PWë¥¼ ìë ¥í´ì£¼ì¸ì.'>
                        </div>
                        <div id='button'>
                        <input type="submit" value="ë¡ê·¸ì¸">
                        </div>
                    </div>
                    <div id='info'>
                        <a href="">íìê°ì</a>
                        <a href="">IDì°¾ê¸°</a>
                        <a href="">PWì°¾ê¸°</a>
                    </div>
                </div>

                <div class='side2'>
                    <img src="images/right_img.jpg" alt="">
                </div>

                <div class='side3'>
                    <img src="images/me_chat.jpg" alt="">
                </div>
            </aside>
        </main>        
	<%@ include file = "footer.jsp" %>
    </div>
</body>
</html>