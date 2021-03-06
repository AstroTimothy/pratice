<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleRegister.jsp
  * @Description : Sample Register 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:set var="registerFlag" value="${empty sampleVO.id ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
    <!--
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
           	document.detailForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 삭제 function */
        function fn_egov_delete() {
           	document.detailForm.action = "<c:url value='/deleteSample.do'/>";
           	document.detailForm.submit();
        }
        
        /* 글 등록 function */
        function fn_egov_save() {
        	frm = document.detailForm;
        	if(!validateSampleVO(frm)){
                return;
            }else{
            	frm.action = "<c:url value="${registerFlag == 'create' ? '/addSample.do' : '/updateSample.do'}"/>";
                frm.submit();
            }
        }
	-->        
    </script>
    
    <style>
    
		.background {
			position: absolute;
			width: 100%;
			text-align: center;
		}
		
		.layer { 
			text-align: center;
			display:inline-block;
		}
		
		.innerLayer {
			display: inline-block;
		}
		
		table td {
			padding: 3px;
		}
    
    </style>
    
    <script>
	
//	삭제 버튼
    function cmmtDelBtn(cmmt_id) {
		var cmmtId = "cmmt_id="+cmmt_id
			, url = '/practice/practice/cmmtDel.do?cmmt_id='+cmmt_id;
		$.ajax({
			type: 'get'
			, url: url
			, async: false
			, success: function(){
				alert('댓글이 삭제되었습니다.');
				location.reload();
			}
			, error: function(request, status, error){
                alert(request);
                alert(status);
                alert(error);
			}
		});
	}
	
// 	수정 버튼
	function cmmtModiBtn(cmmt_id){
	
		var url = '/practice/practice/selectModiCmmt.do?cmmt_id='+cmmt_id;
		
		$.ajax({
			type: 'get'
			, url: url
			, async: false
			, success: function(result) {
					
	//		 		댓글 수정 폼
					var insertFormTable = '<form name="cmmtModi" action="practice/cmmt_Modify.do" method="post">';
					
					$.each(result.cmmtModi, function(key, value) {
	
							insertFormTable += '작성자 <input type="text" id="cmmt_name" value="'+value.cmmt_name+'"></input>';
							insertFormTable += '내용 <input type="text" id="cmmt_contents" value="'+value.cmmt_contents+'"></input>';
							insertFormTable += '비번 <input type="password" id="cmmt_pwd"></input>';
							insertFormTable += '<input type="button" id="cmmtModify" value="수정"></input>';
							insertFormTable += '</form>';
								
					})
					$("#cmmtInsertForm").html(insertFormTable);

			}
			, error: function(result) {
				alert('죄송합니다. 잠시 후 다시 시도해주세요.');
     	    	return false;
     	    }  
		});
		
	}

//     페이지 로딩 후 실행
    $(document).ready(function(){
    	
//     	댓글 리스트 실행
    	cmmtList();
   	
//     	댓글 등록
	    $("#cmmtInsert").click(function(){
	    	
	        var cmmt_contents = $("#cmmt_contents").val()
			    , cmmt_name = $("#cmmt_name").val()
			    , cmmt_pwd = $("#cmmt_pwd").val()
			    , id = $("#id").val()
			    , url="/practice/practice/cmmtInsert.do"
			    , data="id="+id+"&cmmt_contents="+cmmt_contents+"&cmmt_name="+cmmt_name+"&cmmt_pwd="+cmmt_pwd;
	        
	        $.ajax({
	        	url: url
	        	, type: 'post'
	        	, data: data
	     	   	, success: function(data) {    
					alert('댓글 등록 완료');
					cmmtList();
	     	   	}
	     	   	, error: function(data) {
					alert('죄송합니다. 잠시 후 다시 시도해주세요.');
	     	    	return false;
	     	    }  
	     	});
	     	
	    })
	    
// 	    댓글 리스트 
	    function cmmtList(){
			var id = $("#id").val()
				, url="/practice/practice/cmmtList.do?id="+id;
				
			$.ajax({
				url: url
				, type: 'get'
				, async: false
				, success: function(result) {
					
					var listTable = '<table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">';
	
						listTable += "<tr>";
							listTable += "<th>작성자</th>";
							listTable += "<th>내용</th>";
							listTable += "<th>작성시간</th>";
							listTable += "<th></th>";
						listTable += "</tr>";
						
						$.each(result.cmmtList, function(key, value) {
														
							listTable += "<tr>";
								listTable += "<td>"+value.cmmt_name;
								listTable += "</td>";
								listTable += "<td>"+value.cmmt_contents;
								listTable += "</td>";
								listTable += "<td>"+value.cmmt_wtime;
								listTable += "</td>";
								listTable += "<td><button onclick='cmmtModiBtn("+value.cmmt_id+")'>수정</button>";
								listTable += "&nbsp&nbsp<button onclick='cmmtDelBtn("+value.cmmt_id+")'>삭제</button></td>";
							listTable += "</tr>";          		
		            		
		            	});
						
						listTable += "</table>";
						$("#cmmtListTable").html(listTable);

				}
				, error: function(result) {
					alert('죄송합니다. 잠시 후 다시 시도해주세요.');
	     	    	return false;
	     	    }  
			});
		}

    })
    </script>
    
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
<div class="background">
<div class="layer">

