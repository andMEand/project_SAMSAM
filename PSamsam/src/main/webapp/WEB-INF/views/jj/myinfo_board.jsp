<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.project.samsam.member.MemberVO"%>
<%@ page import="com.project.samsam.board.JJABoardVOto"%>
<%@ page import="com.project.samsam.board.JJABoardVO"%>
<%@ page import="com.project.samsam.board.JJWarningVO"%>
<%@ page import="com.project.samsam.board.JJCommentVO"%>

<% String email=(String) session.getAttribute("email"); 

//email.toUpperCase();
	if ((session.getAttribute("email") == null) || (((String) session.getAttribute("email")).equals("admin"))) {
		out.println("<script>");
		out.println("location.href='loginForm.me'");
		out.println("</script>");
	}
  List<JJABoardVOto> commuList = (List<JJABoardVOto>)request.getAttribute("commuList");
  List<JJCommentVO> commenList = (List<JJCommentVO>)request.getAttribute("commenList");

    
	

%>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="resources/img/title.png" rel="shortcut icon" type="image/x-icon">
<title>삼삼하개</title>
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300&display=swap" rel="stylesheet">

<!-- 아이콘 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" integrity="sha512-+4zCK9k+qNFUR5X+cKL9EIR+ZOhtIloNl9GIKS57V1MyNsYpYcUrUeQc9vNfzsWfV28IaLL3i96P9sdNyeRssA==" crossorigin="anonymous" />

<!-- 부트스트랩 4.0 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="resources/css/my_member.css" rel="stylesheet" >
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous"></script>
<script type="text/javascript" src="resources/js/myinfo_member.js" charset="UTF-8"></script> 
<!-- 스윗얼럿 -->
<script src = "https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
@charset "utf-8";
/* 공통으로 사용하는 CSS */

* {
   margin:0;
   padding: 0;
}
html{
   margin:0 auto;
   width : 100%;
   height: 100%;
    overflow: auto;
}


body {
   margin: 0;
   height: auto;
    min-height : 600px;
    box-sizing : content-box;
   line-height: 1.7;
    color: gray;
      font-family: 'Noto Sans KR', sans-serif;
    font-weight: 300;
    font-size: .9rem;
}


a{
   text-decoration : none;
   color : #9494b8;
}
a:hover {
    color: #0056b3;
    text-decoration: none;
}

body {
   text-align: -webkit-center;
   display : flex;
   flex-direction : column;
   justify-content : space-between;
}

.body_content{
     margin : 0;
     padding : 0;
     width : 100%;
     height:100vh;
    display : flex;
    flex-direction : column;
}

#header {
    width: 100%;
    height: 190px;
    box-sizing: content-box;
    display: flex;
    flex-direction: column;
    border-bottom: 1px solid #efefef;
    padding-bottom: 20px;
    background-color : #fff;
    position : fixed;
      z-index : 10000;
    top : 0;
    left : 0;
    right : 0;
}

.inout_gocen{
   position : inline;
   display : flex;
   justify-content : flex-end;
   margin-top : 20px;
   margin-right : 340px;
   background-color : #fff;
}
.fixinner{
   position: fixed; 
}
.header-top {
   margin-top : -10px;
   display : flex;
   justify-content : flex-start;
   margin-right: auto;
}
.header_btn{
   width : 70px;
   height : 30px;
   background-color : #fff;
   color : #9494b8;
    border-radius: 5px;
    border : none;
    outline : 0;
}
.header_btn:hover{
   color : #6200cc;
   font-weight: 700;
}
#logout, #mypage{
   display : none;
}
.img-circle{
   width : 450px;
   height : 150px;
   display: block;
   margin : 0 auto;
}
.nav-menu{
   margin : 0 auto;
   display : flex;
   justify-content : space-around;
   align-items: baseline;
   width: 1200px;
}
.sticky-wrapper{
   width: 400px;
   height: 50px;
   margin : 0;
   margin-left: 0;
     position: sticky;
     list-style : none;
    display : flex;
    padding: 0;
}

