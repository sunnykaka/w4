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
		selectLeftDd("linkList");
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
        <li><span>链接列表</span></li>
    </ul>
    <div class="serch">
        <form action="${ctxPath }/adm/notice/link_list.action" id="searchForm" method="get">
	        <label>标题：</label>
	        <input type="text" name="sParam_key" defaultText="链接标题" value="${param.sParam_key }" />
	        <button type="button" id="searchButton">搜索</button>
        </form>
    </div>
    <div class="tableBox">
    <table class="table01 listTble">
        <thead>
            <tr>
                <th>排序</th>
                <th>标题</th>
                <th>添加时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        	<c:forEach  items="${links}" var="link" varStatus="index">
            <tr>
                <td><input type="text" style="width:40px;" entity-id="${link.id}" uri="${ctxPath}/ajax/adm/notice/link_update_sort.action" name="updateBySort" value="${link.bySort }" /></td>
                <td><c:out value="${link.title }" /></td>
                <td><fmt:formatDate value="${link.addTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>
                	<w4tag:permission url="/adm/notice/link_update.action">
                		<a href="${ctxPath }/adm/notice/link_update.action?linkId=${link.id}" sparam="true">修改</a>
                	</w4tag:permission>
                	<w4tag:permission url="/adm/notice/link_delete.action">
                		<a href="#" name="operate_confirm" uri="${ctxPath }/adm/notice/link_delete.action?linkId=${link.id}" label="您确定要删除此链接?">删除</a>
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

