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
        <li><a href="#">系统管理</a></li>
        <li>&gt;</li>
        <li><span>编辑联系方式</span></li>
    </ul>
    
    <form action="${ctxPath }/system/update_contact.action" id="form1" method="post">
	<table width="100%">
		<thead>
			<tr>
				<th colspan="4">编辑联系方式</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${supportContactCodes}" var="code" varStatus="status">
				<tr>
					<th>技术支持联系方式${status.count }</th>
					<td colspan="3" style="text-align:left;">
						<input type="hidden" name="supportContactCodeIds" id="supportContactCodeIds" value="${code.id }" />
						<input type="text" name="supportContactCodeValues" id="supportContactCodeValues" value="${code.value }" />
					</td>
				</tr>
			</c:forEach>
			<tr>
				<th>页脚联系方式</th>
				<td colspan="3" style="text-align:left;">
					<input type="hidden" name="contactCodeId" id="contactCodeId" value="${contactCode.id}" />
					<input type="text" name="contactCodeValue" id="contactCodeValue" value="${contactCode.value }" />
				</td>
			</tr>
			<tr>
				<th>页脚版权</th>
				<td colspan="3" style="text-align:left;">
					<input type="hidden" name="copyrightCodeId" id="copyrightCodeId" value="${copyrightCode.id}" />
					<input type="text" name="copyrightCodeValue" id="copyrightCodeValue" value="${copyrightCode.value }" />
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
</body>
</html>

