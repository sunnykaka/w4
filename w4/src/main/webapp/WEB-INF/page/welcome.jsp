<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<%@ include file="/WEB-INF/page/inc/common.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctxPath}/style/table01.css"  />
	</head>
<body>
	<ul class=" publick_bgx crumbs">
		<li><b>当前位置：</b></li>
		<li><a href="#">我的首页</a></li>
	</ul>
	<c:set var="declarationState" value="申报已结束!"/>
	<c:if test="${applicationScope['declaration_year_is_opening']}">
		<c:set var="declarationState" value="申报正在进行中。"/>
	</c:if>
	<div class="tableBox">
		<table class="table01 welcome">
			<tbody>
				<tr>
					<td>当前填报年度为${applicationScope['declaration_year']-1}年，${declarationState}。</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>

