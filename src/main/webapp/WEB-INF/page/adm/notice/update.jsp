<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<%@ include file="/WEB-INF/page/inc/common.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/table01.css"  />
		<script>
		$(function() {
			$("#form1").validationEngine(defaultJVEOptions).preventDoubleSubmission();
			$("#submit_btn").click(function() {
				$("#form1").submit();
			});
		});
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">公告管理</a></li>
        <li>&gt;</li>
        <li><span>修改公告</span></li>
    </ul>
    
    <form action="${ctxPath }/adm/notice/save.action" id="form1" method="post">
	${platform:params(pageContext)}
    <input type="hidden" name="noticeId" value="${notice.id}" />
	<table width="100%">
		<thead>
			<tr>
				<th colspan="4">添加公告</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>类型</th>
				<td colspan="3" style="text-align:left;">
					<c:forEach items="${types }" var="type" >
						<input type="radio" data-validation-engine="validate[required]" name="typeId" value="${type.id }" <c:if test="${notice.typeId eq type.id }">checked="checked"</c:if> /> ${type.title }
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th>标题</th>
				<td colspan="3" style="text-align:left;">
					<input type="text" id="title" name="title" size="32" value="${notice.title }" data-validation-engine="validate[required,maxSize[255]]"/>
				</td>
			</tr>
			<!-- 
			<tr>
				<th>重要公告</th>
				<td colspan="3" style="text-align:left;">
					<input type="checkbox" name="important" value="true" <c:if test="${notice.important}">checked="checked"</c:if> />
				</td>
			</tr>
			 -->
			<tr>
				<th>新公告</th>
				<td colspan="3" style="text-align:left;">
					<input type="checkbox" name="news" value="true" <c:if test="${notice.news}">checked="checked"</c:if> />
				</td>
			</tr>
			<tr>
				<th>公告内容</th>
				<td colspan="3" style="text-align:left;">
					<textarea cols="80" id="content" name="content" rows="10">${notice.content }</textarea>
				</td>
			</tr>
		</tbody>
	</table>
	</form>
	
	<div class="audit" id="submit_div">
        <p class="bottom_button">
            <button id="submit_btn" type="button">确定</button>
        </p>
    </div>
    
    <ckeditor:replace replace="content" basePath="${ctxPath }/ckeditor/" config="${applicationScope.ckeditorConfig }" />
</body>
</html>