.sticky-wrapper > li{
   padding : 8px 8px;
   list-style-type:none;
   float: left;
}
.sticky-wrapper > ul{
   padding : 8px 8px;
}

li.dropdown {
    color: #9494b8;
    background: #fff;
    transition: .3s all ease;
    font-size: 20px;
    width: 90px;
    height: 50px;
}

.sticky-wrapper.active{
   position: fixed;
    top: 0px;
}

/* dropdown */
.dropdown-menu {
   display: none;
      justify-content : flex-start;
   position: absolute;
   list-style : none;
    visibility: visible;
    background-color: #fff;
   width: 1200px;
   top : 52px;
   margin-left : -30px;
   border: none;
}

.board {
	padding-left: 46px;
}
.care {
	padding-left: 30px;
}
.commu {
	padding-left: 35px;
}

li.dropdown > a {
    text-decoration: none;
}

.dropdown-menu li{
   margin-right : 40px;
}
.dropdown:hover .dropdown-menu { 
   display: flex; 
   visibility: visible; 
}

/* search-wrapper */
.search-wrapper {
  padding : 5px;
  width: 280px;
  height: 38px;
  display: flex;
  justify-content : space-betwwen;
  background: #fff;
  border: 2px solid #9494b8;
  border-radius: 10px;
}
.search-box {
  height : 100%;
  padding: 0;
  border: none;
  background: #fff;
}
.search-box.input {
  width : 80%;
  margin-left : 15px;
  font-size : .9rem;
}
.search-box.input:focus {outline:none;}

.search-box.btn {
  color : #9494b8;
  text-align : left; 
}

/* search-wrqpper */

.main-content{
   width : 100%;
   height : auto;
   margin : 0 auto;
}


/* footer */
#footer {
    margin: 0 auto;
    width: fit-content;
    bottom: 20px;
    position: relative;
}

p{
   text-align : center;
}
.fa-heart{
   color : red;
}

/* pageup button */
.back-to-top{
   width : 40px;
   height : 40px;
   margin : 0 auto;
   font-size : 24px;
   color : white;
   background-color : #149DDD;
   border-radius : 50%;
   visibility : visible;
   position: fixed; 
   bottom: 45px; 
   right: 30px;
   text-align : center;
}
/* pageup button */
*, ::after, ::before {
    box-sizing: border-box;
}


/*카카오톡 톡상담*/
.kakaoChat {
    text-align: right;
    position: fixed;
    margin-right: 28px;
    bottom: 90px;
    right: 0;
}
.kakao_btn {
	border-radius: 1rem!important;
}

/* side menu와 내용 묶음 */
.content-wrap {
	width: 1200px;
	min-height: 100%;
	margin: 0 auto;
	position: relative;
	top: 50px;
	
}
/* side menu 틀*/
.sidemenu-section {
    width: 200px;
    font-size: 18px;
    text-align: left;
    min-height: 740px;
    border-right-color: darkblue;
    border-right: 1px solid #efefef;
    padding: 0px 0px 0 0;
    margin-left: 0;
    margin-top: 210px;
    position: fixed;
}


/* 내용 틀*/
.content-section {
    width: 1001px;
    height: max-content;
    position: relative;
    left: 100px;
    text-align: left;
    font-size: 14px;
    margin-top: 0px;
    color: black;
    margin-left: 0;
    padding-bottom: 100px;
    border-left-color: darkblue;
    border-left: 1px solid #efefef;
    padding-left: 50px;
    padding-right: 0;
    min-height: 940px;
    padding-top: 200px;
}

/* 각각의 페이지에서 사용할 CSS */
.list-group {
	border-bottom: 1px solid rgba(0,0,0,.125);
}
.list-group-item {
    position: relative;
    display: block;
    padding: .75rem 1.25rem;
    margin-bottom: -1px;
    background-color: white;
    border: 1px solid rgba(0,0,0,.125);
}
/* 현재 페이지의 서브메뉴 */
li.list-group-item.click > a {
    font-weight: bold;
    color: #5c5c8a;
}

