<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>首页</title>
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/index_base.css"  />
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/index_public.css"  />
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/index_index.css"  />
		<link rel="stylesheet" type="text/css" href="${ctxPath}/style/validationEngine.jquery.css"/>
		<script type="text/javascript">var GV = {ctxPath: '${ctxPath}',imgPath: '${ctxPath}/ico'};</script>
		<script type="text/javascript" src="${ctxPath}/js/jquery-1.7.2.min.js"></script>
<!--[if lte IE 6]>
		<script src="${ctxPath}/js/DD_belatedPNG.js" type="text/javascript"></script>
		<script type="text/javascript">
			DD_belatedPNG.fix('.public_bg,.act,.nav_ch a:hover');
		</script>
<![endif]-->
	</head>
<body>
    <div class="marginLRAuto w960">
    
        <%@ include file="/WEB-INF/page/header.jsp"%>
        
        <div class="contant w960 marginLRAuto">
            <ul class=" publick_bgx crumbs">
                <li><b>当前位置：</b></li>
                <li><a href="${ctxPath }/notice/list.action?sParam_typeId=${notice.typeId}"><c:out value="${notice.type.title }" /></a></li>
                <li>&gt;</li>
                <li><span><c:out value="${notice.title }" /></span></li>
            </ul>
            <div class="c_con">
                <h2 class="tit"><c:out value="${notice.title }" /></h2>
                <h3 class="dath"><fmt:formatDate value="${notice.addTime }" pattern="yyyy-MM-dd" /></h3>
                <p>${notice.content}</p>
            </div>
        </div>
        

        <%@ include file="/WEB-INF/page/footer.jsp"%>

    </div>
</body>
</html>

