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
  *
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
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
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
    
<script>
    $(document).ready(function(){
    	
    	listReply();
    	
    	// ** 댓글 쓰기 버튼 클릭 이벤트 (ajax로 처리)
        $("#btnReply").click(function(){
            var replytext=$("#content").val();
            var bno=$("#id").val();
            var param="comment="+replytext+"&id="+bno;
            $.ajax({                
                type: "get",
                url: "${path}/sample/commentSample.do",
                data: param,
                success: function(){
                    alert("댓글이 등록되었습니다.");

                },error: function(request, status, error){
                    alert(request);
                    alert(status);
                    alert(error);
                  }
            });
            
            $.ajax({                
                type: "post",
                url: "${path}/sample/commentSample.do",
                data: param,
                success: function(){
                    alert("댓글이 등록되었습니다.");

                },error: function(request, status, error){
                    alert(request);
                    alert(status);
                    alert(error);
                  }
            });
        
        });
    });
        
    
    function deleteReply(bno){
    
         var param="id="+bno;
         $.ajax({                
             type: "get",
             url: "${path}/sample/commentDelete.do",
             data: param,
             success: function(){
                 alert("댓글이 삭제되었습니다.");

             },error: function(request, status, error){
                 alert(request);
                 alert(status);
                 alert(error);
               }
         });
    	
    	
    }
    
    
    function listReply(){
    
    	var bno=$("#id").val();
        $.ajax({
            type: "get",
            url: "${path}/sample/commentList.do?id="+bno,
            success: function(result){
            // responseText가 result에 저장됨.
            	var output = "<table border='1'>";
          
				$.each(result.commnetList, function(key, value) {
					
            		output += "<tr>";
            		output +="<td>내용 : "+value.comments;
                    output += "</td>";
                    
                    output +="<td>";
                    output +="<input type='hidden' class='cno' value="+value.cno+" >"
            		output +="<input type='hidden' class='bno' value="+value.bno+" >"
                    output +="<input type='button' class='delBtn' onclick='deleteReply("+value.cno+")' value='삭제'>"
                    output += "</td>";
            		output += "</tr>";
                    
            	});
				
				output += "</table>";
				$(".commentList").html(output);
            }
        });
    }
    
</script>
    
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="sampleVO" id="detailForm" name="detailForm" enctype="multipart/form-data">
    <div id="content_pop">
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
    			<td class="tbtd_caption"><label for="pw"><spring:message code="title.sample.pw" /></label></td>
    			<td class="tbtd_content">
    				<form:input path="pw" maxlength="30" cssClass="txt"/>
    				&nbsp;<form:errors path="pw" />
    			</td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="description"><spring:message code="title.sample.description" /></label></td>
    			<td class="tbtd_content">
    				<form:textarea path="description" rows="5" cols="58" />&nbsp;<form:errors path="description" />
                </td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="description2"><spring:message code="title.sample.description2" /></label></td>
    			<td class="tbtd_content">
    				<form:textarea path="description2" rows="5" cols="58" />&nbsp;<form:errors path="description2" />
                </td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="regUser"><spring:message code="title.sample.regUser" /></label></td>
    			<td class="tbtd_content">
                    <c:if test="${registerFlag == 'modify'}">
        				<form:input path="regUser" maxlength="10" cssClass="essentiality" readonly="true" />
        				&nbsp;<form:errors path="regUser" />
                    </c:if>
                    <c:if test="${registerFlag != 'modify'}">
        				<form:input path="regUser" maxlength="10" cssClass="txt"  />
        				&nbsp;<form:errors path="regUser" />
                    </c:if>
                </td>
    		</tr>
    		<tr>
    			<td class="tbtd_caption"><label for="file"><spring:message code="title.sample.file" /></label></td>
    			<td class="tbtd_content">
    				<input type="file" name="file" id="file" />
    				<form>업로드된 파일: ${sampleVO.fileName}	
					<input type="hidden" id="orgfile" name="orgfile" value="${sampleVO.fileName}" />
					</form>
    			</td>
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
               
               <!--  재설정 옆 댓글 버튼
                <li>
                    <span class="btn_blue_l">
                        <a href="javascript:document.detailForm.reset();"><spring:message code="button.detail" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                        
                    </span>
                </li>
                --> 
            </ul>
    	</div>
    </div>
    
    
    
    
    
    
    
    
      <!-- 댓글 -->
     <br>
     </br>
<c:if test="${registerFlag == 'modify'}">     
	<div id="comment">
     <table border="0" width="693" >
     	<tr>
     		<td>
				<input type="hidden" name="bno" value="${detail.bno}"/>
				<input type="text" style="width:620px; " class="form-control" id="content" name="content" placeholder="내용을 입력하세요.">
            </td>
     		<td>
                <button type="button" id="btnReply" >댓글 작성</button>
     		</td>
     	</tr>
     	<tr>
     		<td colspan="2">
     		  <div class="commentList">
     		  </div>
     		</td>
     	</tr>
     </table>
     </div>
</c:if>





	





    <!-- 검색조건 유지 -->
    <input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
</form:form>
</body>
</html>