<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>
			<script type="text/javascript">
			$(function() {
				//点击文本框即选中内容
				$(":text").bind("click", function() {
					this.select();
				});
			});
			</script>
			<tr>
				<th><span class="ipt">*</span>组织机构代码：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('code') }"/></th>
				<td><input type="text" name="code" id="code" value="${company.code }" data-validation-engine="validate[required,maxSize[64]]" /></td>
				<th><span class="ipt">*</span>单位名称：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('name') }"/></th>
				<td><input type="text" name="name" id="name" value="${company.name }" data-validation-engine="validate[required,maxSize[64]]" /></td>
			</tr>
			<tr>
				<th style="height:72px;" rowspan="2"><span class="ipt">*</span>单位所在地：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('location') }"/></th>
				<td colspan="3">
					<c:set var="aCountyId" value="${company.contact.countyId }" />
					<c:if test="${empty aCountyId }">
						<c:set var="loginUser" value="${sessionScope['com.lianhua.user.model.User'] }" />
						<c:set var="aCountyId" value="${loginUser.areaId }" />
					</c:if>
					<select><option>广东省</option></select><w4tag:area value="${aCountyId}" cityName="contact.cityId" countyName="contact.countyId" />
					<input type="text" name="contact.location" id="contact.location" value="${company.contact.location }" data-validation-engine="validate[required,maxSize[64]]" style="width:50%"/>
				</td>
			</tr>
			<tr>
				<td colspan="3"><span id="locationDetail"></span></td>
			</tr>
			<tr>
				<th>联系方式<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('contact') }"/></th>
				<td colspan="3">
					<table width="100%">
						<tr>
							<th><span class="ipt">*</span>区号</th>
							<td><input type="text" name="contact.areaCode" id="contact.areaCode" value="${empty company.contact.areaCode ? '0755' : company.contact.areaCode }" data-validation-engine="validate[required,maxSize[4],custom[integer]]" /></td>
							<th><span class="ipt">*</span>电子邮箱</th>
							<td><input type="text" name="contact.email" id="contact.email" value="${company.contact.email }" data-validation-engine="validate[required,maxSize[64],custom[email]]" /></td>
						</tr>
						<tr>
							<th><span class="ipt">*</span>电话号码</th>
							<td><input type="text" name="contact.phone" id="contact.phone" value="${company.contact.phone }" data-validation-engine="validate[required,maxSize[11],custom[integer]]" /></td>
							<th>分机号</th>
							<td><input type="text" name="contact.phoneExt" id="contact.phoneExt" value="${company.contact.phoneExt }" data-validation-engine="validate[maxSize[20]]" /></td>
						</tr>
						<tr>
							<th>传真号码</th>
							<td><input type="text" name="contact.fax" id="contact.fax" value="${company.contact.fax }" data-validation-engine="validate[maxSize[11],custom[integer]]" /></td>
							<th><span class="ipt">*</span>邮政编码</th>
							<td><input type="text" name="contact.zipCode" id="contact.zipCode" value="${company.contact.zipCode }" data-validation-engine="validate[required,minSize[2],maxSize[20]]" /></td>
						</tr>
						<tr>
							<th>网址</th>
							<td colspan="3"><input type="text" name="contact.website" id="contact.website" value="${company.contact.website }" data-validation-engine="validate[maxSize[128]]" /></td>
						</tr>
					</table>
				</td>
			</tr>
	        <tr>
				<th>主营还是兼营体育业务：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('businessType') }"/></th>
				<td colspan="3">
					<w4tag:code kind="company_business_type" name="businessTypeCode" value="${company.businessTypeCode}" type="radio" />
				</td>
			</tr>
			<tr>
				<th><span class="ipt">*</span>主要体育业务活动（或主要产品）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('product') }"/></th>
				<td>1、<input type="text" name="product1" id="product1" value="${company.product1 }" data-validation-engine="validate[maxSize[64]]" /></td>
				<td>2、<input type="text" name="product2" id="product2" value="${company.product2 }" data-validation-engine="validate[maxSize[64]]" /></td>
				<td>3、<input type="text" name="product3" id="product3" value="${company.product3 }" data-validation-engine="validate[maxSize[64]]" /></td>
			</tr>
			<tr>
				<th><span class="ipt">*</span>行业类别：</th>
				<td colspan="3"><span id="categoryLabel"><c:out value="${currentCategory}" /></span><button type="button" id="categoryBtn">请选择</button>
				<input type="hidden" name="categoryCode" id="categoryCode" value="${company.categoryCode}" /></td>
			</tr>
			<tr>
				<th><span class="ipt">*</span>登记注册类型：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('register') }"/></th>
				<td colspan="3"><w4tag:code kind="company_register" name="registerCode" value="${company.registerCode }" required="true"/></td>
			</tr>
			<tr>
				<th><span class="ipt">*</span>执行会计制度类别：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('accounting') }"/></th>
				<td colspan="3"><w4tag:code kind="accounting" name="accountingCode" value="${company.accountingCode }" type="radio" required="true"/></td>
			</tr>
			<tr>
				<th><span class="ipt">*</span>机构类型：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('organization') }"/></th>
				<td colspan="3"><w4tag:code kind="organization" name="organizationCode" value="${company.organizationCode }" type="radio" required="true"/></td>
			</tr>
            <tr>
                <th><span class="ipt">*</span>平均从业人员（人）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getCompanyTip('employeeNum') }"/></th>
                <td colspan="3"><input type="text" name="employeeNum" id="employeeNum" value="${company.employeeNum}" data-validation-engine="validate[required,custom[integer]]" style="width:9%"/></td>
            </tr>
            <tr>
                <th>其中：</th>
                <td colspan="3">
                    <table class="lineTable">
                        <tbody>
                            <tr>
                                <th><span class="ipt">*</span>研究生</th>
                                <td><input type="text" style="width:100px;" name="masterNum" id="masterNum" value="${company.masterNum}" data-validation-engine="validate[required,custom[integer]]"/></td>
                                <td>人</td>
                                <th><span class="ipt">*</span>本科学历 </th>
                                <td><input type="text" style="width:100px;" name="bachelorNum" id="bachelorNum" value="${company.bachelorNum}" data-validation-engine="validate[required,custom[integer]]"/></td>
                                <td>人</td>
                                <th><span class="ipt">*</span>专科学历 </th>
                                <td><input type="text" style="width:100px;" name="collegeNum" id="collegeNum" value="${company.collegeNum}" data-validation-engine="validate[required,custom[integer]]"/></td>
                                <td>人</td>
                                <th><span class="ipt">*</span>其他 </th>
                                <td><input type="text" style="width:100px;" name="otherNum" id="otherNum" value="${company.otherNum}" data-validation-engine="validate[required,custom[integer]]"/></td>
                                <td>人</td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
			<tr>
				<td style="padding:inherit;" colspan="4">
					<table class="lineTable">
						<tbody>
							<tr>
								<th><span class="ipt">*</span>单位负责人：</th>
								<td><input type="text" name="principal" id="principal" value="${company.principal }" data-validation-engine="validate[required,maxSize[32]]" /></td>
								<th><span class="ipt">*</span>填表人：</th>
								<td><input type="text" name="preparer" id="preparer" value="${company.preparer }" data-validation-engine="validate[required,maxSize[32]]" /></td>
								<th><span class="ipt">*</span>联系电话：</th>
								<td><input type="text" name="mobile" id="mobile" value="${company.mobile }" data-validation-engine="validate[required,custom[integer],maxSize[11]]" /></td>
								<th>填表日期：</th>
								<c:choose>
									<c:when test="${empty company.signDate}">
										<c:set var="signDate" value="<%=new java.util.Date() %>" />
									</c:when>
									<c:otherwise>
										<c:set var="signDate" value="${company.signDate }" />
									</c:otherwise>
								</c:choose>
								<td><input type="text" name="signDate" id="signDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${signDate }" />' readonly="readonly"/></td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>

