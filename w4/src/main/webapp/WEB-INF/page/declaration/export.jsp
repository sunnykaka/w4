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
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/zTreeStyle/zTreeStyle.css"  />
		<script type="text/javascript" src="${ctxPath }/js/jquery.ztree.core-3.5.min.js"></script>
		<script type="text/javascript" src="${ctxPath }/js/jquery.ztree.excheck-3.5.min.js"></script>
		<script type="text/javascript" src="${ctxPath }/js/json2.js"></script>
		
		<script type="text/javascript">
		var checkInterval = null;
		var checking = false;
		
		$(function() {
			
			var setting = {
				check: {
					enable: true
				},
				data: {},
				callback: {},
				view: {
					showIcon:false
				}
			};

			$.fn.zTree.init($("#tree1"), setting, JSON.parse('${areaJson}'));
			
			$("#export_btn").click(function() {
				var $this = $(this);
				var $form = $("#form1");
				$form.find("input[name='areaIds']").remove();
				$form.find("input[name='taskId']").remove();
				var treeObj = $.fn.zTree.getZTreeObj("tree1");
				var nodes = treeObj.getCheckedNodes(true);
				if(!nodes || nodes.length == 0) {
					alert("请选择一个区");
					return false;
				}
				if($("input:checked[name='desIds']").length == 0) {
					alert("请选择需要导出的表格");
					return false;
				}
				for(var i=0; i<nodes.length; i++) {
					$("<input type='hidden' name='areaIds' value='" + nodes[i].id + "'/>").appendTo($form);
				}
				//var taskId = jQuery.uuid;
				//$("<input type='hidden' name='taskId' value='" + taskId + "'/>").appendTo($form);
				//checkInterval = window.setInterval("checkIfTaskFinished(" + taskId + ")", 3000);
				
				$this.val("正在导出...");
				$this.attr("disabled", true);
				
				$form.submit();
				
				return false;
			});
		});
		/*
		可能chrome下的
		var checkIfTaskFinished = function(taskId) {
			console.log('in check ' + taskId);
			if(checking === true) {
				return;
			}
			checking = true;
			$.ajax({url:'${ctxPath}/ajax/declaration/check_task_finished.action', type:'post', 
				data:{taskId: taskId}, dataType:"text",
				complete: function(jqXHR, status) {
					alert('have result' + status);
					checking = false;
					
					if(status == "success" && data && data == "true") {
						$("#export_btn").attr("disabled", false).val("导出");
					} else {
					}
					
				}
			});
		};
			*/
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">直报管理</a></li>
		<li>&gt;</li>
		<li><span>导出直报数据</span></li>
    </ul>
    <div class="tableBox">
    <form action="${ctxPath }/declaration/export.action" id="form1" method="post">
    <table class="table01 listTble">
        <tbody>
            <tr>
                <td colspan="2">
                    <p>1.选择要导出数据的区域，（为了保证系统运行的效率，推荐一次导出一个区）</p>
                    <p>2.选择要导数据的表格（为了保证系统运行的效率，推荐一次只导出一张表格）</p>
                </td>
            </tr>
            <tr>
                <td style="width:30%;padding:10px; vertical-align:top;">
                	<div class="ztree conChil" id="tree1"></div>
                </td>
                <td style="text-align:left; vertical-align:top;padding:10px;">
                <c:forEach items="${descriptors}" var="descriptor">
                	<p><label><input type="checkbox" name="desIds" value="${descriptor.id}" />【<c:out value="${descriptor.code }" />】<c:out value="${descriptor.name }" /></label></p>
                </c:forEach>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding:5px;">
                    <input style="line-height:22px;height:24px;padding:0 10px;" type="button" id="export_btn" value="导出"/>
                    <label><input type="checkbox" name="includeBack" value="true"/>包含退回数据</label>
                    <label><input type="checkbox" name="includeApproving" value="true"/>包含未审核数据</label>
                    <label><input type="checkbox" name="includeCancel" value="true"/>包含取消填报数据</label>
                </td>
            </tr>
        </tbody>
    </table>
    </form>
    </div>
</body>
</html>

