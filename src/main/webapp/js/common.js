//jQuery plugin to prevent double submission of forms
jQuery.fn.preventDoubleSubmission = function() {
	$(this).bind('submit', function(e) {
		var $form = $(this);
		if ($form.data('validation_failed') != "fail") {	//兼容jve
			if ($form.data('submitted') === true) {
				// Previously submitted - don't submit again

				e.preventDefault();
			} else {
				// Mark it so that the next submit can be ignored
				$form.data('submitted', true);
			}
		}
	});

	// Keep chainability
	return this;
};

$(function(){
	$("[name='operate_confirm']").click(function() {
		var $this = $(this);
		var label = $this.attr('label') || "您确定要进行该操作吗?";
		var noAlert = $this.attr('noAlert');
		if((noAlert && noAlert==="true") || window.confirm(label)){
			var url = $this.attr('uri');
			url = putPageVariablesInUrl(url);
			window.location.href = url;
		};
		return false;
	});

	//批量操作按钮
	$("[name='operate_all_confirm']").click(function(){
		var $this = $(this);
		var formId = $this.attr('form');
		var formObj = $("#" + formId);
		var entityId = $this.attr('entityId');
		if(entityId) {
			if($("[name='" + entityId + "']:checked").length == 0) {
				//没有一个被选中,返回
				return false;
			}
		}
		var label = $this.attr('label') || "您确定要进行该操作吗?";
		if(window.confirm(label)) {
			if($this.attr('uri')) {
				formObj.attr("action", $this.attr('uri'));
			}
			putPageVariablesInForm(formObj);

			formObj.submit();
		};
		return false;
	});

	//全选按钮
	$("input:checkbox[name='checkAll']").click(function(){
		var $this = $(this);
		var $form = $this.parents("form");
		var checkboxList = $form.find("input:checkbox").not(this);
		if($this.attr("checked")) {
			checkboxList.attr("checked", true);
		} else {
			checkboxList.attr("checked", false);
		}
	});
	
	
	//列表页面ajax设置排序号
	$("input[name='updateBySort']").change(function() {
		var $this = $(this);
		var bySort = $this.val();
		if(isNaN(parseInt(bySort))) {
			return;
		}
		$.post($this.attr('uri'), {entityId:$this.attr("entity-id"),bySort:$this.val()}, function(data) {});
	});

	//设置默认显示文本
	$("input:text[defaultText]").each(function() {
		var $this = $(this);
		var defaultText = $this.attr("defaultText");
		if($.trim($this.val()) == "") {
			$this.val(defaultText).css("color", "#999");
		}
		$this.bind({
	        focus: function() {
	            var _this = $(this);
	            if ($.trim(_this.val()) == defaultText) {
	            	_this.val("").css("color", "#000");
	            }
	        },
	        blur: function() {
	            var _this = $(this);
	            if ($.trim(_this.val()) == "") {
	            	_this.val(defaultText).css("color", "#999");
	            }
	        }
	    });
	});

	$("a[sparam='true']").each(function(){
		var $this = $(this);
		var url = $this.attr('href');
		url = putPageVariablesInUrl(url);
		$this.attr('href', url);
	});

	$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
});
//默认的jquery validation engine参数
var defaultJVEOptions = {onValidationComplete: function(form, status){
	form.data('validation_failed', status ? "success" : "fail");
	if(status) return true;
}};

var randomNumber = function(count) {
	if(count <= 0 ) count = 1;
	return Math.round(Math.random() * 10 * count);
};

//为搜索表单添加分页参数
var putPageVariablesInForm = function(form) {
	//设置分页参数
	if(!pageVariables) return;
	if(pageVariables.pageIndex) {
		$("<input type='hidden' name='pageIndex' value='" + pageVariables.pageIndex + "' />").appendTo(form);
	}
	if(pageVariables.pageSize) {
		$("<input type='hidden' name='pageSize' value='" + pageVariables.pageSize + "' />").appendTo(form);
	}
	if(pageVariables.searchParams) {
		for(var paramName in pageVariables.searchParams) {
			var paramValues = pageVariables.searchParams[paramName];
			for(var i=0; i < paramValues.length; i++) {
				$("<input type='hidden' name='" + paramName + "' value='" + paramValues[i] + "' />").appendTo(form);
			}
		}
	}
};

