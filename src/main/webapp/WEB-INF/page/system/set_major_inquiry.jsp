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
        <li><span>是否启用重点调查</span></li>
    </ul>

    <form action="${ctxPath }/system/set_major_inquiry.action" id="form1" method="post">
	<table width="100%">
		<thead>
			<tr>
				<th colspan="4">是否启用重点调查</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>是否启用重点调查</th>
				<td colspan="3" style="text-align:left;">
					<input type="radio" name="isMajorInquiry" value="true" <c:if test="${isMajorInquiry}">checked="checked"</c:if> />开启
					<input type="radio" name="isMajorInquiry" value="false" <c:if test="${empty isMajorInquiry or !isMajorInquiry}">checked="checked"</c:if>/>关闭
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

