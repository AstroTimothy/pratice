<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>자전거 관리</title>
	
	<link rel="stylesheet" type="text/css" href="../../../css/rent8_common.css"/>
	
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="../../../js/jquery.paging.js"></script>
	<script type="text/javascript" src="../../../js/8rent_8rent.js"></script>
	
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/main/8rent/8rent_common.jsp" flush="false">
		<jsp:param name="" value="" />
	</jsp:include>
	
	<!-- 내용 -->
	<div id="contents">
		
		<!-- 자전거 목록 -->
		<div id="8rent_bicList">
		</div>
		
		<!-- 검색 -->
		<div class="searchForm">
			<form name="searchForm" onsubmit="return false;">
				
				<!-- 지점 선택 -->
				<select name="brnSlctBox"></select>
				             
				<!-- 등급 선택 -->                            
				<select name="bicGrd">             
					<option value=""></option>    
					<option value="h">고급</option>
					<option value="m">성인</option>
					<option value="l">어린이</option>
				</select>
				
				<input type="button" name="searchSubmit" value="검색">
			</form>
		</div>
			
		<!-- 페이징 -->
		<div id="paging"></div>
		
	</div><!-- 내용 end -->

</body>
</html>