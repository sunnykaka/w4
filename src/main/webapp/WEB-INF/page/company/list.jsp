<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<%@ include file="/WEB-INF/page/inc/common.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/table01.css"  />
		<script>
		$(function() {
			$("#sParam_startDate,#sParam_endDate").datepicker({
				format : "yy-mm-dd"
			});
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
        <li><span>企业资料列表</span></li>
    </ul>
    <div class="serch">
        <form action="${ctxPath }/company/list.action" id="searchForm" method="get">
	        <label>地区：</label>
	        <w4tag:area value="${param.sParam_countyId }" cityName="sParam_cityId" countyName="sParam_countyId" search="true" />
	        <label>审批状态：</label>
	        <select id="sParam_approveState" name="sParam_approveState">
	            <option value="-1" <c:if test="${empty param.sParam_approveState or param.sParam_approveState eq -1}">selected="selected"</c:if>>全部</option>
	            <option value="0" <c:if test="${param.sParam_approveState eq 0}">selected="selected"</c:if>>未提交</option>
	            <option value="1" <c:if test="${param.sParam_approveState eq 1}">selected="selected"</c:if>>待审核</option>
	            <option value="2" <c:if test="${param.sParam_approveState eq 2}">selected="selected"</c:if>>审核通过</option>
	            <option value="3" <c:if test="${param.sParam_approveState eq 3}">selected="selected"</c:if>>退回</option>
	        </select>
	        <label>申报起止日期：</label>
	        <input type="text" id="sParam_startDate" name="sParam_startDate" value="${param.sParam_startDate }" size="11"/>-
	        <input type="text" id="sParam_endDate" name="sParam_endDate" value="${param.sParam_endDate }" size="11"/>
	        <label>关键词：</label>
	        <input type="text" name="sParam_codeOrName" defaultText="组织机构代码/单位名称" value="${param.sParam_codeOrName }" />
	        <button type="button" id="searchButton">搜索</button>
        </form>
    </div>
    <div class="tableBox">
    <table class="table01 listTble">
        <thead>
            <tr>
                <th>市</th>
                <th>区/县</th>
                <th>组织机构代码</th>
                <th>单位名称</th>
                <th>行业类别</th>
                <th>联系人</th>
                <th>联系人手机</th>
                <th>联系电话</th>
                <th>审核状态</th>
                <th>名录状态</th>
                <th>是否是重点企业</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach  items="${companies}" var="company" varStatus="index">
            <tr>
                <td><c:out value="${company.contact.city.name }" /></td>
                <td><c:out value="${company.contact.county.name }" /></td>
                <td><c:out value="${company.code }" /></td>
                <td><c:out value="${company.name }" /></td>
                <td><c:out value="${company.category.displayName }" /></td>
                <td><c:out value="${company.preparer }" /></td>
                <td><c:out value="${company.mobile }" /></td>
                <td><c:out value="${company.contact.phone }" /></td>
                <td class="modify">
	                <c:choose>
	                	<c:when test="${company.approveState eq 0 }">未提交</c:when>
						<c:when test="${company.approveState eq 1 }">待审核</c:when>
						<c:when test="${company.approveState eq 2 }">审核通过</c:when>
						<c:when test="${company.approveState eq 3 }">退回</c:when>
					</c:choose>
                </td>
                <td>
	                <c:choose>
	                	<c:when test="${company.state eq 0 }">暂存</c:when>
						<c:when test="${company.state eq 1 }">有效名录</c:when>
						<c:when test="${company.state eq 2 }">已删除</c:when>
					</c:choose>
                </td>
                <td><c:choose>
                	<c:when test="${company.majorInquiry}"><a href="#" uri="${ctxPath }/company/major_inquiry.action?id=${company.id}&isMajorInquiry=false" name="operate_confirm" noAlert="true">关闭</a></c:when>
                	<c:otherwise><a href="#" uri="${ctxPath }/company/major_inquiry.action?id=${company.id}&isMajorInquiry=true" name="operate_confirm" noAlert="true">开启</a></c:otherwise>
                </c:choose></td>
                <td>
                	<c:choose>
                		<c:when test="${not empty param.sParam_approveState}">
                			<c:set var="appState" value="${param.sParam_approveState }" />
                		</c:when>
                		<c:otherwise>
                			<c:set var="appState" value="-1" />
                		</c:otherwise>
                	</c:choose>
                	<w4tag:permission url="/company/update.action">
                		<a href="${ctxPath }/company/update.action?id=${company.id}&sParam_approveState=${appState}" sparam="true">修改</a>
                	</w4tag:permission>
                	<w4tag:permission url="/company/approve.action">
                		<a href="${ctxPath }/company/approve.action?id=${company.id}&sParam_approveState=${appState}" sparam="true">
                			<c:choose>
			                	<c:when test="${company.approveState eq 0 }">查看</c:when>
								<c:when test="${company.approveState eq 1 }">审核</c:when>
								<c:when test="${company.approveState eq 2 }">查看</c:when>
								<c:when test="${company.approveState eq 3 }">查看</c:when>
							</c:choose>
                		</a>
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

