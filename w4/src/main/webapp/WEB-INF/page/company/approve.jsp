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
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/jqtree.css"  />
		<script type="text/javascript" src="${ctxPath }/js/tree.jquery.js"></script>
		<script type="text/javascript" src="${ctxPath }/js/json2.js"></script>
		<script>
		$(function() {
			<c:if test="${!w4:isCompanyApprovable(pageContext, company.id)}">
				$("#approveDiv").hide();
			</c:if>
			disableForm("form2", true);
			//将分页和搜索有关参数设置进form
			putPageVariablesInForm($("#form1"));
			$("#form1").preventDoubleSubmission();
			$("#submit_btn").click(function() {
				var form1 = $("#form1");
				form1.find("input[name='commit']").remove();
				form1.submit();
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
			
			activeCategorySelect(JSON.parse('${categoryJson}'));
		});
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">企业名录库</a></li>
        <li>&gt;</li>
        <li><span>企业资料审核</span></li>
    </ul>
    <form:form action="${ctxPath }/company/approve.action" id="form2" method="post" modelAttribute="company">
    <div class="tableBox">
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
	                <th>原因</th>
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
	                <td><c:out value="${approval.reason }" /></td>
	                <td><c:out value="${approval.state }" /></td>
	            </tr>
	            </c:forEach>
	        </tbody>
	    </table>
    </div>
	<div class="audit" id="approveDiv">
		<form:form action="${ctxPath }/company/approve.action" id="form1" method="post" modelAttribute="company">
			${platform:params(pageContext) }
		    <input type="hidden" name="id" value="${company.id }" />
		    	<p></p>
		        <label class="tit">
		            <b>审核意见</b><textarea name="comment" id="comment"></textarea>
		        </label>
		        <p class="bottom_button">
		            <button id="submit_btn" type="button">提交</button>
		            <button id="back_btn" type="button">退回</button>
		        </p>
	    </form:form>
	</div>
    <div class="alert01" style="display:none;" id="categoryDiv">
        <div class="tit">
            <h2>提示</h2>
            <a id="categoryCloseHref" class="close" href="#" title="关闭">×</a>
        </div>
        <div class="con">
            <div class="conChil" id="tree1">
            </div>
            <div class="alert01Bot">
                <button type="button" id="categoryOkBtn">确定</button>
                <button type="button" class="close" id="categoryCloseBtn">关闭</button>
            </div>
        </div>
    </div>
</body>
</html>