//为搜索表单添加查询参数
var handleSearchForm = function(form) {
	//将搜索框的默认文本值置为空
	form.find("input:text[defaultText]").each(function() {
		var $this = $(this);
		var defaultText = $this.attr("defaultText");
		if($.trim($this.val()) == defaultText) {
			$this.val("");
		}
	});
};

//为跳转url设置分页和查询参数
var putPageVariablesInUrl = function() {
	var appendUrl = function(url, str) {
		var index = url.indexOf("?");
		if(index == -1) {
			url += "?" + str;
		} else if(index == url.length - 1) {
			url += str;
		} else {
			url += "&" + str;
		}
		return url;
	};

	return function(url) {
		if(!pageVariables) return url;
		if(pageVariables.pageIndex) {
			if(url.indexOf("pageIndex") == -1) {
				url = appendUrl(url, "pageIndex=" + pageVariables.pageIndex);
			}
		}
		if(pageVariables.pageSize) {
			if(url.indexOf("pageSize") == -1) {
				url = appendUrl(url, "pageSize=" + pageVariables.pageSize);
			}
		}
		if(pageVariables.searchParams) {
			for(var paramName in pageVariables.searchParams) {
				var paramValues = pageVariables.searchParams[paramName];
				for(var i=0; i < paramValues.length; i++) {
					url = appendUrl(url, paramName + "=" + encodeURIComponent(paramValues[i]));
				}
			}
		}
		return url;
	};

}();

//禁用form表单中所有的input[文本框、复选框、单选框],select[下拉选],多行文本框[textarea]
var disableForm = function(formId,isDisabled) {
    var attr="disable";
    if(!isDisabled){
       attr="enable";
    }
    $("form[id='"+formId+"'] :text").attr("disabled",isDisabled);
    $("form[id='"+formId+"'] textarea").attr("disabled",isDisabled);
    $("form[id='"+formId+"'] select").attr("disabled",isDisabled);
    $("form[id='"+formId+"'] :radio").attr("disabled",isDisabled);
    $("form[id='"+formId+"'] :checkbox").attr("disabled",isDisabled);
};

var aleAuto = function($dom){
	var aleT = ($(window).height()-420)/2,
	aleL = ($(window).width()-450)/2;
	$dom.offset({top:aleT,left:aleL});
};

var activeCategorySelect = function(data) {

	var setting = {
		data: {},
		callback: {},
		view: {showIcon:false}
	};

	$.fn.zTree.init($("#tree1"), setting, data);

	$("#categoryBtn").click(function() {
		$('#categoryDiv').show();
	});

    aleAuto($("#categoryDiv"));

	$("#categoryCloseBtn, #categoryCloseHref").click(function() {
		$('#categoryDiv').hide();
	});
	$("#categoryOkBtn").click(function() {
		var treeObj = $.fn.zTree.getZTreeObj("tree1");
		var nodes = treeObj.getSelectedNodes();
		if(!nodes || nodes.length == 0) {
			alert("请选择一个行业类别");
			return false;
		}
		if(nodes.length > 1) {
			alert("至多只能选择一个行业类别");
			return false;
		}
		var selectedNode = nodes[0];
		if(selectedNode) {
			if(selectedNode.aLevel < 3) {
				alert("只能选择三级以上子类");
				return false;
			}
			var label = selectedNode.name;
			var parent = selectedNode.getParentNode();
			while(parent && parent.name) {
				label = parent.name + ">" + label;
				parent = parent.getParentNode();
			}
			$("#categoryLabel").html(label);
			$("#categoryCode").val(selectedNode.id);
    		$('#categoryDiv').hide();
		}
	});
};

/**
 * 校验表格内数据间大小关系的工具类
 * 使用方法:
 * 例如有id=1,id=2,id=3的3个input域,需要满足关系:$("#1").val() = $("#2").val() + $("#3").val()
 * 则这样调用
	checksumer = TableChecksum();
	checksumer.checksum([
		{id:"1",text:"表单域1"},
		{id:"2",text:"表单域2"},
		{id:"2",text:"表单域3"}
		], {relation:"="}
	);
	这样会在表单域3上注册onchange事件,当onchange事件触发的时候进行校验,校验不通过会弹出提示框
	如果需要在表单提交前校验所有规则,调用checksumer.checksumAll(),校验成功返回true否则返回false
	支持的relation:=、>=、>、<、<=
	text属性不是必须的,可以在调用时传入alertText参数,例如{relation:"=",alertText:"数据校验失败"}
	这样将忽略text属性
 */
