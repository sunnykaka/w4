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
			
			$("#down_tmpl").click(function() {
				$form = $("#form1");
				
				$form.attr("action", "${ctxPath}/system/company_tmpl.action");
				$form.submit();
				
				return false;
			});
			
			$('#import_btn').click(function(){
				if($('#excelFile').val().length > 3) {
					$('#impt_div').hide();
					$('#lad_div').show();
					var $form = $('#form1');
					$form.attr("action", "${ctxPath}/system/company_import.action");
					$form.submit();
				} else {
					alert('请选择上传文件！');
				}
			});
		});
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">系统管理</a></li>
        <li>&gt;</li>
        <li><span>导入企业资料</span></li>
    </ul>

    <form action="${ctxPath }/system/company_import.action" id="form1" method="post" enctype="multipart/form-data">
	<div class="date_upload" id="impt_div">
        <p><img src="${ctxPath }/ico/t01.jpg"/><button id="down_tmpl" type="button">请点击下载企业资料导入模板</button>点击下载企业资料导入模版</p>
        <p><img src="${ctxPath }/ico/t02.jpg" /><input type="file" name="excelFile" id="excelFile" value="选择文件"/>选择填写好的企业数据文件，为保证您的上传速度，请保持文件在1000条以下</p>
        <p><img src="${ctxPath }/ico/t03.jpg" /><button id="import_btn" type="button">导入信息</button><span style="color:red">${errorMsg }</span></p>
    </div>
    <div class="date_upload" id="lad_div" style="display:none;">
    	<img src="${ctxPath}/ico/lading.gif" /><br />
  		<b>正在上传....</b>
    </div>
	</form>

</body>
</html>

