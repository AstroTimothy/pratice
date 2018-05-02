$(function(){

	/* 자전거 목록 출력 */
	bicList();
	
	/* 지점 선택 리스트 불러오기 */
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

/*엔터키로 자전거 등록 실행*/
function enterAdd(){
	if (event.keyCode == 13) { //키가 13이면 실행 (엔터는 13)
		addBicBtn();
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

/* 자전거 등록 버튼 */
function addBicBtn(){
	var brnId = $("select[name='brnSlctBox']").val()
		, bicGrd = $("select[name='bicGrd']").val()
		, data = "brnId="+brnId+"&bicGrd="+bicGrd
		, url = '8rent_bicAdd.do';
	 
	$.ajax({
		url: url
	    , type: 'post'
	    , data: data
	    , success: function(data) {   
			alert(data+'자전거 등록 완료');
		 	bicList();
		}
		, error: function(data) {
		alert('죄송합니다. 잠시 후 다시 시도해주세요.');
			return false;
		}
	});/* ajax ends */
}/* 자전거 등록 버튼 ends */

/* 자전거 수정 버튼 */
function bicModiBtn(bicId){
	alert(bicId+'자전거 수정 버튼');
}/* 자전거 수정 버튼 ends */

/* 자전거 삭제 버튼 */
function bicDelBtn(bicId){
	var data = 'bicId='+bicId
		, url = '8rent_bicDel.do';
	
	$.ajax({
    	url: url
    	, type: 'post'
    	, data: data
 	   	, success: function(data) {  
 	   		alert('자전거 삭제 완료');
 	  	 	bicList();
 	   	}
 	   	, error: function(data) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }
	});/* ajax ends */
}/* 자전거 삭제 버튼 ends */

/* 자전거 목록 */
function bicList(){
	
	/* 검색 키워드 */
	var sltBox = $("select[name='searchBicSltBox']").val()
		, searchKey = $("#searchKey").val()
		, data = sltBox+'='+searchKey;
	
	/* 첫 목록 */
	$.ajax({
		url: '8rent_bicList.do'
		, type: 'post'
		, data: 'pageNo=1&'+data
		, dataType: 'json'
		, success: function(result) {
			var listTable = '<table class="bicListTable" width="100%"  border="1" cellpadding="0" cellspacing="0" >';
			
			listTable += "<tr>";
		    	listTable += "<th>ID</th>";
		    	listTable += "<th>등급</th>";
		    	listTable += "<th>현소속지점</th>";
		    	listTable += "<th>대여상태</th>";
		    	listTable += "<th></th>";
			listTable += "</tr>";
			
			$.each(result.bicList, function(key, value) {
																	
			listTable += "<tr>";
				listTable += "<td>"+value.bicId+"</td>";
				listTable += "<td>"+value.bicGrd+"</td>";
				listTable += "<td>"+value.brnName+"</td>";
				listTable += "<td>"+value.rntStat+"</td>";
				listTable += "<td>";
					listTable += "<input type='button' value='수정' onclick='bicModiBtn("+value.bicId+")'></input>";
					listTable += "&nbsp&nbsp<input type='button' value='삭제' onclick='bicDelBtn("+value.bicId+")'></input>";
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
		url: '8rent_maxPage.do'
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
						url: '8rent_bicList.do'
						, type: 'post'
						, data: 'pageNo='+page+'&'+data
						, dataType: 'json'
						, success: function(result) {
							var listTable = '<table class="bicListTable" width="100%"  border="1" cellpadding="0" cellspacing="0" >';
							
							listTable += "<tr>";
						    	listTable += "<th>ID</th>";
						    	listTable += "<th>등급</th>";
						    	listTable += "<th>현소속지점</th>";
						    	listTable += "<th>대여상태</th>";
						    	listTable += "<th></th>";
							listTable += "</tr>";
							
							$.each(result.bicList, function(key, value) {
																					
							listTable += "<tr>";
								listTable += "<td>"+value.bicId+"</td>";
								listTable += "<td>"+value.bicGrd+"</td>";
								listTable += "<td>"+value.brnName+"</td>";
								listTable += "<td>"+value.rntStat+"</td>";
								listTable += "<td>";
									listTable += "<input type='button' value='수정' onclick='bicModiBtn("+value.bicId+")'></input>";
									listTable += "&nbsp&nbsp<input type='button' value='삭제' onclick='bicDelBtn("+value.bicId+")'></input>";
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

/*검색*/
function changeInput() {
	var sltBox = $("select[name='searchBicSltBox']").val();
		
	if (sltBox=='brnName') {
		
		var sltBrn = '<input type="text" id="searchKey" value=""></input>';
		
			$("#searchKeyBox").html(sltBrn);
	
	} else if (sltBox=='rntStat') {
		
		var sltStat = '<select id="searchKey">';
				sltStat += '<option value=""></option>';
				sltStat += '<option value="n">대여가능</option>';
				sltStat += '<option value="y">대여중</option>';
			sltStat += '</select>';
			
			$("#searchKeyBox").html(sltStat);
			
	} else if (sltBox=='bicGrd') {
		
		var sltGrd = '<select id="searchKey">';
				sltGrd += '<option value=""></option>';
				sltGrd += '<option value="h">고급</option>';
				sltGrd += '<option value="m">성인</option>';
				sltGrd += '<option value="l">어린이</option>';
			sltGrd += '</select>';
			
			$("#searchKeyBox").html(sltGrd);
			
	}
};