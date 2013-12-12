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
        <li><a href="#">企业名录库</a></li>
        <li>&gt;</li>
        <li><span>企业名录库</span></li>
    </ul>
    <div class="serch">
        <form action="${ctxPath }/company/final_list.action" id="searchForm" method="get">
	        <label>地区：</label>
	        <w4tag:area value="${param.sParam_countyId }" cityName="sParam_cityId" countyName="sParam_countyId" search="true" />
	        <label>类别：</label>
	        <select id="sParam_state" name="sParam_state">
	            <option value="1" <c:if test="${param.sParam_state eq 1}">selected="selected"</c:if>>正式库企业</option>
	            <option value="2" <c:if test="${param.sParam_state eq 2}">selected="selected"</c:if>>已删除企业</option>
	        </select>
	        <label>关键词：</label>
	        <input type="text" name="sParam_codeOrName" defaultText="组织机构代码/单位名称" value="${param.sParam_codeOrName }" />
	        <button type="button" id="searchButton">搜索</button>
        </form>
    </div>
    <div class="tableBox">
    <table class="table01 listTble">
        <thead>
            <tr>
            	<th>登录名</th>
                <th>组织机构代码</th>
                <th>市</th>
                <th>区/县</th>
                <th>单位名称</th>
                <th>行业类别</th>
                <th>联系人</th>
                <th>联系人手机</th>
                <th>联系电话</th>
                <th>录入时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach  items="${companies}" var="company" varStatus="index">
            <tr>
            	<td><c:out value="${company.user.username }" /></td>
                <td><c:out value="${company.code }" /></td>
                <td><c:out value="${company.contact.city.name }" /></td>
                <td><c:out value="${company.contact.county.name }" /></td>
                <td><c:out value="${company.name }" /></td>
                <td><c:out value="${company.category.displayName }" /></td>
                <td><c:out value="${company.preparer }" /></td>
                <td><c:out value="${company.mobile }" /></td>
                <td><c:out value="${company.contact.phone }" /></td>
                <td><fmt:formatDate value="${company.operator.addTime }" pattern="yyyy-MM-dd" /></td>
                <td class="modify">
                	<w4tag:permission url="/company/update.action">
                		<a href="${ctxPath }/company/update.action?id=${company.id}" sparam="true">修改</a>
                	</w4tag:permission>
                	<w4tag:permission url="/company/delete.action">
                		<c:if test="${company.state eq 1}">
                			<a href="#" name="operate_confirm" uri="${ctxPath }/company/delete.action?id=${company.id}">删除</a>
                		</c:if>
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

