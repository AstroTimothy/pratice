$(function(){

	/* 자전거 목록 */
	bicList();
	
	/* 자전거 지점 선택 목록 */
	bicBrnSlct();
	
	/* 클릭으로 검색 실행 */
	$("input[name=searchSubmit]").click(function(){
		bicList();
	});
	
})/* readyFunction ends */

/*엔터키로 검색 실행*/
function enterSubmit(){
    if (event.keyCode == 13) { //키가 13이면 실행 (엔터는 13)
    	bicList();
    }
}

/*자전거 대여 버튼*/
function rent8Btn(rentInfo) {
	
	alert(rentInfo);
	
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
   					selectBox += '<option value="'+value.brnId+'">';
   					selectBox += value.brnName;
   					selectBox += '</option>';
 	   			});/* each ends */
 	   		
 	   		selectBox += '</select>';
 	  	 	$("select[name='brnSlctBox']").html(selectBox);
 	   	}
 	   	, error: function(data) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }		
	});/* ajax ends */
}/* 자전거 지점 선택 ends */

/* 자전거 목록 */
function bicList(){
	
	/* 검색 키워드 */
	var	brnSlt = $("select[name='brnSlctBox']").val()
		, grdSlt = $("select[name='bicGrd']").val()
		, data = 'brnId='+brnSlt+'&bicGrd='+grdSlt;
	
	/* 첫 목록 */
	$.ajax({
		url: '8rent_rentBicList.do'
		, type: 'post'
		, data: 'pageNo=1&'+data
		, dataType: 'json'
		, success: function(result) {
			var listTable = '<table class="bicListTable" width="100%"  border="1" cellpadding="0" cellspacing="0" >';
			
			listTable += "<tr>";
				listTable += "<th>현소속지점</th>";
		    	listTable += "<th>등급</th>";
		    	listTable += "<th></th>";
			listTable += "</tr>";
			
			$.each(result.rentBicList, function(key, value) {
																	
			listTable += "<tr>";
				listTable += "<td>"+value.brnName+"</td>";
				listTable += "<td>"+value.bicGrd+"</td>";
				listTable += "<td>";
					listTable += "<input type='button' value='대여' onclick='rent8Btn("+value.bicId+")'></input>";
				listTable += "</td>";
			listTable += "</tr>";
					            		
			});/* each ends */
									
			listTable += "</table>";
			$("#8rent_bicList").html(listTable);
		}/* success ends */
		, error: function(result) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
	    	return false;
	    }/* error ends */
	});/* ajax ends */
	
	/* 페이징 기능 구현 */
	$.ajax({
		url: '8rent_rentMaxPage.do'
		, data: data
		, type: 'post'
		, dataType: 'json'
		, success: function(result) {
			var maxPage = result.rent8_searchVO.maxPage;
			
			/* paging */
			$('#paging').paging({
				current: 1
				, max: maxPage
				, onclick: function(e, page){
					
					/* 각 페이지에 해당하는 자전거 리스트 불러오기 */
					$.ajax({
						url: '8rent_rentBicList.do'
						, type: 'post'
						, data: 'pageNo='+page+'&'+data
						, dataType: 'json'
						, success: function(result) {
							var listTable = '<table class="bicListTable" width="100%"  border="1" cellpadding="0" cellspacing="0" >';
							
							listTable += "<tr>";
								listTable += "<th>현소속지점</th>";
						    	listTable += "<th>등급</th>";
						    	listTable += "<th></th>";
							listTable += "</tr>";
							
							$.each(result.rentBicList, function(key, value) {
																					
							listTable += "<tr>";
								listTable += "<td>"+value.brnName+"</td>";
								listTable += "<td>"+value.bicGrd+"</td>";
								listTable += "<td>";
									listTable += "<input type='button' value='대여' onclick='rent8Btn("+value.bicId+")'/>";
								listTable += "</td>";
							listTable += "</tr>";
									            		
							});/* each ends */
													
							listTable += "</table>";
							$("#8rent_bicList").html(listTable);
						}/* success ends */
					});/* ajax ends */
				}/* onclick ends */
			});/* paging ends */
		
		}/* success ends */
		, error: function(result) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }/* error ends */
			
	});/* 페이징 기능 구현 ends */
	
}/* 자전거 목록 ends */

