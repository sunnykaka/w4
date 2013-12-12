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
		var checksumer = null;
		$(function() {
			var messageType = '${param.message}';
			if(messageType) {
				if(messageType == 'save') {
					var nextDocDescriptorId = '${nextDocDescriptorId}' && parseInt('${nextDocDescriptorId}');
					if(!nextDocDescriptorId || isNaN(nextDocDescriptorId)) {
						alert("保存成功，如果您已填写完所有表格，可以点击最终提交按钮进行提交");
					} else {
						if(window.confirm("保存成功，您要填写下一张表格吗？")) {
							window.location.href = "${ctxPath}/declaration/fill.action?targetDocumentId=" + nextDocDescriptorId;
						}
					}
				} else if(messageType == 'tempSave') {
					alert("暂存成功");
				}
			}

			$("#prop_buildDate").datepicker({
				format : "yy-mm-dd",
				changeYear: true,
				changeMonth: true,
				defaultDate : "2000-01-01",
				yearRange: "1980:2013"
			});

			$("#form1").validationEngine(defaultJVEOptions).preventDoubleSubmission();
			$("#save_btn").click(function() {
				return saveDeclaration.call(this, "save");
			});
			$("#temp_save_btn").click(function() {
				return saveDeclaration.call(this, "tempSave");
			});
			$("#submit_btn").click(function() {
				var allDocumentsSaved = true;
				$.ajax({url:'${ctxPath}/ajax/declaration/check_document_saved.action', type:'post', async:false,
					data:{id:'${declaration.id}', documentId:'${document.id}'}, dataType:"text",
					success: function(data) {
						if(data && data != "success") {
							allDocumentsSaved = false;
							alert(data);
						}
					}
				});
				if(!allDocumentsSaved) {
					return false;
				}
				if(window.confirm("直报数据在提交审核之后将不能进行修改.\n您可以在管理员审核之前，通过【撤回】功能取消提交操作.\n您确定要提交吗？")) {
					return saveDeclaration.call(this, "commit");
				}
			});
			$("a[id^='targetDescId']").click(function() {
				return saveDeclaration.call(this, "tempSave", $(this).attr("id").substr("targetDescId_".length));
			});
			$("#cancel_btn").click(function() {
				if(window.confirm("您确定要撤回直报数据吗？")) {
					window.location.href = "${ctxPath}/declaration/cancel.action?id=${declaration.id}";
				}
			});
			//点击文本框即选中内容
			$(":text").bind("click", function() {
				this.select();
			});
			$(":text[money='true']").wrap("<table border='0' cellpadding='0' cellspacing='0'><tr><td style='width:50%'></td><td><span style='color:gray;font-size:9pt'></span></td></tr></table>")
			.change(function() {
				var $this = $(this);
				var value = $this.val();

				if(value != "0" && $.trim(value) && !isNaN(value)) {
					$this.parents("table:first").find("span").html(numToCny(value * 10000));
				} else {
					$this.parents("table:first").find("span").html("");
				}
			}).change();

			<c:if test="${!w4:isDeclarationUpdatable(pageContext, declaration.id)}">
			disableForm("form1", true);
			$("a[id^='targetDescId']").unbind("click").click(function() {
				window.location.href = "${ctxPath}/declaration/fill.action?targetDocumentId=" + $(this).attr("id").substr("targetDescId_".length);
			});
			</c:if>
		});

		/**
		 * action:'tempSave'-暂存;'save'-保存;'commit'-提交
		 */
		var saveDeclaration = function(action, targetDocumentId) {
			clearSubmitMarks();

			if(action === "tempSave") {
				if(targetDocumentId) {
					//跳转到那个表格
					$("<input type='hidden' name='targetDocumentId' value='" + targetDocumentId + "' />").appendTo($("#form1"));
				}
				$("#form1").validationEngine("detach");
			} else {
				//点保存和提交需要验证
				if(checksumer) {
					if(checksumer.checksumAll() === false) {
						return false;
					}
				}
			}

			$("<input type='hidden' name='action' value='" + action + "' />").appendTo($("#form1"));
			$("#form1").submit();
		};

		var clearSubmitMarks = function() {
			var form1 = $("#form1");
			form1.find("input[name='action']").remove();
			form1.find("input[name='targetDocumentId']").remove();
		};

		var validateTableField = function(field, msg) {
			var $field = $(field);
			if(!$.trim($field.val())) {
				alert(msg);
				return false;
			};
			return true;
		};

		var numToCny = function(num){
			if (((num.toString()).indexOf('.') > 16)||(isNaN(num)))
		        return '';
			
			//判断如果是负数先记录并转成正数,最后结果加上负字
			var negative = false;
			if(num < 0) {
				negative = true;
				num = Math.abs(num);
			}
			
			var capUnit = ['万','亿','万','圆',''];
			var capDigit = {2:['角','分',''], 4:['千','百','十','']};
			var capNum=['零','一','二','三','四','五','六','七','八','九'];
			
			num = ((Math.round(num*100)).toString()).split('.');
			num = (num[0]).substring(0, (num[0]).length-2)+'.'+ (num[0]).substring((num[0]).length-2,(num[0]).length);
			num =((Math.pow(10,19-num.length)).toString()).substring(1)+num;
			var i,ret,j,nodeNum,k,subret,len,subChr,CurChr=[];
			for (i=0,ret='';i<5;i++,j=i*4+Math.floor(i/4)){
				nodeNum=num.substring(j,j+4);
				for(k=0,subret='',len=nodeNum.length;((k<len) && (parseInt(nodeNum.substring(k),10)!=0));k++){
					CurChr[k%2] = capNum[nodeNum.charAt(k)]+((nodeNum.charAt(k)==0)?'':capDigit[len][k]);
					if (!((CurChr[0]==CurChr[1]) && (CurChr[0]==capNum[0])))
						if(!((CurChr[k%2] == capNum[0]) && (subret=='') && (ret=='')))
							subret += CurChr[k%2];
				}
				subChr = subret + ((subret=='')?'':capUnit[i]);
				if(!((subChr == capNum[0]) && (ret=='')))
				ret += subChr;
			}
			ret=(ret=='')? capNum[0]+capUnit[3]: ret;
			if(negative) {
				ret = '负' + ret;
			}
			return ret;
		};
		</script>
	</head>