<form:form commandName="sampleVO" id="detailForm" name="detailForm">
    <div id="content_pop" class="innerLayer">
    	<!-- 타이틀 -->
    	<div id="title">
    		<ul>
    			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/>
                    <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                    <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                </li>
    		</ul>
    	</div>
    	<!-- // 타이틀 -->
    	<div id="table">
    	<table width="100%" border="1" cellpadding="0" cellspacing="0" style="bordercolor:#D3E2EC; bordercolordark:#FFFFFF; BORDER-TOP:#C2D0DB 2px solid; BORDER-LEFT:#ffffff 1px solid; BORDER-RIGHT:#ffffff 1px solid; BORDER-BOTTOM:#C2D0DB 1px solid; border-collapse: collapse;">
    		<colgroup>
    			<col width="150"/>
    			<col width="?"/>
    		</colgroup>
    		<c:if test="${registerFlag == 'modify'}">
        		<tr>
        			<td class="tbtd_caption"><label for="id"><spring:message code="title.sample.id" /></label></td>
        			<td class="tbtd_content">
        				<form:input path="id" cssClass="essentiality" maxlength="10" readonly="true" />
        			</td>
        		</tr>
    		</c:if>
    		<tr>
    			<td class="tbtd_caption"><label for="name"><spring:message code="title.sample.name" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="name" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="name" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="useYn"><spring:message code="title.sample.useYn" /></label></td>
    			<td class="tbtd_content">
    				<form:select path="useYn" cssClass="use">
    					<form:option value="Y" label="Yes" />
    					<form:option value="N" label="No" />
    				</form:select>
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="description"><spring:message code="title.sample.description" /></label></td>
    			<td class="tbtd_content">
    				<form:textarea path="description" rows="5" cols="58" />&nbsp;<form:errors path="description" />
                </td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="regUser"><spring:message code="title.sample.regUser" /></label></td>
    			<td class="tbtd_content">
                    <c:if test="${registerFlag == 'modify'}">
        				<form:input path="regUser" maxlength="10" cssClass="essentiality" readonly="true" />
        				&nbsp;<form:errors path="regUser" /></td>
                    </c:if>
                    <c:if test="${registerFlag != 'modify'}">
        				<form:input path="regUser" maxlength="10" cssClass="txt"  />
        				&nbsp;<form:errors path="regUser" /></td>
                    </c:if>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="password"><spring:message code="title.sample.password" /></label></td>
    			<td class="tbtd_content">
                    <c:if test="${registerFlag == 'modify'}">
        				<form:password path="password" maxlength="4" cssClass="essentiality"/>
        				&nbsp;<form:errors path="password" /></td>
                    </c:if>
                    <c:if test="${registerFlag != 'modify'}">
        				<form:password path="password" maxlength="4" cssClass="txt"  />
        				&nbsp;<form:errors path="password" /></td>
                    </c:if>
    		</tr>
    	</table>
      </div>
    	<div id="sysbtn">
    		<ul>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_selectList();"><spring:message code="button.list" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:fn_egov_save();">
                            <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                            <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
                        </a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
    			<c:if test="${registerFlag == 'modify'}">
                    <li>
                        <span class="btn_blue_l">
                            <a href="javascript:fn_egov_delete();"><spring:message code="button.delete" /></a>
                            <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                        </span>
                    </li>
    			</c:if>
    			<li>
                    <span class="btn_blue_l">
                        <a href="javascript:document.detailForm.reset();"><spring:message code="button.reset" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>
                </li>
            </ul>
    	</div>
    </div>
    <!-- 검색조건 유지 -->
    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
    
</form:form>

<!-- 댓글 작성 -->
<c:if test="${registerFlag == 'modify'}">
	<div id="cmmtForm" class="innerLayer">
	
		<div id="cmmtInsertForm">
			<form name="cmmtForm" action="practice/cmmt_insert.do" method="post">
				작성자 <input type="text" id="cmmt_name" value=""></input>
				내용 <input type="text" id="cmmt_contents"></input>
				비번 <input type="password" id="cmmt_pwd"></input>
					 <input type="button" id="cmmtInsert" value="등록"></input>
			</form>
		</div>

<!-- 댓글 리스트 -->
		<div id="cmmtListTable" style="margin-top:10px;">
    	</div>
		
	</div>
</c:if>
</div>
</div>
</body>
</html>