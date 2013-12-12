<%@ tag pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>

<%@ attribute name="company" required="true" rtexprvalue="true" type="com.lianhua.company.model.Company" %>
<%@ attribute name="document" required="true" rtexprvalue="true" type="com.lianhua.document.model.Document" %>
						<script type="text/javascript">
							$(function() {
								/*
								checksumer = TableChecksum();
								checksumer.checksum([
									{id:"prop_constructionCost",text:"投入绿道建设经费"}, 
									{id:"prop_financialFunds",text:"来源于财政经费"},
									{id:"prop_selfRaisedFunds",text:"来源于自筹经费"}
									]
								);
								*/
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
		                                <th >区号</th>
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
                            <td>职业体育俱乐部填写<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'club') }"/></td>
                            <td style="padding-left:inherit;" colspan="2">
                                <table>
                                    <tbody class="thL">
                                        <tr>
                                            <th style="width:30%;">本年广告赞助费收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'clubAdRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_clubAdRevenue" id="prop_clubAdRevenue" value="${w4:showNumber(document, 'clubAdRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>本年门票收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'clubTicketRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_clubTicketRevenue" id="prop_clubTicketRevenue" value="${w4:showNumber(document, 'clubTicketRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>本年运动员转会费收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'athleteTransferRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_athleteTransferRevenue" id="prop_athleteTransferRevenue" value="${w4:showNumber(document, 'athleteTransferRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>本年转播权收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'broadcastRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_broadcastRevenue" id="prop_broadcastRevenue" value="${w4:showNumber(document, 'broadcastRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>本年拥趸（Fans）用品经营收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'fansRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_fansRevenue" id="prop_fansRevenue" value="${w4:showNumber(document, 'fansRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>本年运动员参加体育比赛人次：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'clubAthleteAttendNum') }"/>
                                            </th>
                                            <td><input type="text" name="prop_clubAthleteAttendNum" id="prop_clubAthleteAttendNum" value="${w4:showNumber(document, 'clubAthleteAttendNum')}" data-validation-engine="validate[custom[number]]"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
						<tr>
                            <td>优秀运动队管理单位填写<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'superviser') }"/></td>
                            <td style="padding-left:inherit;" colspan="2">
                                <table>
                                    <tbody class="thL">
                                        <tr>
                                            <th style="width:30%;">本年广告赞助费收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'superviserAdRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_superviserAdRevenue" id="prop_superviserAdRevenue" value="${w4:showNumber(document, 'superviserAdRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>本年运动员参加体育比赛人次：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'superviserAthleteAttendNum') }"/>
                                            </th>
                                            <td><input type="text" name="prop_superviserAthleteAttendNum" id="prop_superviserAthleteAttendNum" value="${w4:showNumber(document, 'superviserAthleteAttendNum')}" data-validation-engine="validate[custom[number]]"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
						<tr>
                            <td>体育健身休闲业填写</td>
                            <td style="padding-left:inherit;" colspan="2">
                                <table>
                                    <tbody class="thL">
                                        <tr>
                                            <th style="width:30%;">类别：</th>
                                            <td>
                                            	<w4tag:code kind="fitness_type" name="prop_fitnessTypeCode" value="${w4:showValue(document, 'fitnessTypeCode')}" type="checkbox" />
                                            	<input type="text" name="prop_otherFitnessType" id="prop_otherFitnessType" value="${w4:showValue(document, 'otherFitnessType')}" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>会员年平均人数(人)：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'averageVips') }"/>
                                            </th>
                                            <td><input type="text" name="prop_averageVips" id="prop_averageVips" value="${w4:showNumber(document, 'averageVips')}" data-validation-engine="validate[custom[number]]"/></td>
                                        </tr>
                                        <tr>
                                            <th>全年活动人次（万人次）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'activityPeopleNum') }"/>
                                            </th>
                                            <td><input type="text" name="prop_activityPeopleNum" id="prop_activityPeopleNum" value="${w4:showNumber(document, 'activityPeopleNum')}" data-validation-engine="validate[custom[number]]"/></td>
                                        </tr>
                                        <tr>
                                            <th>会费收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'vipRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_vipRevenue" id="prop_vipRevenue" value="${w4:showNumber(document, 'vipRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>各类消费卡收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'expenseCardRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_expenseCardRevenue" id="prop_expenseCardRevenue" value="${w4:showNumber(document, 'expenseCardRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>培训类收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'trainingRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_trainingRevenue" id="prop_trainingRevenue" value="${w4:showNumber(document, 'trainingRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>场馆提供收入（万元）：
                                            <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'yardRevenue') }"/>
                                            </th>
                                            <td><input type="text" name="prop_yardRevenue" id="prop_yardRevenue" value="${w4:showNumber(document, 'yardRevenue')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </td>
                        </tr>
						<tr>
                            <td>体育绿道调查表（各地、市体育局填写）</td>
                            <td style="padding-left:inherit;" colspan="2">
                                <table>
                                    <thead>
                                        <tr>
                                            <th style="width:12%">统计时间范围</th>
                                            <th style="width:12%">指标名称</th>
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
                                            <th>投入绿道建设经费<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'constructionCost') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_constructionCost" id="prop_constructionCost" value="${w4:showNumber(document, 'constructionCost')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
										<tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp;其中：来源于财政经费<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'financialFunds') }" /></th>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_financialFunds" id="prop_financialFunds" value="${w4:showNumber(document, 'financialFunds')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 来源于自筹经费<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'selfRaisedFunds') }" /></th>
											<td>万元</td>
                                            <td><input type="text" name="prop_selfRaisedFunds" id="prop_selfRaisedFunds" value="${w4:showNumber(document, 'selfRaisedFunds')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
                                        </tr>
										<tr>
                                            <th>建成的绿道公里数<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'greewayKm') }" /></th>
											<td>公里</td>
                                            <td><input type="text" name="prop_greewayKm" id="prop_greewayKm" value="${w4:showNumber(document, 'greewayKm')}" data-validation-engine="validate[custom[number]]"/></td>
                                        </tr>
										<tr>
                                            <th>绿道维护费用<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'maintenance') }" /></th>
											<td>万元</td>
                                            <td><input type="text" name="prop_maintenance" id="prop_maintenance" value="${w4:showNumber(document, 'maintenance')}" data-validation-engine="validate[custom[number]]" money="true"/></td>
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
