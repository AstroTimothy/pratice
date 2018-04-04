<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>

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
    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
    
    <!--  
    function fn_egov_select(id) {
    	document.detailForm.selectedId.value = id;
       	document.detailForm.action = "<c:url value='/passwordSample.do'/>";
       	document.detailForm.submit();
    }
    
    function goBack() {
    	window.history.back();
    }
    
    -->
        
    </script>
</head>
<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

<form:form commandName="sampleVO" id="detailForm" name="detailForm" >
<input type="hidden" name="selectedId" />
    <div id="content_pop">
    	<!-- 타이틀 -->
    	<div id="title">
    		<ul>
    			<li>
    				<img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/><spring:message code="check.password" />
                </li>
    		</ul>
    	</div>
    	<!-- // 타이틀 -->
    	${id}게시물의 비밀번호 입력<br/>
    	<form:input path="name" maxlength="20" cssClass="txt"/><br>
                <span class="btn_blue_l">
                            <a href="javascript:fn_egov_select('${id}')"><spring:message code="button.ok" /></a>
                            <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                        </span>
                   
                    <span class="btn_blue_l">
                        <a href="javascript:goBack();"/><spring:message code="button.goBack" /></a>
                        <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
                    </span>               
    	
    </div>
     <!-- 검색조건 유지 
   	<input type="hidden" name="searchCondition" value="<c:out value='${searchVO.searchCondition}'/>"/>
    <input type="hidden" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>"/>
    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
    -->
</form:form>
</body>
</html>