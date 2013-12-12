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
			$("#type").change(changeUserType);
			changeUserType();
		});
		
		var changeUserType = function() {
			var userType = $("#type").val();
			if(userType == 2) {
				$("[name='areaId']").hide();
			} else {
				$("[name='areaId']").show();
			}
		};
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">系统管理</a></li>
        <li>&gt;</li>
        <li><span>用户修改</span></li>
    </ul>
    
    <form:form action="${ctxPath }/user/save.action" id="form1" method="post" modelAttribute="user">
    <input type="hidden" name="userId" value="${user.id }" />
	${platform:params(pageContext) }
	<table class="table_input" width="100%">
		<thead>
			<tr>
				<th colspan="4">用户修改</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${requestScope[platform:getBindResultKey('user')].errorCount > 0}">
				<tr>
					<td colspan="4"><form:errors path="*" cssClass="" /></td>
				</tr>
			</c:if>
			<tr>
				<th><span class="ipt">*</span>用户名：</th>
				<td colspan="3"><input type="text" name="username" id="username" value="${user.username }" data-validation-engine="validate[required,minSize[3],maxSize[32],custom[username]]" /></td>
			</tr>
			<tr>
				<th>密码(如果不填写默认不修改)：</th>
				<td colspan="3"><input type="text" name="newPassword" id="newPassword" data-validation-engine="validate[minSize[6],maxSize[20]]" /></td>
			</tr>
			<tr>
				<th><span class="ipt">*</span>所在地：</th>
				<td colspan="3"><w4tag:area value="${user.areaId }" countyName="areaId" /></td>
			</tr>
			<tr>
				<th><span class="ipt">*</span>用户类型：</th>
				<td colspan="3">
					<select name="type">
						<c:choose>
							<c:when test="${user.type eq 0}">
								<option value="0" selected="selected">企业用户</option>
							</c:when>
							<c:otherwise>
								<option value="1" <c:if test="${user.type eq 1}">selected="selected"</c:if>>区管理员</option>
								<option value="2" <c:if test="${user.type eq 2}">selected="selected"</c:if>>市管理员</option>
							</c:otherwise>
						</c:choose>
					</select>
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

