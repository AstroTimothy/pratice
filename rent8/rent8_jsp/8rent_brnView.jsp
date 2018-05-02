<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>지점 조회</title>
	
	<link rel="stylesheet" type="text/css" href="../../../css/rent8_common.css"/>
	
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="../../../js/jquery.paging.js"></script>
	<script src="../../../js/8rent_brnView.js"></script>
	
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/main/8rent/8rent_common.jsp" flush="false">
		<jsp:param name="" value="" />
	</jsp:include>
	
	<!-- 내용 -->
	<div id="contents">
		
		<!-- 지점 목록 -->
		<div id="8rent_brnList"></div>	
		
		<!-- 검색 -->
		<div class="searchForm">
			<form name="searchForm" onsubmit="return false;">
				
				<select name="searchBrnSltBox"></select> 
				
				<input type="button" name="searchSubmit" value="검색">
			</form>
		</div>
		
		<!-- paging -->
		<div id="paging"></div>
		
	</div><!-- 내용 div end -->

</body>
</html>