.list-group-item > a {
	text-decoration : none;
	}

</style>
</head>

<body>
<body>
<div class ="body_content">
<header id = "header">

	<div class ="inout_gocen">
			<input type="button" class= "header_btn" id="login" value="로그인" onclick ="location.href='loginForm.me'">
			<input type="button" class= "header_btn" id="logout" value="로그아웃" onclick ="location.href='logout.me'">
			<input type="button" class= "header_btn" id="signin" value="회원가입" onclick ="location.href='joinform.me'">
			<input type="button" class= "header_btn" id="mypage" value="마이페이지" onclick ="location.href='mypage.me'">
			<input type="button" class= "header_btn" id="gocen" value="고객센터" onclick ="location.href='customer_service.me'">
		</div>
	
	 <div class="nav-menu">
            <ul class="sticky-wrapper">
               <li class="dropdown"><a href="home.me">HOME</a></li>
               <li class="dropdown"><a href="home_list.bo">분양</a>
                  <ul class="dropdown-menu">
                     <li><a href="home_list.bo">&nbsp;&nbsp;가정분양</a></li>
                     <li><a href="fdoclist.bo">책임분양</a></li>
                     <li><a href="selladopt_list.bo">업체분양</a></li>
                  </ul></li>
               <li class="dropdown"><a href="/SJ/pet_list">보호소</a>
                  <ul class="dropdown-menu">
                     <li><a href="/SJ/pet_list">&nbsp;&nbsp;&nbsp;&nbsp;보호소</a></li>
                     <li><a href="/SJ/payang/list">파양</a></li>
                     <li><a href="/SJ/missing/list">실종</a></li>
                  </ul></li>
               <li class="dropdown"><a href="doclist.bo">커뮤니티</a>
                  <ul class="dropdown-menu">
                     <li><a href="doclist.bo">&nbsp;자유게시판</a></li>
                     <li><a href="auth_fdoc.bo">책임분양인증</a></li>
                  </ul></li>
            </ul>
	<div class="header-top">
		<div class="mainlogo">
		<a href="home.me">
		<img src = "resources/img/mainlogo.png" class = "img-circle">
		</a>
		</div>
	</div>
	<div class= "search-wrapper">
      <input class="search-box input" type="text" placeholder="Search">
      <button class="search-box btn" type="button"><i class="fas fa-search"></i></button>
	</div>
	</div><!-- nav-menu -->
</header>

