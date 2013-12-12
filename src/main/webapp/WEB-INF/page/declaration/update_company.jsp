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
		<script type="text/javascript" src="${ctxPath }/js/json2.js"></script>
		<script type="text/javascript">
		var checksumer = null;
		$(function() {

			$("#form1").validationEngine(defaultJVEOptions).preventDoubleSubmission();
			
			//如果没有选择登记注册类型,默认为请选择
			<c:if test="${empty company.registerCode}">
			if($("[name='registerCode'] option:selected").length == 0 || $("[name='registerCode']").val() == "10002") {
				$("[name='registerCode']").prepend("<option value='-1'>==请选择==</option>");
				$("[name='registerCode']").each(function(){
					for(var i = 0; i < this.options.length; i++){
			            if(this.options[i].value == '-1'){
			                this.options[i].selected = "selected";
			                break;
			            }
			        }
				});
			}
			</c:if>
			
			$("#save_btn").click(function() {
				return saveCompany.call(this, false);
			});
			$("#submit_btn").click(function() {
				return saveCompany.call(this, true);
			});
			$("[name='contact\\.countyId'],[name='contact\\.location']").change(function() {
				var countyName = $("[name='contact\\.countyId']").find("option:selected").text();
				var location = $("[name='contact\\.location']").val();
				var text = "广东省深圳市" + countyName + (location || "");
				$("#locationDetail").html(text);
			}).change();

			checksumer = TableChecksum();
			checksumer.checksum([
				{id:"employeeNum", text:"平均从业人员人数"},
				{id:"masterNum", text:"研究生人数"},
				{id:"bachelorNum", text:"本科学历人数"},
				{id:"collegeNum", text:"专科学历人数"},
				{id:"otherNum", text:"其他学历人数"}
				], {relation:"="}
			);

			activeCategorySelect(JSON.parse('${categoryJson}'));

			<c:if test="${!w4:isCompanyUpdatable(pageContext, company.id)}">
			$("#submit_div").hide();
			disableForm("form1", true);
			</c:if>
			
			<c:if test="${param.showDialog}">
				showTipDialog();
			</c:if>
		});

		var saveCompany = function(commit) {
			$("#form1").find("input[name='commit']").remove();
			if(!$.trim($("#product1").val()) && !$.trim($("#product2").val()) && !$.trim($("#product3").val())) {
				alert("请填写至少一个主要体育业务活动（或主要产品）");
				$("#product1").focus();
				return false;
			}
			if(!$.trim($("#categoryCode").val())) {
				alert("请选择行业类别");
				return false;
			}
			if($("[name='registerCode'] option:selected").length == 0 || $("[name='registerCode']").val() == "-1") {
				alert("请选择登记注册类型");
				return false;
			}
			if(checksumer) {
				if(checksumer.checksumAll() === false) {
					return false;
				}
			}
			if(commit === true) {
				$("<input type='hidden' name='commit' value='true' />").appendTo($("#form1"));
			}
			$("#form1").submit();
		};
		
		//企业用户首次登录提示框(还未确认单位资料时)
		var showTipDialog = function() {
			aleAuto($("#tipDiv"));
			$("[name='tipClose']").click(function() {
				$('#tipDiv').hide();
			});
			$("#tipDiv").show();
		};
		
		</script>
	</head>
<body>
	<ul class=" publick_bgx crumbs">
		<li><b>当前位置：</b></li>
		<li><a href="#">企业直报</a></li>
		<li>&gt;</li>
		<li><span>单位基本资料</span></li>
	</ul>
	<div class="tableBox">
		<form:form action="${ctxPath }/declaration/update_company.action" id="form1" method="post" modelAttribute="company">
		<input type="hidden" name="companyId" value="${company.id }" />
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
		</form:form>
	</div>
	<div class="audit" id="submit_div">
        <p class="bottom_button">
            <button id="submit_btn" type="button">确认单位资料</button>
        </p>
    </div>
    <div class="alert01" style="display:none;" id="categoryDiv">
        <div class="tit">
            <h2>提示</h2>
            <a id="categoryCloseHref" class="close" href="#" title="关闭">×</a>
        </div>
        <div class="con">
            <div class="ztree conChil" id="tree1">
            </div>
            <div class="alert01Bot">
                <button type="button" id="categoryOkBtn">确定</button>
                <button type="button" class="close" id="categoryCloseBtn">关闭</button>
            </div>
        </div>
    </div>
    <div class="alert01" style="display:none;" id="tipDiv">
        <div class="tit">
            <h2>提示</h2>
            <a name="tipClose" class="close" href="#" title="关闭">×</a>
        </div>
        <div class="con">
		<div class="conChil">
<pre style="padding-left: 3px">
欢迎登录深圳市体育产业统计数据直报系统！
<span style="color:red;">现在填报的是${applicationScope['declaration_year']-1}年度数据</span>

请确认系统中贵单位的以下资料是否正确：
1。【组织机构代码】
	组织机构代码不同于企业注册号，
	请从质监局颁发的【组织机构代码证】上查看
2.【单位名称】
3.【单位所在地】
4.【行业类别】
	根据统计局要求只能选择一个与体育相关的行业代码
	
<span style="color:red;">其中【行业类别】特别重要(涉及直报数据填报表格类型),请慎重核对选择！
若本表格与贵单位情况不吻合，请修改单位资料后重新填写</span>
</pre>
		</div>
            <div class="alert01Bot">
                <button type="button" class="close" name="tipClose">关闭</button>
            </div>
        </div>
    </div>

</body>
</html>

