<%@ tag pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>

<%@ attribute name="company" required="true" rtexprvalue="true" type="com.lianhua.company.model.Company" %>
<%@ attribute name="document" required="true" rtexprvalue="true" type="com.lianhua.document.model.Document" %>
						<script type="text/javascript">
							$(function() {
								checksumer = TableChecksum();
								checksumer.checksum([
									{id:"prop_branchTotal"}, 
									{id:"prop_futianBranchNum"},
									{id:"prop_yantianBranchNum"},
									{id:"prop_longgangBranchNum"}, 
									{id:"prop_dapengBranchNum"},
									{id:"prop_baoanBranchNum"},
									{id:"prop_luohuBranchNum"}, 
									{id:"prop_nanshanBranchNum"},
									{id:"prop_pingshanBranchNum"},
									{id:"prop_longhuaBranchNum"}, 
									{id:"prop_guangmingBranchNum"}
									], {relation: "=", alertText: "数据校验失败! 年末全市体育彩票网点总数需要等于各区网点数之和"}
								);
								checksumer.checksum([
									{value:100, text:"100%"}, 
									{id:"prop_sportsTicketNum", text:"只销售体育彩票的网点"},
									{id:"prop_sportsAndWelfareTicketNum", text:"只销售体育彩票的网点"},
									{id:"prop_otherTicketNum", text:"除彩票外还销售其他商品的网点"}
									], {relation: "="}
								);
								checksumer.checksum([
									{id:"prop_totalSales",text:"本年体育彩票销售总量"}, 
									{id:"prop_guessSales",text:"竞猜型彩票"},
									{id:"prop_probabilitySales",text:"概率型彩票"}, 
									{id:"prop_instantSales",text:"即开型彩票"},
									{id:"prop_otherSales",text:"其他彩票"}
									], {relation: "="}
								);
								checksumer.checksum([
									{value:100, text:"100%"},
									{id:"prop_futianSalesRatio"},
									{id:"prop_yantianSalesRatio"},
									{id:"prop_longgangSalesRatio"}, 
									{id:"prop_dapengSalesRatio"},
									{id:"prop_baoanSalesRatio"},
									{id:"prop_luohuSalesRatio"}, 
									{id:"prop_nanshanSalesRatio"},
									{id:"prop_pingshanSalesRatio"},
									{id:"prop_longhuaSalesRatio"}, 
									{id:"prop_guangmingSalesRatio"}
									], {relation: "=", alertText: "数据校验失败! 各区销售占比之和需要等于100%"}
								);
								checksumer.checksum([
									{value:1.8, text:"1.8万元"},
									{id:"prop_averagePay", text:"年人均雇员报酬"}
									], {relation: "<="}
								);
							});
						</script>
						<tr>
                            <td>一、销售网点基本情况</td>
                            <td style="padding:inherit;" colspan="2">
                                <table>
                                    <thead>
                                        <tr>
	                                        <th>年末全市体育彩票网点总数：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'branchTotal') }"/></th>
											<td><input type="text" name="prop_branchTotal" id="prop_branchTotal" value="${w4:showNumber(document, 'branchTotal')}" data-validation-engine="validate[required,custom[integer]]"/></td>
											<td>个</td>
                                        </tr>
                                        <tr>
	                                        <th>全市体育彩票网点从业人员总数：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'employeeNum') }"/></th>
	                                        <td><input type="text" name="prop_employeeNum" id="prop_employeeNum" value="${w4:showNumber(document, 'employeeNum')}" data-validation-engine="validate[required,custom[integer]]"/></td>
	                                        <td>人</td>
                                        </tr>
                                        <tr>
                                            <th>区</th>
                                            <th>网点数</th>
                                            <th>单位</th>
                                        </tr>
                                    </thead>
                                    <tbody class="thL">
                                        <tr>
                                            <td>福田</td>
                                            <td><input type="text" name="prop_futianBranchNum" id="prop_futianBranchNum" value="${w4:showNumber(document, 'futianBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>盐田</td>
                                            <td><input type="text" name="prop_yantianBranchNum" id="prop_yantianBranchNum" value="${w4:showNumber(document, 'yantianBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>龙岗</td>
                                            <td><input type="text" name="prop_longgangBranchNum" id="prop_longgangBranchNum" value="${w4:showNumber(document, 'longgangBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>大鹏</td>
                                            <td><input type="text" name="prop_dapengBranchNum" id="prop_dapengBranchNum" value="${w4:showNumber(document, 'dapengBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>宝安</td>
                                            <td><input type="text" name="prop_baoanBranchNum" id="prop_baoanBranchNum" value="${w4:showNumber(document, 'baoanBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>罗湖</td>
                                            <td><input type="text" name="prop_luohuBranchNum" id="prop_luohuBranchNum" value="${w4:showNumber(document, 'luohuBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>南山</td>
                                            <td><input type="text" name="prop_nanshanBranchNum" id="prop_nanshanBranchNum" value="${w4:showNumber(document, 'nanshanBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>坪山</td>
                                            <td><input type="text" name="prop_pingshanBranchNum" id="prop_pingshanBranchNum" value="${w4:showNumber(document, 'pingshanBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>龙华</td>
                                            <td><input type="text" name="prop_longhuaBranchNum" id="prop_longhuaBranchNum" value="${w4:showNumber(document, 'longhuaBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>光明</td>
                                            <td><input type="text" name="prop_guangmingBranchNum" id="prop_guangmingBranchNum" value="${w4:showNumber(document, 'guangmingBranchNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>个</td>
                                        </tr>
                                        <tr>
                                            <td>销售站点类型</td>
                                            <td colspan="2">
                                                <table>
                                                <tbody>
                                                    <tr>
		                                    			<td>只销售体育彩票的网点：</td>
		                                    			<td><input type="text" name="prop_sportsTicketNum" id="prop_sportsTicketNum" value="${w4:showNumber(document, 'sportsTicketNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                                        <td>%</td>
                                                    </tr>
                                                    <tr>
					                                    <td>只销售体育彩票和福利彩票的网点：</td>
					                                    <td><input type="text" name="prop_sportsAndWelfareTicketNum" id="prop_sportsAndWelfareTicketNum" value="${w4:showNumber(document, 'sportsAndWelfareTicketNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                                        <td>%</td>
                                                    </tr>
                                                    <tr>
					                                    <td>除彩票外还销售其他商品的网点：</td>
					                                    <td><input type="text" name="prop_otherTicketNum" id="prop_otherTicketNum" value="${w4:showNumber(document, 'otherTicketNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                                        <td>%</td>
                                                    </tr>
                                                </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
						<tr>
                            <td>二、全市体彩销售情况</td>
                            <td style="padding:inherit;" colspan="2">
                                <table>
                                    <thead class="thL">
                                        <tr>
	                                        <th>1、本年体育彩票销售总量：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'totalSales') }"/></th>
											<td><input type="text" name="prop_totalSales" id="prop_totalSales" value="${w4:showNumber(document, 'totalSales')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>万元</td>
                                        </tr>
                                        <tr>
	                                        <th>其中：竞猜型彩票：</th>
											<td><input type="text" name="prop_guessSales" id="prop_guessSales" value="${w4:showNumber(document, 'guessSales')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>万元</td>
                                        </tr>
                                        <tr>
	                                        <th>概率型彩票：</th>
	                                        <td><input type="text" name="prop_probabilitySales" id="prop_probabilitySales" value="${w4:showNumber(document, 'probabilitySales')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>万元</td>
                                        </tr>
                                        <tr>
	                                        <th>即开型彩票：</th>
											<td><input type="text" name="prop_instantSales" id="prop_instantSales" value="${w4:showNumber(document, 'instantSales')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>万元</td>
                                        </tr>
                                        <tr>
	                                        <th>其他彩票：</th>
	                                        <td><input type="text" name="prop_otherSales" id="prop_otherSales" value="${w4:showNumber(document, 'otherSales')}"  data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>万元</td>
                                        </tr>
                                        <tr>
                                            <th colspan="3">各区体育彩票销售额占比</th>
                                        </tr>
                                        <tr>
                                            <th>区</th>
                                            <th>销售额占比</th>
                                            <th>单位</th>
                                        </tr>
                                    </thead>
                                    <tbody class="thL">
                                        <tr>
                                            <td>福田</td>
                                            <td><input type="text" name="prop_futianSalesRatio" id="prop_futianSalesRatio" value="${w4:showNumber(document, 'futianSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>盐田</td>
                                            <td><input type="text" name="prop_yantianSalesRatio" id="prop_yantianSalesRatio" value="${w4:showNumber(document, 'yantianSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>龙岗</td>
                                            <td><input type="text" name="prop_longgangSalesRatio" id="prop_longgangSalesRatio" value="${w4:showNumber(document, 'longgangSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>大鹏</td>
                                            <td><input type="text" name="prop_dapengSalesRatio" id="prop_dapengSalesRatio" value="${w4:showNumber(document, 'dapengSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>宝安</td>
                                            <td><input type="text" name="prop_baoanSalesRatio" id="prop_baoanSalesRatio" value="${w4:showNumber(document, 'baoanSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>罗湖</td>
                                            <td><input type="text" name="prop_luohuSalesRatio" id="prop_luohuSalesRatio" value="${w4:showNumber(document, 'luohuSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>南山</td>
                                            <td><input type="text" name="prop_nanshanSalesRatio" id="prop_nanshanSalesRatio" value="${w4:showNumber(document, 'nanshanSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>坪山</td>
                                            <td><input type="text" name="prop_pingshanSalesRatio" id="prop_pingshanSalesRatio" value="${w4:showNumber(document, 'pingshanSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>龙华</td>
                                            <td><input type="text" name="prop_longhuaSalesRatio" id="prop_longhuaSalesRatio" value="${w4:showNumber(document, 'longhuaSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td>光明</td>
                                            <td><input type="text" name="prop_guangmingSalesRatio" id="prop_guangmingSalesRatio" value="${w4:showNumber(document, 'guangmingSalesRatio')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                            <td>%</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:inherit;" colspan="3">
                                                <table>
                                                <tbody>
                                                    <tr>
				                                        <th>3、本年筹集体育彩票公益金总额：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'welfareAmount') }"/></th>
														<td><input type="text" name="prop_welfareAmount" id="prop_welfareAmount" value="${w4:showNumber(document, 'welfareAmount')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                                        <td>万元</td>
                                                    </tr>
                                                    <tr>
				                                        <th>体育彩票销售佣金收入：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'commissionProfit') }"/></th>
														<td><input type="text" name="prop_commissionProfit" id="prop_commissionProfit" value="${w4:showNumber(document, 'commissionProfit')}" data-validation-engine="validate[required,custom[number]]"/></td>
														<td>万元</td>
                                                    </tr>
                                                    <tr>
				                                        <th>4、年人均雇员报酬：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'averagePay') }"/></th>
														<td><input type="text" name="prop_averagePay" id="prop_averagePay" value="${w4:showNumber(document, 'averagePay')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                                        <td>万元/年</td>
                                                    </tr>
                                                    <tr>
				                                        <th>年均营业场所租赁租金：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'averageRent') }"/></th>
														<td><input type="text" name="prop_averageRent" id="prop_averageRent" value="${w4:showNumber(document, 'averageRent')}" data-validation-engine="validate[required,custom[number]]"/></td>
                                                        <td>万元/年</td>
                                                    </tr>
                                                </tbody>
                                                </table>
                                            </td>
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
