<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
		<%@ include file="/WEB-INF/page/inc/common.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/table01.css"  />
		<script>
		$(function() {
			<c:if test="${!w4:isDeclarationApprovable(pageContext, declaration.id)}">
				$("#approveDiv").hide();
			</c:if>
			disableForm("form2", true);
			
			//将分页和搜索有关参数设置进form
			putPageVariablesInForm($("#form1"));
			$("#form1").preventDoubleSubmission();
			$("#submit_btn").click(function() {
				$("#form1").submit();
			});
			$("#back_btn").click(function() {
				var form1 = $("#form1");
				form1.find("input[name='commit']").remove();
				if($.trim($("#comment").val()) == "") {
					alert("请填写退回理由");
					return;
				}
				$("<input type='hidden' name='back' value='true'/>").appendTo(form1);
				form1.submit();
			});
			$("a[id^='targetDescId']").click(function() {
				window.location.href = "${ctxPath}/declaration/approve.action?id=${declaration.id}&targetDocumentId=" + $(this).attr("id").substr("targetDescId_".length);
			});
		});
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">直报管理</a></li>
        <li>&gt;</li>
        <li><span>数据审核</span></li>
    </ul>
    <form:form action="${ctxPath }/declaration/approve.action" id="form2" method="post" modelAttribute="document">
    <div class="tableBox">
        <dl class="rootab">
            <dt>
            	<c:choose>
            		<c:when test="${empty document}">
            			<span class="hov"><a href="#">单位基本资料</a></span>
            		</c:when>
            		<c:otherwise>
            			<span><a href="#" id="targetDescId_0">单位基本资料</a></span>
            		</c:otherwise>
            	</c:choose>
            	<c:forEach items="${descriptors}" var="descriptor" varStatus="status">
            		<c:choose>
            			<c:when test="${descriptor.id eq document.descriptorId }">
            				<span class="hov"><a href="#"><c:out value="${descriptor.code }"/></a></span>
            			</c:when>
            			<c:otherwise>
            				<span><a href="#" id="targetDescId_${descriptor.id}"><c:out value="${descriptor.code }"/></a></span>
            			</c:otherwise>
            		</c:choose>
            	</c:forEach>
            </dt>
            
            <c:choose>
            	<c:when test="${empty document}">
            		<dd>
            		<table class="table_input" width="100%">
						<thead>
							<tr>
								<th colspan="4">单位基本情况表</th>
							</tr>
						</thead>
						<tbody>
							<%@ include file="/WEB-INF/page/company/company_info.jsp"%>
						</tbody>
					</table>
            		</dd>
            	</c:when>
            	<c:otherwise>
		            <%@ include file="/WEB-INF/page/declaration/tables.jsp"%>
            	</c:otherwise>
            </c:choose>
            
        </dl>
    </div>
    </form:form>
    <div class="tableBox">
	    <table class="table01 listTble">
	        <thead>
	            <tr>
	                <th>序号</th>
	                <th>步骤</th>
	                <th>处理结果及意见</th>
	                <th>操作时间</th>
	                <th>状态</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:forEach  items="${approvals}" var="approval" varStatus="index">
	            <tr>
	                <td><c:out value="${index.count}" /></td>
	                <td><c:out value="${approval.step }" /></td>
	                <td><c:out value="${approval.comment }" /></td>
	                <td><fmt:formatDate value="${approval.operator.addTime}" pattern="yyyy-MM-dd HH:mm" /> </td>
	                <td><c:out value="${approval.state }" /></td>
	            </tr>
	            </c:forEach>
	        </tbody>
	    </table>
    </div>
	<div class="audit" id="approveDiv">
		<form:form action="${ctxPath }/declaration/approve.action" id="form1" method="post" modelAttribute="declaration">
			${platform:params(pageContext) }
		    <input type="hidden" name="id" value="${declaration.id }" />
		        <p>
		            <label><input type="radio" name="approveResult" value="-1" checked="checked" />同意上报(数据准确)</label>
		            <label><input type="radio" name="approveResult" value="5" />取消填报(企业不配合)</label>
		            <label><input type="radio" name="approveResult" value="6" />取消填报(已停业/注销)</label>
		            <label><input type="radio" name="approveResult" value="7" />取消填报(无法联系)</label><br/>
		            <label><input type="radio" name="approveResult" value="8" />取消填报(非体育产业)</label>
		        </p>
		        <label class="tit">
		            <b>审核意见</b><textarea name="comment" id="comment"></textarea>
		        </label>
		        <p class="bottom_button">
		            <button id="submit_btn" type="button">提交</button>
		            <button id="back_btn" type="button">退回</button>
		        </p>
	    </form:form>
	</div>
</body>
</html>

