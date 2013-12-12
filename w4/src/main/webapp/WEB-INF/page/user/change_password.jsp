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
        <li><span>修改密码</span></li>
    </ul>
    
    <form:form action="${ctxPath }/np/user/change_password.action" id="form1" method="post">
	<table class="table_input" width="100%">
		<thead>
			<tr>
				<th colspan="4">修改密码</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty success }">
			<tr>
				<td colspan="4" align="center">
				<c:choose>
					<c:when test="${!success}"><span style="color:red;font-weight:bold;">${errorMsg }</span></c:when>
					<c:otherwise><span style="color:green;font-weight:bold;">密码修改成功</span></c:otherwise>
				</c:choose>
				</td>
			</tr>
			</c:if>
			<tr>
				<th>输入旧密码：</th>
				<td colspan="3"><input id="oldPassword" name="oldPassword" 
					data-validation-engine="validate[required,minSize[6],maxSize[20]]" type="password" />
				</td>
			</tr>
			<tr>
				<th>输入新密码：</th>
				<td colspan="3"><input id="newPassword" name="newPassword" 
					data-validation-engine="validate[required,minSize[6],maxSize[20]]" type="password" />
				</td>
			</tr>
			<tr>
				<th>确认密码：</th>
				<td colspan="3"><input data-validation-engine="validate[required,minSize[6],maxSize[20],equals[newPassword]]" 
					id="agentPassword" name="agentPassword" type="password" />
				</td>
			</tr>
		</tbody>
	</table>
	</form:form>
	
	<div class="audit" id="submit_div">
        <p class="bottom_button">
            <button id="submit_btn" type="button">确定</button>
        </p>
    </div>
</body>
</html>

