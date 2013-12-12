<%@ tag pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>

<%@ attribute name="company" required="true" rtexprvalue="true" type="com.lianhua.company.model.Company" %>
<%@ attribute name="document" required="true" rtexprvalue="true" type="com.lianhua.document.model.Document" %>
						<script type="text/javascript">
							$(function() {
								checksumer = TableChecksum();
								checksumer.checksum([
									{id:"prop_salesRevenue",text:"销售收入"}, 
									{id:"prop_sportsRevenue",text:"体育用品/体育服装鞋帽/体育相关产品销售收入"}
									]
								);
								checksumer.checksum([
									{id:"prop_employeeNum",text:"平均从业人员数"}, 
									{id:"prop_sportsEmployeeNum",text:"体育用品、体育服装鞋帽、体育相关产品销售从业人员数"}
									]
								);
							});
						</script>
		                <tr>
		                    <th>单位所在地及行政区划：</th>
		                    <td><c:out value="${company.contact.location }"/></td>
		                </tr>
		                <tr>
		                    <th>联系方式</th>
		                    <td>
		                        <table width="100%">
		                            <tr>
		                                <th>区号</th>
		                                <td><c:out value="${company.contact.areaCode }"/></td>
		                                <th>电子邮箱</th>
		                                <td><c:out value="${company.contact.email }"/></td>
		                            </tr>
		                            <tr>
		                                <th>电话号码</th>
		                                <td><c:out value="${company.contact.phone }"/></td>
		                                <th>分机号</th>
		                                <td><c:out value="${company.contact.phoneExt }"/></td>
		                            </tr>
		                            <tr>
		                                <th>传真号码</th>
		                                <td><c:out value="${company.contact.fax }"/></td>
		                                <th>邮政编码</th>
		                                <td><c:out value="${company.contact.zipCode }"/></td>
		                            </tr>
		                            <tr>
		                                <th>网址</th>
		                                <td colspan="3"><c:out value="${company.contact.website }"/></td>
		                            </tr>
		                        </table>
		                    </td>
		                </tr>
				        <tr>
							<th>所属行业：</th>
							<td colspan="4">
								<w4tag:code kind="t110_option" name="prop_industryCode" value="${w4:showValue(document, 'industryCode')}" type="checkbox" required="true" />
							</td>
						</tr>
						<tr>
                            <td style="padding:inherit;" colspan="2">
                                <table>
                                    <thead>
                                        <tr>
                                            <th style="width:12%">统计时间范围</th>
                                            <th style="width:20%">指标名称</th>
											<th style="width:6%">单位</th>
                                            <th>本年实际</th>
                                        </tr>
                                    </thead>
                                    <tbody class="thL">
										<tr>
                                            <td rowspan="12">${w4:showStatYear(document)}年</td>
                                            <td colspan="3"></td>
                                        </tr>
                                        <tr>
                                            <th>销售收入<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'salesRevenue') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_salesRevenue" id="prop_salesRevenue" value="${w4:showNumber(document, 'salesRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
										<tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp;其中：体育用品/体育服装鞋帽/体育相关产品销售收入<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'sportsRevenue') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_sportsRevenue" id="prop_sportsRevenue" value="${w4:showNumber(document, 'sportsRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
										<tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;体育用品/体育服装鞋帽/体育相关产品批发销售额占比</th>
                                            <td>%</td>
                                            <td><input type="text" name="prop_wholesaleRatio" id="prop_wholesaleRatio" value="${w4:showNumber(document, 'wholesaleRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                        </tr>
										<tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;体育用品/体育服装鞋帽/体育相关产品零售销售额占比</th>
                                            <td>%</td>
                                            <td><input type="text" name="prop_retailRatio" id="prop_retailRatio" value="${w4:showNumber(document, 'retailRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                        </tr>
										<tr>
                                            <th>平均从业人员数<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'employeeNum') }" /></th>
											<td>人</td>
                                            <td><input type="text" name="prop_employeeNum" id="prop_employeeNum" value="${company.employeeNum}" disabled="disabled" /></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; 其中：体育用品、体育服装鞋帽、体育相关产品销售从业人员数<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'sportsEmployeeNum') }" /></th>
											<td>人</td>
                                            <td><input type="text" name="prop_sportsEmployeeNum" id="prop_sportsEmployeeNum" value="${w4:showNumber(document, 'sportsEmployeeNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
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
										<td><input type="text" name="principal" id="principal" value="${company.principal }" disabled="disabled" /></td>
										<th><span class="ipt">*</span>填表人：</th>
										<td><input type="text" name="preparer" id="preparer" value="${document.preparer }" data-validation-engine="validate[required]"/></td>
										<th><span class="ipt">*</span>联系电话：</th>
										<td><input type="text" name="mobile" id="mobile" value="${document.mobile }" data-validation-engine="validate[required,custom[integer],maxSize[11]]"/></td>
										<th >填表日期：</th>
										<c:choose>
											<c:when test="${empty document.signDate}">
												<c:set var="signDate" value="<%=new java.util.Date() %>" />
											</c:when>
											<c:otherwise>
												<c:set var="signDate" value="${document.signDate }" />
											</c:otherwise>
										</c:choose>
										<td><input type="text" name="signDate" id="signDate" value='<fmt:formatDate pattern="yyyy-MM-dd" value="${signDate }" />' readonly="readonly"/></td>
									</tr>
								</tbody>
								</table>
                            </td>
                        </tr>
