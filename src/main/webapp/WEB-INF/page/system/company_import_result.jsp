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
	      $(function(){
	      });
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">系统管理</a></li>
        <li>&gt;</li>
        <li><span>企业资料导入结果</span></li>
    </ul>

	<div class="date_upload">
		<c:choose>
		<c:when test="${importResult.success}"><p><img src="${ctxPath }/ico/ok.jpg"/>导入完成！</p></c:when>
		<c:otherwise><p><img src="${ctxPath }/ico/error.jpg"/>导入失败！</p></c:otherwise>
		</c:choose>
        <p><b>本次导入共计:</b>${importResult.successNum+importResult.failureNum}条信息</p>
        <p><b>已入库信息:</b>${importResult.successNum}条信息</p>
        <p><b>未入库信息:</b><span class="colorRed">${importResult.failureNum}条信息</span></p>
        <c:if test="${!importResult.success}"> 
        	<p>
	        	<img src="${ctxPath }/ico/error.jpg" />
	        	<button type="button" onclick="window.location.href='${ctxPath }/system/company_pro.action'">导入结果下载</button>请按此结果提示的信息对入库文件进行修改后重新导入
        	</p>
        </c:if>
        <p><button style="margin-left:90px;" type="button" onclick="window.location.href='${ctxPath }/system/company_import.action'">返回</button></p>
    </div>

</body>
</html>

