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
				var treeObj = $.fn.zTree.getZTreeObj("tree1");
				var nodes = treeObj.getCheckedNodes(true);
				if(nodes && nodes.length > 0) {
					for(var i=0; i<nodes.length; i++) {
						$("<input type='hidden' name='areaIds' value='" + nodes[i].id + "'/>").appendTo($form);
					}
				}
				
				$this.val("正在导出...");
				$this.attr("disabled", true);
				
				$form.submit();
				
				return false;
			});
		});
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">企业名录库</a></li>
		<li>&gt;</li>
		<li><span>导出名录库</span></li>
    </ul>
    <div class="tableBox">
    <form action="${ctxPath }/system/company_export.action" id="form1" method="post">
    <table class="table01 listTble">
        <tbody>
            <tr>
                <td colspan="2">
                    <p>如果不选择区域，则导出全部区域的名录库（包括还未选择区域的企业）</p>
                    <p>如果不选择审批状态，则导出全部状态的名录库</p>
                </td>
            </tr>
            <tr>
                <td style="width:30%;padding:10px; vertical-align:top;">
                	<div class="ztree conChil" id="tree1"></div>
                </td>
                <td style="text-align:left; vertical-align:top;padding:10px;">
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding:5px;">
                    <label><input type="checkbox" name="declarationStates" value="0"/>未报</label>
                    <label><input type="checkbox" name="declarationStates" value="1"/>待审核</label>
                    <label><input type="checkbox" name="declarationStates" value="2"/>待区审核</label>
                    <label><input type="checkbox" name="declarationStates" value="3"/>已审核</label>
                    <label><input type="checkbox" name="declarationStates" value="4"/>退回</label><br/>
                    <label><input type="checkbox" name="declarationStates" value="5"/>取消填报(企业不配合)</label>
                    <label><input type="checkbox" name="declarationStates" value="6"/>取消填报(已停业/注销)</label>
                    <label><input type="checkbox" name="declarationStates" value="7"/>取消填报(无法联系)</label>
                    <label><input type="checkbox" name="declarationStates" value="8"/>取消填报(非体育产业)</label><br/>
                    <input style="line-height:22px;height:24px;padding:0 10px;" type="button" id="export_btn" value="导出"/>
                </td>
            </tr>
        </tbody>
    </table>
    </form>
    </div>
</body>
</html>

