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
		<script type="text/javascript">
		
		selectLeftDd("approvalList");
		
		$(function() {
			$("#form1").validationEngine(defaultJVEOptions).preventDoubleSubmission();
			$("#fillDocument").click(function() {
				$("#form1").submit();
			});

			var messageType = '${param.message}';
			if(messageType) {
				if(messageType == 'save') {
					alert("保存成功");
				} else if(messageType == 'tempSave') {
					alert("暂存成功");
				} else if(messageType == 'commit') {
					alert("提交成功");
				} else if(messageType == 'cancel') {
					alert("撤回成功");
				} else if(messageType == 'companySave') {
					if(window.confirm("企业资料保存成功，您现在就想填报表格吗？")) {
						$("#fillDocument").click();
					}
				}
			}

		});
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">企业直报</a></li>
		<li>&gt;</li>
		<li><span>数据直报</span></li>
    </ul>
    <div class="table_tit">
        <h2>贵公司需要申报表格的审批进度：</h2>
        <!--
        <a href="#" title="#">操作说明</a>
         -->
    </div>
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
                <td style="width:300px;padding:10px;text-align:left;"><c:out value="${approval.comment }" /></td>
                <td><fmt:formatDate value="${approval.operator.addTime}" pattern="yyyy-MM-dd HH:mm" /> </td>
                <td><c:out value="${approval.state }" /></td>
            </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
    <div class="audit botton01">
        <form action="${ctxPath }/declaration/fill.action" id="form1" method="get">
	        <p class="bottom_button">
	            <button id="fillDocument" type="button" >填报表格</button>
	        </p>
        </form>
        <p>
            <button type="button" onclick="window.location.href='${ctxPath }/declaration/update_company.action'">进入修改单位资料</button>
            <br />如果发现填报表格有问题，可以重新修改单位行业
        </p>
    </div>
</body>
</html>