<body>
    <ul class=" publick_bgx crumbs">
        <li><b>当前位置：</b></li>
        <li><a href="#">企业直报</a></li>
        <li>&gt;</li>
        <li><span>数据直报</span></li>
    </ul>
    <dl class="explain">
        <dt><b>填报说明：</b></dt>
        <dd>
        	<c:forEach items="${descriptors}" var="descriptor" varStatus="status">
        		<c:choose>
        			<c:when test="${status.first }">
	        			<c:set var="documentNames" value="${descriptor.code}"/>
        			</c:when>
        			<c:otherwise>
	        			<c:set var="documentNames" value="${documentNames}${'、'}${descriptor.code}"/>
        			</c:otherwise>
        		</c:choose>
        	</c:forEach>
            <ol>
            <li>1、本次申报一其需要填报${fn:length(descriptors)}表格${documentNames}，请按顺序填写，每填完一个保存一次，当所有表格填报完成确认无误后，点【提交】按钮</li>
            <li>2、点击下面各表格标签切换相应表格填写</li>
            <li>3、提交成功后，如发现有误，市里还没审核前，可以点【撤回】按钮，撤回提交的表格重新修改</li>
            <li>4、提交、审核后，不能再修改表格</li>
            <li>5、市审核退回后，申报单位可修改表格数据</li>
            </ol>
        </dd>
    </dl>
    <form:form action="${ctxPath }/declaration/save.action" id="form1" method="post" modelAttribute="document">
    <input type="hidden" name="documentId" value="${document.id }" />
    <div class="tableBox">
        <dl class="rootab">
            <dt>
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
 			<%@ include file="/WEB-INF/page/declaration/tables.jsp"%>
        </dl>
    </div>
    </form:form>
	<c:if test="${declaration.state eq 0 or declaration.state eq 4 }">
	    <div class="audit" id="submit_div">
	        <p class="bottom_button">
	        	<button id="temp_save_btn" type="button">暂存数据</button>
        		<button id="save_btn" type="button">保存数据</button>
            	<button id="submit_btn" type="button">最终提交</button>
	        </p>
	    </div>
    </c:if>
	<c:if test="${declaration.state eq 1 or declaration.state eq 2 }">
		<div class="audit">
	        <p class="bottom_button">
		    	<button id="cancel_btn" type="button">撤回</button>
	        </p>
	    </div>
	</c:if>
</body>
</html>

