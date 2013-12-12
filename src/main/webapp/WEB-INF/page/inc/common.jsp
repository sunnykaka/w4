<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<link rel="stylesheet" type="text/css" href="${ctxPath }/style/base.css"  />
<link rel="stylesheet" type="text/css" href="${ctxPath}/style/jquery-ui-1.8.23.custom.css"/>
<link rel="stylesheet" type="text/css" href="${ctxPath}/style/validationEngine.jquery.css"/>

<script type="text/javascript">var GV = {ctxPath: '${ctxPath}',imgPath: '${ctxPath}/css'};</script>
<script type="text/javascript" src="${ctxPath}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${ctxPath}/js/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="${ctxPath}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctxPath}/js/jquery.validationEngine-zh_CN.js"></script>
<script type="text/javascript" src="${ctxPath}/js/jquery.pagination.js"></script>
<script type="text/javascript" src="${ctxPath}/js/jquery.ui.datepicker-zh-CN.js"></script>
<script type="text/javascript" src="${ctxPath}/js/moment.min.js"></script>
<script type="text/javascript" src="${ctxPath}/js/common.js"></script>
<!--[if lte IE 6]>
		<script src="${ctxPath}/js/DD_belatedPNG.js" type="text/javascript"></script>
		<script type="text/javascript">
			DD_belatedPNG.fix('.public_bg,.act,.nav_ch a:hover');
		</script>
<![endif]-->

<script type="text/javascript">
	//存放页面的分页参数与查询参数
	var pageVariables = {searchParams:{}};
	<%
	Map params = request.getParameterMap();
	for(Iterator iter = params.entrySet().iterator(); iter.hasNext();) {
		Map.Entry entry = (Map.Entry) iter.next();
		String name = (String) entry.getKey();
		String[] values = (String[]) entry.getValue();
		if(values.length==0 || values[0]==null || "".equals(values[0].trim())) continue;
		name = name.trim();
		if("pageIndex".equals(name)) {
			Integer pageIndex = null;
			try {
				pageIndex = Integer.parseInt(values[0].trim());
			} catch (NumberFormatException ignore) {}
			if(pageIndex != null) {
				out.println("pageVariables.pageIndex = '" + pageIndex + "'");
			}
		} else if("pageSize".equals(name)) {
			Integer pageSize = null;
			try {
				pageSize = Integer.parseInt(values[0].trim());
			} catch (NumberFormatException ignore) {}
			if(pageSize != null) {
				out.println("pageVariables.pageSize = '" + pageSize + "'");
			}
		} else if(name.startsWith("sParam_")) {
			//String paramName = name.substring(7);
			out.println("pageVariables.searchParams['" + name + "'] = [];");
			for(String value : values) {
				out.println("pageVariables.searchParams['" + name + "'].push('" + value + "');");
			}
		}
	}
	%>
</script>