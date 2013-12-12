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
        <li><span>设置直报年度</span></li>
    </ul>
    
    <form action="${ctxPath }/system/set_year.action" id="form1" method="post">
	<table width="100%">
		<thead>
			<tr>
				<th colspan="4">设置直报年度</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>当前直报年度</th>
				<td colspan="3" style="text-align:left;">
					<c:out value="${currentYearCode.displayName }" />
				</td>
			</tr>
			<tr>
				<th>设置当前直报年度</th>
				<td colspan="3" style="text-align:left;">
					<select name="currentYear">
						<c:forEach var="year" items="${years}">
							<option value="${year.displayName }" <c:if test="${year.value eq 'current' }">selected="selected"</c:if>><c:out value="${year.displayName }" /></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>设置当前直报年度状态</th>
				<td colspan="3" style="text-align:left;">
					<input type="radio" name="currentYearState" value="opening" <c:if test="${currentYearCode.description eq 'opening' }">checked="checked"</c:if> />开启
					<input type="radio" name="currentYearState" value="closed" <c:if test="${empty currentYearCode.description or currentYearCode.description eq 'closed' }">checked="checked"</c:if>/>关闭
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

