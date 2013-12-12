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
        <li><a href="#">直报管理</a></li>
        <li>&gt;</li>
        <li><span>直报审核</span></li>
    </ul>
    <div class="serch">
        <form action="${ctxPath }/declaration/wait_approve.action" id="searchForm" method="get">
	        <label>地区：</label>
	        <w4tag:area value="${param.sParam_countyId }" cityName="sParam_cityId" countyName="sParam_countyId" search="true" />
	        <label>审批状态：</label>
	        <select id="sParam_declarationState" name="sParam_declarationState">
	            <option value="-1" <c:if test="${empty param.sParam_declarationState or param.sParam_declarationState eq -1}">selected="selected"</c:if>>全部</option>
	            <option value="0" <c:if test="${param.sParam_declarationState eq 0}">selected="selected"</c:if>>未报</option>
	            <option value="1" <c:if test="${param.sParam_declarationState eq 1}">selected="selected"</c:if>>待审核</option>
	            <option value="2" <c:if test="${param.sParam_declarationState eq 2}">selected="selected"</c:if>>待区审核</option>
	            <option value="3" <c:if test="${param.sParam_declarationState eq 3}">selected="selected"</c:if>>已审核</option>
	            <option value="4" <c:if test="${param.sParam_declarationState eq 4}">selected="selected"</c:if>>退回</option>
	            <option value="5" <c:if test="${param.sParam_declarationState eq 5}">selected="selected"</c:if>>取消填报(企业不配合)</option>
	            <option value="6" <c:if test="${param.sParam_declarationState eq 6}">selected="selected"</c:if>>取消填报(已停业/注销)</option>
	            <option value="7" <c:if test="${param.sParam_declarationState eq 7}">selected="selected"</c:if>>取消填报(无法联系)</option>
	            <option value="8" <c:if test="${param.sParam_declarationState eq 8}">selected="selected"</c:if>>取消填报(非体育产业)</option>
	        </select>
	        <label>关键词：</label>
	        <input type="text" name="sParam_codeOrName" defaultText="组织机构代码/单位名称" value="${param.sParam_codeOrName }" />
	        <button id="searchButton" type="button">搜索</button>
        </form>
    </div>
    <div class="tableBox">
    <form action="${ctxPath }/declaration/batch_approve.action" id="form1" method="post">
    <table class="table01 listTble">
        <thead>
            <tr>
            	<th><input type="checkbox" name="checkAll" /></th>
                <th>市</th>
                <th>区/县</th>
                <th>组织机构代码</th>
                <th>单位名称</th>
                <th>行业类别</th>
                <th>联系人</th>
                <th>联系人手机</th>
                <th>联系电话</th>
                <th>填报日期</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach  items="${companies}" var="company" varStatus="index">
        		<c:set var="canApprove" value="false" />
        		<c:choose>
        			<c:when test="${company.declaration.state eq 2 }"><c:set var="canApprove" value="true" /></c:when>
        			<c:when test="${company.declaration.state eq 1 }">
        				<c:if test="${w4:isCityManager()}"><c:set var="canApprove" value="true" /></c:if>
        			</c:when>
        		</c:choose>
            <tr>
            	<td><c:if test="${canApprove}"><input type="checkbox" name="decIds" value="${company.declaration.id }"/></c:if></td>
                <td><c:out value="${company.contact.city.name }" /></td>
                <td><c:out value="${company.contact.county.name }" /></td>
                <td><c:out value="${company.code }" /></td>
                <td><c:out value="${company.name }" /></td>
                <td><c:out value="${company.category.displayName }" /></td>
                <td><c:out value="${company.preparer }" /></td>
                <td><c:out value="${company.mobile }" /></td>
                <td><c:out value="${company.contact.phone }" /></td>
                <td><fmt:formatDate value="${company.declaration.operator.addTime }"/> </td>
                <td>
	                <c:choose>
	                	<c:when test="${company.declaration.state eq 0 }">未报</c:when>
	                	<c:when test="${company.declaration.state eq 1 }">待审核</c:when>
	                	<c:when test="${company.declaration.state eq 2 }">待区审核</c:when>
	                	<c:when test="${company.declaration.state eq 3 }">已审核</c:when>
	                	<c:when test="${company.declaration.state eq 4 }">退回</c:when>
	                	<c:when test="${company.declaration.state eq 5 }">取消填报(企业不配合)</c:when>
	                	<c:when test="${company.declaration.state eq 6 }">取消填报(已停业/注销)</c:when>
	                	<c:when test="${company.declaration.state eq 7 }">取消填报(无法联系)</c:when>
	                	<c:when test="${company.declaration.state eq 8 }">取消填报(非体育产业)</c:when>
					</c:choose>
                </td>
                <td>
                	<c:choose>
                		<c:when test="${empty company.declaration or company.declaration.state eq 0}">
                			<!-- <a href="#" sparam="true">数据录入</a>  -->
                		</c:when>
                		<c:otherwise>
		                	<w4tag:permission url="/declaration/approve.action">
		                		<a href="${ctxPath }/declaration/approve.action?id=${company.declaration.id}" sparam="true">
		                		<c:choose>
				                	<c:when test="${canApprove}">审核</c:when>
				                	<c:otherwise>查看</c:otherwise>
								</c:choose>
		                		</a>
		                	</w4tag:permission>
                		</c:otherwise>
                	</c:choose>
                </td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
    </form>
		<c:if test="${fn:length(companies) > 0}">
			<div>
				<input type="button" name="operate_all_confirm" form="form1" entityId="decIds" value="批量审核通过"/>
			</div>
		</c:if>
    	<div>未填报:<b>${uncommitCount}</b> 待区审核:<b>${countyApproving}</b> 待审核:<b>${approvingCount}</b> 已审核:<b>${approvedCount}</b> 已退回:<b>${backCount}</b> 已取消:<b>${canceldCount}</b></div>
       	${page }
		<div class="ws pages">
		</div>
    </div>
    
</body>
</html>