var TableChecksum = function() {
	//存储校验规则
	var _rules = [];

	var checksumer = {
		/**
		 * 为表单域添加校验规则
		 * @param elements
		 * @param opts
		 */
		checksum: function(elements, opts){
			opts = jQuery.extend({
				relation: ">="
			},opts||{});
			var _this = this;
			$("#" + elements[elements.length-1]["id"]).change(function() {
				_this._validateRule(elements, opts);
			});
			//缓存校验规则
			_rules.push([elements, opts]);
		},

		/**
		 * 校验所有规则
		 * @returns {Boolean}
		 */
		checksumAll: function(){
			for(var i=0; i<_rules.length; i++) {
				if(checksumer._validateRule(_rules[i][0], _rules[i][1]) === false) {
					return false;
				}
			}
		},

		//根据规则进行校验
		_validateRule: function(elements, opts) {
			var expectValue = 0;
			var actualValue = 0;
			var expectElement = elements[0];
			if("id" in expectElement) {
				//等于input域的内容
				expectValue = parseFloat($("#" + expectElement["id"]).val());
			} else {
				//等于某一个值
				expectValue = expectElement["value"];
			}
			for(var i=1; i<elements.length; i++) {
				var value = parseFloat($("#" + elements[i]["id"]).val());
				actualValue += value;
			}
			var result = false;
			if(isNaN(expectValue) || isNaN(actualValue)) {
				result = false;
			} else {
				expectValue = parseFloat(expectValue.toFixed(4));
				actualValue = parseFloat(actualValue.toFixed(4));
				result = checksumer._checkRelation(expectValue, actualValue, opts.relation);
			}
			if(result === true) {
				return true;
			} else {
				checksumer._showAlertText(elements, opts);
				return false;
			}
		},

		_checkRelation: function(expectValue, actualValue, relation) {
			var result = false;
			switch(relation) {
			case "=":
				result = expectValue === actualValue;
				break;
			case ">=":
				result = expectValue >= actualValue;
				break;
			case ">":
				result = expectValue > actualValue;
				break;
			case "<":
				result = expectValue < actualValue;
				break;
			case "<=":
				result = expectValue <= actualValue;
				break;
			}

			return result;
		},

		_showAlertText: function(elements, opts) {
			if(opts.alertText) {
				alert(opts.alertText);
			} else {
				var text = "数据校验失败, 需要满足条件：";
				var sumerText = "";
				var otherTextArr = [];
				for(var i=0; i<elements.length; i++) {
					if(i === 0) {
						sumerText = " " + elements[i]["text"];
					} else {
						otherTextArr.push(" " + elements[i]["text"]);
					};
				}
				if("id" in elements[0]) {
					text = text + sumerText + " " + opts.relation + otherTextArr.join(" +");
				} else {
					text = text + otherTextArr.join(" +") + " " + checksumer._reverseRelation(opts.relation) + " " + sumerText;
				}
				alert(text);
			}
			$("#" + elements[elements.length-1]["id"]).focus();
		},

		_reverseRelation: function(relation) {
			var result = relation;
			switch(relation) {
			case "=":
				break;
			case ">=":
				result = "<=";
				break;
			case ">":
				result = "<";
				break;
			case "<":
				result = ">";
				break;
			case "<=":
				result = ">=";
				break;
			}
			return result;
		}

	};
	return checksumer;
};

//选中左边的导航dd
var selectLeftDd = function(ddId) {
	try {
		var dds = top.document.getElementsByTagName("dd");
		for(var i=0; i<dds.length; i++) {
			var ddDom = dds[i];
			ddDom.removeAttribute("class");
		}
		var approvalList = top.document.getElementById(ddId);
		if(approvalList) {
			approvalList.setAttribute("class", "act");
		}
	} catch (e) {}
};