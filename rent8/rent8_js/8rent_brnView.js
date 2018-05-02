$(document).ready(function(){

	/* 지점 목록 출력 */
	brnList();
	
	/* 지점 선택 리스트 불러오기 */
	bicBrnSlct();

	/* 클릭으로 검색 실행 */
	$("input[name=searchSubmit]").click(function(){
		brnList();
	});
	
})/* readyFunction end*/

/*엔터키로 검색 실행*/
function enterSubmit(){
    if (event.keyCode == 13) { //키가 13이면 실행 (엔터는 13)
    	brnList();
    }
}

/* 자전거 지점 선택 */
function bicBrnSlct(){
	$.ajax({
		url: 'brnLocSlct.do'
    	, type: 'post'
		, dataType: 'json'
 	   	, success: function(data) {   
 	   		var selectBox = '<select name="brnSlctBox">';
 	   			selectBox += '<option value=""></option>';
 	   		
 	   			$.each(data.brnList, function(key, value) {
   					selectBox += '<option value="'+value.brnName+'">';
   					selectBox += value.brnName;
   					selectBox += '</option>';
 	   			});/* each ends */
 	   		
 	   		selectBox += '</select>';
 	  	 	$("select[name='searchBrnSltBox']").html(selectBox);
 	   	}
 	   	, error: function(data) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }		
	});/* ajax ends */
}/* 자전거 지점 선택 ends */

/* 지점 목록 */
function brnList(){
	
	/* 검색 키워드 */
	var sltBox = $("select[name='searchBrnSltBox']").val()
		, data = 'brnName='+sltBox;
	
	/*첫 목록*/
	$.ajax({
		url: '8rent_brnList.do'
		, type: 'post'
		, data: 'pageNo=1&'+data
		, dataType: 'json'
		, success: function(result) {
			var listTable = '<table class="brnListTable" width="100%"  border="1" cellpadding="0" cellspacing="0" >';
			
			listTable += "<tr>";
		    	listTable += "<th>지점명</th>";
		    	listTable += "<th>위치</th>";
		    	listTable += "<th>자전거 현황</th>";
			listTable += "</tr>";
									
			$.each(result.brnList, function(key, value) {
																	
			listTable += "<tr name="+value.brnid+">";
				listTable += "<td>"+value.brnname+"</td>";
				listTable += "<td>"+value.brnloc+"</td>";
				
				/* 지점별 자전거 현황 */
				listTable += "<td><table class='brnBic'>";
					listTable += "<tr>";
						listTable += "<th>고급</th>";
						listTable += "<th>성인</th>";
						listTable += "<th>어린이</th>";
					listTable += "</tr>"
					listTable += "<tr>";
						listTable += "<td>"+value.hGrd+"</td>";
						listTable += "<td>"+value.mGrd+"</td>";
						listTable += "<td>"+value.lGrd+"</td>";
					listTable += "</tr></table></td>";
				listTable += "</tr>";          		
					            		
			});
									
			listTable += "</table>";
			$("#8rent_brnList").html(listTable);
			
		}/* success end */
		, error: function(result) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }/* error end */
	});/* ajax end */
	
	/* 페이징 기능 구현 */
	$.ajax({
		url: '8rent_brnMaxPage.do'
		, type: 'post'
		, dataType: 'json'
		, success: function(result) {
			var maxPage = result.rent8_BrnVO.maxPage;
			
			/* paging */
			$('#paging').paging({
				current: 1
				, max: maxPage
				, onclick: function(e, page){
					
					/* 각 페이지에 해당하는 지점 리스트 불러오기 */
					$.ajax({
						url: '8rent_brnList.do'
						, type: 'post'
						, data: 'pageNo='+page+'&'+data
						, dataType: 'json'
						, success: function(result) {
							var listTable = '<table class="brnListTable" width="100%"  border="1" cellpadding="0" cellspacing="0" >';
							
							listTable += "<tr>";
						    	listTable += "<th>지점명</th>";
						    	listTable += "<th>위치</th>";
						    	listTable += "<th>자전거 현황</th>";
								listTable += "<th></th>";
							listTable += "</tr>";
													
							$.each(result.brnList, function(key, value) {
																					
							listTable += "<tr name="+value.brnid+">";
								listTable += "<td>"+value.brnname+"</td>";
								listTable += "<td>"+value.brnloc+"</td>";
								
								/* 지점별 자전거 현황 */
								listTable += "<td><table class='brnBic'>";
									listTable += "<tr>";
										listTable += "<th>고급</th>";
										listTable += "<th>성인</th>";
										listTable += "<th>어린이</th>";
									listTable += "</tr>"
									listTable += "<tr>";
										listTable += "<td>"+value.hGrd+"</td>";
										listTable += "<td>"+value.mGrd+"</td>";
										listTable += "<td>"+value.lGrd+"</td>";
									listTable += "</tr></table>";
								listTable += "</td>";
							listTable += "</tr>";          		
									            		
							});
													
							listTable += "</table>";
							$("#8rent_brnList").html(listTable);
							
						}/* success end */
						, error: function(result) {
							alert('죄송합니다. 잠시 후 다시 시도해주세요.');
				 	    	return false;
				 	    }/* error end */
					});/* ajax end */
				}/* onclick end */
			});/* paging end */
		
		}/* success end */
		, error: function(result) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }/* error end */
			
	});/* 페이징 기능 구현 end */
}/* brnList end */