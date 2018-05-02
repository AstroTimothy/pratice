<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>welcome to 8rent!</title>
	
	<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css">
	<link href="<c:url value='/'/>css/rent8_common.css" rel="stylesheet" type="text/css">
	
	<script>
		function login() {
			alert('로그인 버튼');			
		}
	</script>

</head>
<body>

	<!-- header 시작 -->
	<div id="header_mainsize">
	    <c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" />
	</div>
	<div id="topnavi">
	    <c:import url="/EgovPageLink.do?link=main/inc/EgovIncTopnav" />
	</div>	

	<div id="background">
	
		<div id="header">
			<!-- 메인 페이지 링크 -->
			<a href="<c:url value='/cmm/main/8rent/8rent_main.do'/>">
				<img class="mainLink" src="../../../images/main/title.png" style="width: 200px;">
			</a>
		</div>
		
		<div id="sidebar">
			<!-- 대여 페이지 링크 -->
			<a href="<c:url value='/cmm/main/8rent/8rent_8rent.do'/>">
				<img class="menuLink" src="../../../images/menu/rent.png" style="width: 60px;">
			</a>
			<!-- 반납 페이지 링크 -->
			<a href="<c:url value='/cmm/main/8rent/8rent_main.do'/>">
				<img class="menuLink" src="../../../images/menu/rtn.png" style="width: 60px;">
			</a>
			<!-- 지점 현황 조회 페이지 링크 -->
			<a href="<c:url value='/cmm/main/8rent/8rent_brnView.do'/>">
				<img class="menuLink" src="../../../images/menu/brn.png" style="width: 60px;">
			</a>
			<!-- 대여내역 페이지 링크 -->
			<a href="<c:url value='/cmm/main/8rent/8rent_main.do'/>">
				<img class="menuLink" src="../../../images/menu/list.png" style="width: 120px;">
			</a>
			<!-- 지점관리 페이지 링크 -->
			<a href="<c:url value='/cmm/main/8rent/8rent_brnMng.do'/>">
				<img class="menuLink" alt="지점관리" src="../../../images/menu/brnMng.png" style="width: 127px;">
			</a>
			<!-- 자전거 관리 페이지 링크 -->
			<a href="<c:url value='/cmm/main/8rent/8rent_8mng.do'/>">
				<img class="menuLink" alt="자전거관리" src="../../../images/menu/bicMng.png" style="width: 160px;">
			</a>
			
			
			
		</div>
		
		<!-- 로그인 박스 -->
		<div id="loginBox">
			<form id="loginForm" action="">
				<table>
					<tr>
						<td><img src="../../../images/login/id.png" style="width: 25px;"></td>
						<td><input type="text" size="16" style="margin: 5px;"></td>
					</tr>
				
					<tr>
						<td><img src="../../../images/login/pw.png" style="width: 25px;"></td>
						<td><input type="password" size="16" style="margin: 5px;"></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="image" name="submit" src="../../../images/login/submit.png" style="width: 35px; margin-left: 80px;" onclick="login()"></td>
					</tr>
				</table>
			</form>
		</div>
		
		<div id="ftr">
			<a href="https://www.instagram.com/2th_radio/"><img src="../../../images/Instagram_icon.png" style="width: 30px; margin: 10px 20px 5px 0;"></a>
			<p>Copyright ⓒ 2018 Timothy Astro. All Rights Reserved.</p>
		</div>
		
	</div>
	
</body>
</html>