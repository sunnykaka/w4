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
    <div class="box w960 marginLRAuto">
    
		<%@ include file="/WEB-INF/page/header.jsp"%>
		
        <div class="banner01 w960">
            <ul class="bannerCon">
                <li><img src="${ctxPath }/picture/banner01.jpg" /></li>
                <li><img src="${ctxPath }/picture/banner02.jpg" /></li>
                <li><img src="${ctxPath }/picture/banner03.jpg" /></li>
                <li><img src="${ctxPath }/picture/banner04.jpg" /></li>
            </ul>
        </div>

        <div class="con">
            <div class="con_area01">
                <div class="public_bg login">
                    <dl>
                        <dt><h2>用户登录</h2></dt>
                        <dd>
						<form:form action="${ctxPath }/login_submit.action" name="login_form" id="login_form" method="post" modelAttribute="user">
	                    	<c:if test="${requestScope[platform:getBindResultKey('user')].errorCount > 0}">
		                    	<script type="text/javascript">
		                    		$(function() {
						    			var errorSpans = $('<form:errors path="*" cssClass="" />');
						    			var alertHtml = "";
						    			errorSpans.each(function() {
						    				alertHtml += $(this).html() + "\n";
						    			});
						    			alert(alertHtml);
		                    		});
		                    	</script>
							</c:if>
                            <ul>
                                <li>
	                                <label>登陆账号：</label>
	                                <input type="text" style="width:100px;" name="username" id="username" data-validation-engine="validate[minSize[3],maxSize[50]]"
		                        		tabindex="1" value="${param.username }"/>
	                        	</li>
                                <li>
                                	<label>登陆密码：</label>
                                	<input type="password" style="width:100px;" name="password" id="password" data-validation-engine="validate[minSize[6],maxSize[20]]"
                                		tabindex="2"/>
                                </li>
                                <li>
                                	<label>两周免登录</label>
                                	<input type="radio" name="saveCookie" id="saveCookie" value="checked" tabindex="3"/>
                                </li>
                                <li class="text_center"><button id="submit_btn" type="button" tabindex="4"></button></li>
                            </ul>
                    	</form:form>
                        </dd>
                    </dl>

                </div>

                <div class="contant01">
                    <dl>
                        <dt class="tit"><h2>技术支持联系方式</h2></dt>
                        <dd>
                            <ul>
                                <li>${supportContactCodes[0].value}&nbsp;&nbsp;${supportContactCodes[1].value}</li>
                                <li>${supportContactCodes[2].value}&nbsp;&nbsp;${supportContactCodes[3].value}</li>
                            </ul>
                        </dd>
                    </dl>

                </div>
            </div>

            <div class="con_area02">
                <div class="news">
                    <dl>
                        <dt class="repeatx_bg tit"><h2 class="public_bg">通知公告</h2><a class="mor" href="${ctxPath}/notice/list.action?sParam_typeId=1" target="_blank">更多>></a></dt>
                        <dd>
                            <ul class="tz_tit">
                            	<c:forEach items="${informationNotices }" var="notice">
                                	<li>
                                		<a target="_blank" href="${ctxPath }/notice/detail.action?noticeId=${notice.id}" title="${notice.title }"><c:out value="${notice.title }" /><c:if test="${notice.news }"><img src="${ctxPath }/ico/icon_arrow_hot.gif"/></c:if></a>
                                		<span class="dath">[<fmt:formatDate value="${notice.addTime }" pattern="yyyy/MM/dd" />]</span>
                                	</li>
                            	</c:forEach>
                            </ul>
                        </dd>
                    </dl>

                </div>
                <div class="news policy">
                    <dl>
                        <dt class="repeatx_bg tit"><h2 class="public_bg">政策法规</h2><a class="mor" href="${ctxPath}/notice/list.action?sParam_typeId=2" target="_blank">更多>></a></dt>
                        <dd>
                            <ul>
                            	<c:forEach items="${politicalNotices }" var="notice">
                                	<li>
                                		<a target="_blank" href="${ctxPath }/notice/detail.action?noticeId=${notice.id}" title="${notice.title }"><c:out value="${notice.title }" /><c:if test="${notice.news }"><img src="${ctxPath }/ico/icon_arrow_hot.gif"/></c:if></a>
                                		<span class="dath">[<fmt:formatDate value="${notice.addTime }" pattern="yyyy/MM/dd" />]</span>
                                	</li>
                            	</c:forEach>
                            </ul>
                        </dd>
                    </dl>

                </div>
            </div>

            <div class="con_area03">
                <div class="news">
                    <dl>
                        <dt class="repeatx_bg tit"><h2 class="public_bg">系统说明</h2><a class="mor" href="${ctxPath}/notice/list.action?sParam_typeId=3" target="_blank">更多>></a></dt>
                        <dd>
                            <ul>
                            	<c:forEach items="${introductionNotices }" var="notice">
                                	<li>
                                		<a target="_blank" href="${ctxPath }/notice/detail.action?noticeId=${notice.id}" title="${notice.title }"><c:out value="${notice.title }" /><c:if test="${notice.news }"><img src="${ctxPath }/ico/icon_arrow_hot.gif"/></c:if></a>
                                	</li>
                            	</c:forEach>
                            </ul>
                        </dd>
                    </dl>

                </div>
                <div class="news policy">
                    <dl>
                        <dt class="repeatx_bg tit"><h2 class="public_bg">相关链接</h2><a class="mor" href="${ctxPath}/notice/link_list.action" target="_blank">更多>></a></dt>
                        <dd>
                            <ul>
                            	<c:forEach items="${links }" var="link">
                                	<li>
                                		<a href="${link.url }" title="${link.title }" target="_blank"><c:out value="${link.title }" /></a>
                                	</li>
                            	</c:forEach>
                            </ul>
                        </dd>
                    </dl>
                </div>
            </div>
        </div>

		<%@ include file="/WEB-INF/page/footer.jsp"%>
    </div>
	<script type="text/javascript" src="${ctxPath}/js/jquery.validationEngine.js"></script>
	<script type="text/javascript" src="${ctxPath}/js/jquery.validationEngine-zh_CN.js"></script>
	<script type="text/javascript" src="${ctxPath}/js/index.js"></script>
	<script type="text/javascript">
	$(function(){
		$('#submit_btn').click(function() {
			if(!$.trim($("#username").val())) {
				alert("请输入用户名");
				$("#username").focus();
				return false;
			}
			if(!$.trim($("#password").val())) {
				alert("请输入密码");
				$("#password").focus();
				return false;
			}
			$("#login_form").submit();
		});
		$(document).keyup(function(event){
			if(event.keyCode == 13){
				$("#submit_btn").trigger("click");
			}
		});
		$("#login_form").validationEngine({scroll:false});
		$('#username').focus();
	});
	</script>
</body>
</html>

