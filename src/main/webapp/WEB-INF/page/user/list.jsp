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
		selectLeftDd("userList");
		$(function() {
			$("#searchButton").click(function() {
				var $form = $("#searchForm");
				handleSearchForm($form);
				$form.submit();
			});
		});
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">系统管理</a></li>
        <li>&gt;</li>
        <li><span>用户列表</span></li>
    </ul>
    <div class="serch">
        <form action="${ctxPath }/user/list.action" id="searchForm" method="get">
	        <label>地区：</label>
	        <w4tag:area value="${param.sParam_countyId }" cityName="sParam_cityId" countyName="sParam_countyId" search="true" />
	        <label>状态：</label>
	        <select id="sParam_state" name="sParam_state">
	            <option value="0" <c:if test="${empty param.sParam_state or param.sParam_state eq 0}">selected="selected"</c:if>>正常</option>
	            <option value="1" <c:if test="${param.sParam_state eq 1}">selected="selected"</c:if>>禁用</option>
	        </select>
	        <c:if test="${w4:isCityManager() }">
				<label>类型：</label>
		        <select id="sParam_type" name="sParam_type">
		        	<option value="-1" <c:if test="${empty param.sParam_type or param.sParam_type eq -1}">selected="selected"</c:if>>所有</option>
		            <option value="0" <c:if test="${param.sParam_type eq 0}">selected="selected"</c:if>>企业用户</option>
		            <option value="1" <c:if test="${param.sParam_type eq 1}">selected="selected"</c:if>>区管理员</option>
		            <option value="2" <c:if test="${param.sParam_type eq 2}">selected="selected"</c:if>>市管理员</option>
		        </select>
	        </c:if>
	        <label>用户名：</label>
	        <input type="text" name="sParam_codeOrName" value="${param.sParam_codeOrName }" />
	        <button id="searchButton" type="button">搜索</button>
        </form>
    </div>
    <div class="tableBox">
    <table class="table01 listTble">
        <thead>
            <tr>
                <th>市</th>
                <th>区/县</th>
                <th>用户名</th>
                <th>创建时间</th>
                <th>上次登录时间</th>
                <th>类型</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach  items="${users}" var="user" varStatus="index">
            <tr>
                <td><c:out value="${user.area.parent.name }" /></td>
                <td><c:if test="${user.type != 2}"><c:out value="${user.area.name }" /></c:if></td>
                <td><c:out value="${user.username }" /></td>
                <td><fmt:formatDate value="${user.operator.addTime }" pattern="yyyy-MM-dd HH:mm" /></td>
                <td><fmt:formatDate value="${user.lastLoginTime }" pattern="yyyy-MM-dd HH:mm" /></td>
                <td class="modify">
	                <c:choose>
	                	<c:when test="${user.type eq 0 }">企业用户</c:when>
						<c:when test="${user.type eq 1 }">区管理员</c:when>
						<c:when test="${user.type eq 2 }">市管理员</c:when>
					</c:choose> 
                </td>
                <td>
                	<c:choose>
                		<c:when test="${not empty param.sParam_approveState}">
                			<c:set var="appState" value="${param.sParam_approveState }" />
                		</c:when>
                		<c:otherwise>
                			<c:set var="appState" value="-1" />
                		</c:otherwise>
                	</c:choose>
                	<w4tag:permission url="/user/update.action">
                		<a href="${ctxPath }/user/update.action?userId=${user.id}" sparam="true">修改</a>
                	</w4tag:permission>
                	<w4tag:permission url="/user/change_state.action">
						<c:choose><c:when test="${user.state eq 1 }"><a href="#" name="operate_confirm" uri="${ctxPath }/user/change_state.action?userId=${user.id}" title="点击启用此用户" label="您确定要启用此用户吗?">启用</a></c:when>
						<c:otherwise><a href="#" name="operate_confirm" uri="${ctxPath }/user/change_state.action?userId=${user.id}" title="点击禁用此用户" label="您确定要禁用此用户?">禁用</a></c:otherwise></c:choose>
                	</w4tag:permission>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
       	${page }
		<div class="ws pages">
		</div>
    </div>
    
</body>
</html>

