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
		selectLeftDd("noticeList");
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
        <li><a href="#">公告管理</a></li>
        <li>&gt;</li>
        <li><span>公告列表</span></li>
    </ul>
    <div class="serch">
        <form action="${ctxPath }/adm/notice/list.action" id="searchForm" method="get">
			<label>公告类型：</label>
	        <select id="sParam_typeId" name="sParam_typeId">
	        	<option value="-1" <c:if test="${empty param.sParam_typeId or param.sParam_typeId eq -1}">selected="selected"</c:if>>全部</option>
	        	<c:forEach items="${types }" var="type" >
	        		<option value="${type.id }" <c:if test="${param.sParam_typeId eq type.id}">selected="selected"</c:if>><c:out value="${type.title }" /></option>
				</c:forEach>
	        </select>
	        <label>标题：</label>
	        <input type="text" name="sParam_key" defaultText="公告标题" value="${param.sParam_key }" />
	        <button type="button" id="searchButton">搜索</button>
        </form>
    </div>
    <div class="tableBox">
    <table class="table01 listTble">
        <thead>
            <tr>
                <th>排序</th>
                <th>分类</th>
                <th>标题</th>
                <th>添加时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach  items="${notices}" var="notice" varStatus="index">
            <tr>
                <td><input type="text" style="width:40px;" entity-id="${notice.id}" uri="${ctxPath}/ajax/adm/notice/update_sort.action" name="updateBySort" value="${notice.bySort }" /></td>
                <td><c:out value="${notice.type.title }" /></td>
                <td><c:out value="${notice.title }" /></td>
                <td><fmt:formatDate value="${notice.addTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>
                	<w4tag:permission url="/adm/notice/update.action">
                		<a href="${ctxPath }/adm/notice/update.action?noticeId=${notice.id}" sparam="true">修改</a>
                	</w4tag:permission>
                	<w4tag:permission url="/adm/notice/delete.action">
                		<a href="#" name="operate_confirm" uri="${ctxPath }/adm/notice/delete.action?noticeId=${notice.id}" label="您确定要删除此公告?">删除</a>
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

