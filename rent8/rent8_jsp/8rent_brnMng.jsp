<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>지점 관리</title>
	
	<style>

		form {
			display: inline-block;
		}
		
		h {
			display: inline-block;
		}
		
		.brnListTable {
			bordercolor:#D3E2EC; 
			bordercolordark:#FFFFFF; 
			BORDER-TOP:#C2D0DB 2px solid; 
			BORDER-LEFT:#ffffff 1px solid; 
			BORDER-RIGHT:#ffffff 1px solid; 
			BORDER-BOTTOM:#C2D0DB 1px solid; 
			border-collapse: collapse;
		}
				
	</style>
	
	<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="../../../js/jquery.paging.js"></script>
	<script src="../../../js/8rent_brnMng.js"></script>
	
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/main/8rent/8rent_common.jsp" flush="false">
		<jsp:param name="" value="" />
	</jsp:include>
	
	<!-- 내용 -->
	<div id="contents">
	
		<!-- 주소 입력 폼 -->
		<form class="brnForm" action="" method="post" style="margin-bottom: 20px;">
			<table>
				<tr>
					<th></th>
					<th>구</th>
					<th>동</th>
					<th>지점명</th>
					<th></th>
				</tr>
				<tr>
					<td>
						<p>지점 등록</p>
					</td>				
					<td>
						<!-- 구 선택 박스 -->
						<select name="gooSelect" style="width: 100px;" onchange="dongSlctList()">
							<option value=""></option>
							<option value="02">마포구</option>
							<option value="03">서대문구</option>
							<option value="04">은평구</option>
						</select>
					</td>				
					<td>
						<!-- 동 선택 박스 -->
						<select name="dongSelect" style="width: 100px;">
						</select>
					</td>
					<td>
						<input type="text" name="brnName" value="" style="width: 150px; height: 20px;">
					</td>
					<td>
						<!-- 지점 등록 버튼 -->
						<input type="button" value="등록" onclick="brnAddBtn()">
					</td>	
				</tr>
			</table>
		</form><!-- 주소 입력 폼 end -->
		
		<!-- 지점 목록 -->
		<div id="8rent_brnList">
		</div>	
		
		<!-- 검색 -->
		<form 
			id="searchForm" 
			name="searchForm"
			method="get" 
			style="display:inline-block; margin-top:20px;">
			
			<select id="searchBox" name="searchBox">
				<option value="title">지점명</option>
			</select> 
			
			<input type="text" name="searchName" id="searchName" value="">
			<input type="hidden" name="pageNo" value="${paging.pageNo}">
			<input type="button" value="검색">
		</form>
		
		<!-- paging -->
		<div id="paging" >
		</div>
		
	</div><!-- 내용 div end -->

</body>
</html>