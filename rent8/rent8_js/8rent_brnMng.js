$(function(){

	/* 지점 목록 출력 */
	brnList();
	
})/* readyFunction end*/

/* 동 선택 */
function dongSlctList(){
	var goo = $("select[name='gooSelect'] option:selected").val()
		, data = "goo="+goo;
	
	$.ajax({
		url: 'dongSlctList.do'
    	, type: 'post'
    	, data: data
		, dataType: 'json'
 	   	, success: function(result) {   
 	   		var selectBox = '<select name="dongSelect" style="width: 100px;">';
 	   			selectBox += '<option value=""></option>';
 	   			
 	   			$.each(result.dongSlctList, function(key, value) {
   					selectBox += '<option value="'+value.dong+'">';
   					selectBox += value.dongNm;
   					selectBox += '</option>';
 	   			});/* each end */
 	   		
 	   		selectBox += '</select>';
 	  	 	$('select[name="dongSelect"]').html(selectBox);
 	   	}
 	   	, error: function(result) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }		
	});/* ajax end */
}/* 동 선택 선택 end */

/* 지점 등록 버튼 */
function brnAddBtn() {
	var goo = $("select[name='gooSelect']").val()
		, dong = $("select[name='dongSelect']").val()
		, brnLoc = goo + dong
		, brnName = $("input[name='brnName']").val()
		, data = "brnLoc="+brnLoc+"&brnName="+brnName
		, url = '8rent_brnAdd.do';
		
	$.ajax({
    	url: url
    	, type: 'post'
    	, data: data
 	   	, success: function(data) {   
 	   		alert('지점 등록 완료');
 	   		brnList();
 	   	}
 	   	, error: function(data) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }
	});/* ajax end */
}/* addBrnBtn() end */

/* 지점 수정 버튼 */
function brnModiBtn(brnId){
	alert(brnId+'지점 수정 버튼');
}/* brnModiBtn end */

/* 지점 삭제 버튼 */
function brnDelBtn(brnId){
	var data = 'brnId='+brnId
		, url = '8rent_brnDel.do';
		
	$.ajax({
    	url: url
    	, type: 'post'
    	, data: data
 	   	, success: function(data) {   
 	   		alert('지점 삭제 완료');
 	   		brnList();
 	   	}
 	   	, error: function(data) {
			alert('죄송합니다. 잠시 후 다시 시도해주세요.');
 	    	return false;
 	    }
	});/* ajax end */
}/* brnDelBtn end */

/* 지점 목록 */
function brnList(){
	
	/*첫 목록*/
	$.ajax({
		url: '8rent_brnList.do'
		, type: 'post'
		, data: 'pageNo=1'
		, dataType: 'json'
		, success: function(result) {
			var listTable = '<table class="brnListTable" width="100%"  border="1" cellpadding="0" cellspacing="0" >';
			
			listTable += "<tr>";
		    	listTable += "<th>지점명</th>";
		    	listTable += "<th>위치</th>";
		    	listTable += "<th>자전거 현황</th>";
				listTable += "<th>등록일</th>";
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
					listTable += "</tr></table></td>";
				
				listTable += "<td>"+value.adddt+"</td>";
				listTable += "<td>";
					listTable += "<input type='button' value='수정' onclick='brnModiBtn("+value.brnid+")'></input>";
					listTable += "&nbsp&nbsp<input type='button' value='삭제' onclick='brnDelBtn("+value.brnid+")'></input>";
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
						, data: 'pageNo='+page
						, dataType: 'json'
						, success: function(result) {
							var listTable = '<table class="brnListTable" width="100%"  border="1" cellpadding="0" cellspacing="0" >';
							
							listTable += "<tr>";
						    	listTable += "<th>지점명</th>";
						    	listTable += "<th>위치</th>";
						    	listTable += "<th>자전거 현황</th>";
								listTable += "<th>등록일</th>";
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
									listTable += "</tr></table></td>";
								
								listTable += "<td>"+value.adddt+"</td>";
								listTable += "<td>";
									listTable += "<input type='button' value='수정' onclick='brnModiBtn("+value.brnid+")'></input>";
									listTable += "&nbsp&nbsp<input type='button' value='삭제' onclick='brnDelBtn("+value.brnid+")'></input>";
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