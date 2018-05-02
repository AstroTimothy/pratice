<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>자전거 관리</title>
	
	<link rel="stylesheet" type="text/css" href="../../../css/rent8_common.css"/>
	
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="../../../js/jquery.paging.js"></script>
	<script type="text/javascript" src="../../../js/8rent_8mng.js"></script>
	
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/main/8rent/8rent_common.jsp" flush="false">
		<jsp:param name="" value="" />
	</jsp:include>
	
	<div id="contents">
		
		<!-- 자전거 등록 -->		
		<div id="addBicForm" onkeypress="enterAdd()">
			<form name="bicAddForm" action="" method="post" onsubmit="return false;">
				<table class="bicAddFormTable">
					<tr>
						<td></td>
						<td>지점</td>
						<td>등급</td>
						<td></td>
					</tr>
					<tr>
						<td>자전거 등록</td>
						<td><select name="brnSlctBox"></select></td>
						<td>
							<select name="bicGrd">
								<option value=""></option>
								<option value="h">고급</option>
								<option value="m">성인</option>
								<option value="l">어린이</option>
							</select>
						</td>
						<td>
							<input type="button" onclick="addBicBtn()" value="등록" style="padding: 3px;">
						</td>
					</tr>
				</table>
			</form>
		</div><!-- 자전거 등록 end -->
		
		<!-- 자전거 목록 -->
		<div id="8rent_bicList">
		</div>
		
		<!-- 검색 -->
		<div class="searchForm">
			<form name="searchForm" onsubmit="return false;">
				
				<select name="searchBicSltBox">
					<option value=""></option>
					<option value="brnName" onclick="changeInput()">지점명</option>
					<option value="bicGrd" onclick="changeInput()">등급</option>
					<option value="rntStat" onclick="changeInput()">대여여부</option>
				</select> 
				
				<div id="searchKeyBox" onkeypress="enterSubmit()">
					<input type="text" id="searchKey"/>
				</div>
				
				<input type="button" name="searchSubmit" value="검색">
			</form>
		</div>
			
		<!-- 페이징 -->
		<div id="paging"></div>
		
	</div>

</body>
</html>