<div class="main_content">  <!-- 2 -->
	<!-- 메인컨텐트 -->
 <div class="content2">
     <div class="w_btnlist">
             
	<div id="ud_tab">

		  <input type="radio" name="ud_tabs" id="tab1" checked>
		  <label for="tab1">작성글</label>
		
		  <input type="radio" name="ud_tabs" id="tab2">
		  <label for="tab2">작성댓글</label>
		
		  <div id="ud_tab-content1" class="ud_content">
		  <table>
		  	<thead>
		  		<tr><th>글번호</th><th>제목</th><th>작성일</th></tr>
		  	</thead>
		  	<tbody>
		    <% 
		    	if(commuList != null){
		    		for(JJABoardVOto commu_list : commuList){	
		    %>
		    	<tr class = "board" onMouseOver="this.style.backgroundColor='#eceff1';" onMouseOut="this.style.backgroundColor=''">
		    	

		    		<td><a href="javascript:void(0);" onclick="war_detail(this);" ww_no ='<%=commu_list.getDoc_email()%>'><%=commu_list.getDoc_email() %></a></td>
		    		<td><a href="javascript:void(0);" onclick="war_detail(this);" ww_no ='<%=commu_list.getDoc_email()%>'><%=commu_list.getDoc_subject() %></a></td>
		    		<fmt:formatDate var="formatDate" value="<%=commu_list.getDoc_date() %>" pattern="yyyy-MM-dd"/>
		    		<td><a href="javascript:void(0);" onclick="war_detail(this);" ww_no ='<%=commu_list.getDoc_email()%>'>${formatDate}</a></td>
		    	</tr>
		    <% }}
		    else{%>
		    	<tr>
		    	<td colspan="4"> 작성글이 없습니다</td>
		    	</tr>
		    	<%} %>
		    </tbody>
		   </table>
		   <div class="error1">
 			 </div>
 		 </div>
 		 
		  <div id="ud_tab-content2" class="ud_content">
		    <table>
		  	<thead>
		  		<tr><th>글번호</th><th>제목</th><th>작성일</th></tr>
		  	</thead>
		  	<tbody>
		    <% 
		    	if(commenList != null){
		    		for(JJCommentVO co_list : commenList){	
		    %>
		    	<tr class = "comment"onMouseOver="this.style.backgroundColor='#eceff1';" onMouseOut="this.style.backgroundColor=''">
		    		<td><a href="javascript:void(0);" onclick="war_detail(this);" ww_no ='<%=co_list.getDoc_email()%>'><%=co_list.getDoc_email() %></a></td>
		    		<td><a href="javascript:void(0);" onclick="war_detail(this);" ww_no ='<%=co_list.getDoc_cno()%>'><%=co_list.getDoc_content() %></a></td>
		    		
		    		<fmt:formatDate var="formatDate" value="<%=co_list.getDoc_date()%>" pattern="yyyy-MM-dd"/>
		    		<td><a href="javascript:void(0);" onclick="war_detail(this);" ww_no ='<%=co_list.getDoc_cno()%>'>${formatDate}</a></td>
		    		
		    	</tr>
		    <% }}
		    %>
		    	
		    </tbody>
		   </table>
		   <br>
		    <div class="error2">
		  </div>
		  </div>
</div><!-- ud_tab -->
               
 </div><!-- w_btnlist -->
        </div> <!-- ad_detail_contents 2 끝 -->
 
 
  <footer id="footer">
		<p>Copyright ©2021 All rights reserved | This template is made with <i class="fas fa-heart"></i> by SamSam
		</footer> 
</div><!-- main_content -->



 	<!-- 카카오톡 채널 상담 -->
	<div class="kakaoChat">
	<a href="javascript:void plusFriendChat()">
    <img src="resources/img/kakaolink_btn_medium.png" width="45px" height="45px" class="kakao_btn">
	</a>
	</div>
	
	<!-- pageup button -->
	<div class ="back-to-top">
	<a href="#" class ="back-to-top" style="display: inline;">
	<i class = "fas fa-angle-up"></i>
	</a>
	</div>   
</div><!-- body content -->

<!-- 제이쿼리 -->
<script>
$(document).ready(function(){
    console.log("<%= email %>") 
    var session = '<%= email %>'
    console.log(session);
    if(session == "null" ){
        $('#logout').hide();
          $('#mypage').hide();
          $('#login').show();
          $('#signin').show();
        
     } //헤더 상단 로그인상태 일때
     else{
       $('#logout').show();
         $('#mypage').show();
         $('#login').hide();
         $('#signin').hide();
     }; //헤더 상단 로그아웃상태 일때 
  });
</script>
<!-- 부트스트랩 4.0 js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<!-- 카카오톡 채널 상담 js -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
  //<![CDATA[
    // 사용할 앱의 JavaScript 키를 설정해 주세요.
    Kakao.init('be685f4c6119a7e447cd31c67878faf1');
    // 카카오톡 채널 1:1채팅 버튼을 생성합니다.
    function plusFriendChat() {
        Kakao.Channel.chat({
              channelPublicId: '_cjxmxiK' // 카카오톡채널 홈 URL에 명시된 홈ID
        });
    }
    
  //]]>
</script>

   </body>

   </html>