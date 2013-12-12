<%@ tag pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>

<%@ attribute name="company" required="true" rtexprvalue="true" type="com.lianhua.company.model.Company" %>
<%@ attribute name="document" required="true" rtexprvalue="true" type="com.lianhua.document.model.Document" %>
						<script type="text/javascript">
							$(function() {
								checksumer = TableChecksum();
								checksumer.checksum([
									{id:"prop_salesRevenue",text:"销售收入"}, 
									{id:"prop_totalRevenue",text:"体育用品、服装鞋帽销售总收入"}
									]
								);
								checksumer.checksum([
									{value:100, text:"100%"}, 
									{id:"prop_sportsRatio", text:"体育用品销售收入占比"},
									{id:"prop_clothesRatio", text:"体育服装销售收入占比"},
									{id:"prop_catsRatio", text:"体育鞋帽销售收入占比"}
									], {relation: "="}
								);
								checksumer.checksum([
									{id:"prop_businessExpend",text:"营业支出"}, 
									{id:"prop_employeePay",text:"年雇员报酬"}
									]
								);
							});
						</script>
		                <tr>
		                    <th>单位所在地及行政区划：</th>
		                    <td colspan="3"><c:out value="${company.contact.location }"/></td>
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
							<th>主营业务：</th>
							<td>
								<table width="100%">
									<tr>
		                                <td>1、<input type="text" name="prop_product1" id="prop_product1" value="${w4:showValue(document, 'product1')}" data-validation-engine="validate[maxSize[64]]" /></td>
		                                <td>2、<input type="text" name="prop_product2" id="prop_product2" value="${w4:showValue(document, 'product2')}" data-validation-engine="validate[maxSize[64]]" /></td>
		                                <td>3、<input type="text" name="prop_product3" id="prop_product3" value="${w4:showValue(document, 'product3')}" data-validation-engine="validate[maxSize[64]]" /></td>
		                            </tr>
								</table>
							</td>
						</tr>
				        <tr>
							<th>营业面积：</th>
							<td>
								<input type="text" name="prop_businessArea" id="prop_businessArea" value="${w4:showValue(document, 'businessArea')}" data-validation-engine="validate[required,custom[number]]" />平方米
							</td>
						</tr>
						<tr>
                            <td style="padding-left:inherit;" colspan="4">
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
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp;其中：体育用品、服装鞋帽销售总收入<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'totalRevenue') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_totalRevenue" id="prop_totalRevenue" value="${w4:showNumber(document, 'totalRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
										<tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;其中：体育用品销售收入占比<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'sportsRatio') }" /></th>
                                            <td>%</td>
                                            <td><input type="text" name="prop_sportsRatio" id="prop_sportsRatio" value="${w4:showNumber(document, 'sportsRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 体育服装销售收入占比<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'clothesRatio') }" /></th>
											<td>%</td>
                                            <td><input type="text" name="prop_clothesRatio" id="prop_clothesRatio" value="${w4:showNumber(document, 'clothesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                        </tr>
										<tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 体育鞋帽销售收入占比<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'catsRatio') }" /></th>
											<td>%</td>
                                            <td><input type="text" name="prop_catsRatio" id="prop_catsRatio" value="${w4:showNumber(document, 'catsRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                        </tr>
                                        <tr>
                                            <th>营业支出<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'businessExpend') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_businessExpend" id="prop_businessExpend" value="${w4:showNumber(document, 'businessExpend')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>其中：年雇员报酬<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'employeePay') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_employeePay" id="prop_employeePay" value="${w4:showNumber(document, 'employeePay')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>每年缴纳各种税金和费用<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'taxAndCost') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_taxAndCost" id="prop_taxAndCost" value="${w4:showNumber(document, 'taxAndCost')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>营业场所租赁年租金<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'rent') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_rent" id="prop_rent" value="${w4:showNumber(document, 'rent')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
										<tr>
                                            <th>平均从业人员数<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'employeeNum') }" /></th>
											<td>人</td>
                                            <td><input type="text" name="prop_employeeNum" id="prop_employeeNum" value="${company.employeeNum}" disabled="disabled" /></td>
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
