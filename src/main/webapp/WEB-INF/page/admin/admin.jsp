<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>
<c:set var="loginUser" value="${sessionScope['com.lianhua.user.model.User'] }" />
<c:set var="currentYear" value="${applicationScope['declaration_year'] }" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>首页</title>
		<script type="text/javascript">
		if(window.top.location != window.self.location) { window.top.location = window.self.location;}
		</script>
		<%@ include file="/WEB-INF/page/inc/common.jsp"%>
		<link rel="stylesheet" type="text/css" href="${ctxPath }/style/public.css"  />
		<script type="text/javascript" src="${ctxPath}/js/public.js"></script>
	</head>
<body>

    <div class=" publick_bgx top">
        <div class="public_bg logo"></div>
        <ul class="public_bg top_nav">
            <li><b>用户：</b><span>
            	<c:choose>
            		<c:when test="${loginUser.type eq 0 }">${loginUser.username}[${loginUser.area.name}]</c:when>
            		<c:when test="${loginUser.type eq 1 }">${loginUser.username}[${loginUser.area.name}管理员]</c:when>
            		<c:when test="${loginUser.type eq 2 }">${loginUser.username}[市管理员]</c:when>
            	</c:choose>
            </span></li>
            <li><b>填报年度：</b><span>${currentYear-1}年</span><a href="#" id="changeYearHref"></a>
            </li>
            <li><b><a href="${ctxPath}/np/user/change_password.action" target="mainFrame">修改密码</a></b></li>
            <li><a href="${ctxPath}/logout.action"><b>退出登录</b></a></li>
        </ul>
    </div>

    <div class="area01">
        <table class="boxTable">
            <tr>
                <td class="autoHeit">
                    <div class="publick_bgy sidbar">
                        <dl>
                            <dt>企业直报</dt>
                            <w4tag:permission url="/declaration/update_company.action">
                            	<dd><a href="${ctxPath }/declaration/update_company.action" target="mainFrame">单位基本资料</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/declaration/approval_list.action">
                            	<dd id="approvalList"><a href="${ctxPath }/declaration/approval_list.action" target="mainFrame" >数据直报</a></dd>
                            </w4tag:permission>
                        </dl>
                        <dl>
                            <dt class="close">直报管理</dt>
                            <w4tag:permission url="/declaration/wait_approve.action">
                            	<dd><a href="${ctxPath }/declaration/wait_approve.action" target="mainFrame">直报数据审核</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/declaration/export.action">
                            	<dd><a href="${ctxPath }/declaration/export.action" target="mainFrame">导出直报数据</a></dd>
                            </w4tag:permission>
                        </dl>
                        <dl>
                            <dt class="close">企业名录库</dt>
							<w4tag:permission url="/company/add.action">
                            	<dd><a href="${ctxPath }/company/add.action" target="mainFrame">企业录入</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/company/list.action">
                            	<dd id="companyList"><a href="${ctxPath }/company/list.action" target="mainFrame">企业资料列表</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/company/wait_approve.action">
                            	<dd><a href="${ctxPath }/company/wait_approve.action?sParam_approveState=1" target="mainFrame">企业资料审核</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/company/final_list.action">
                            	<dd><a href="${ctxPath }/company/final_list.action" target="mainFrame">企业名录库</a></dd>
                            </w4tag:permission>
							<w4tag:permission url="/system/company_import.action">
                            	<dd><a href="${ctxPath }/system/company_import.action" target="mainFrame">导入企业资料</a></dd>
                            </w4tag:permission>
							<w4tag:permission url="/system/company_export.action">
                            	<dd><a href="${ctxPath }/system/company_export.action" target="mainFrame">导出名录库</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/company/sample_list.action">
                            <!--
                            	<dd><a href="${ctxPath }/company/sample_list.action" target="mainFrame">年度抽样企业</a></dd>
                             -->
                            </w4tag:permission>
                        </dl>
						<dl>
                            <dt class="close">公告管理</dt>
							<w4tag:permission url="/adm/notice/add.action">
                            	<dd><a href="${ctxPath }/adm/notice/add.action" target="mainFrame">公告新增</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/adm/notice/list.action">
                            	<dd id="noticeList"><a href="${ctxPath }/adm/notice/list.action" target="mainFrame">公告列表</a></dd>
                            </w4tag:permission>
							<w4tag:permission url="/adm/notice/link_add.action">
                            	<dd><a href="${ctxPath }/adm/notice/link_add.action" target="mainFrame">链接新增</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/adm/notice/link_list.action">
                            	<dd id="linkList"><a href="${ctxPath }/adm/notice/link_list.action" target="mainFrame">链接列表</a></dd>
                            </w4tag:permission>
                        </dl>
						<dl>
                            <dt class="close">系统管理</dt>
							<w4tag:permission url="/user/add.action">
                            	<dd><a href="${ctxPath }/user/add.action" target="mainFrame">用户新增</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/user/list.action">
                            	<dd id="userList"><a href="${ctxPath }/user/list.action" target="mainFrame">用户列表</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/system/set_year.action">
                            	<dd><a href="${ctxPath }/system/set_year.action" target="mainFrame">设置直报年度</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/system/set_major_inquiry.action">
                            	<dd><a href="${ctxPath }/system/set_major_inquiry.action" target="mainFrame">是否启用重点调查</a></dd>
                            </w4tag:permission>
                            <w4tag:permission url="/system/update_contact.action">
                            	<dd><a href="${ctxPath }/system/update_contact.action" target="mainFrame">编辑首页联系方式</a></dd>
                            </w4tag:permission>
                        </dl>
                    </div>
                </td>
                <td class="areaRight" width="100%" style="overflow:hidden;" bgcolor="#ffffff">
                    <div class="iframe_box">
                        <iframe id="mainFrame" name="mainFrame" width="100%" height="100%" src="${ctxPath }/welcome.action" frameborder="no" border="0" marginwidth="0" marginheight="0" allowtransparency="yes"></iframe>
                    </div>
                </td>
            </tr>
        </table>

    </div>
	<script type="text/javascript">
		var dls = document.getElementsByTagName("dl");
		for(var i=0; i<dls.length; i++) {
			var dl = dls[i];
			var dds = dl.getElementsByTagName("dd");
			if(dds.length == 0) {
				dl.style.display="none";
			}
		}

	</script>
</body>
</html>

