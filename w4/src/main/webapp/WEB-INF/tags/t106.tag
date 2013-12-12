<%@ tag pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>

<%@ attribute name="company" required="true" rtexprvalue="true" type="com.lianhua.company.model.Company" %>
<%@ attribute name="document" required="true" rtexprvalue="true" type="com.lianhua.document.model.Document" %>
						<script type="text/javascript">
							$(function() {
								checksumer = TableChecksum();
								checksumer.checksum([
									{id:"prop_operationRevenue",text:"场馆营业收入合计"}, 
									{id:"prop_actRevenue",text:"举办竞赛表演收入合计"},
									{id:"prop_trainingRevenue",text:"承接体育训练收入"}, 
									{id:"prop_adRevenue",text:"体育相关广告收入"},
									{id:"prop_notSportsRevenue",text:"其他非体育活动收入"}
									], {relation: "="}
								);
								checksumer.checksum([
									{id:"prop_notSportsRevenue",text:"其他非体育活动收入"}, 
									{id:"prop_rentRevenue",text:"商业出租收入"},
									{id:"prop_parkRevenue",text:"停车场收入"},
									{id:"prop_culturalRevenue",text:"各类其他文化活动收入（展会、演唱会等）"}
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
							<th>场馆类型：</th>
							<td>
								<w4tag:code kind="stadium_type" name="prop_stadiumTypeCode" value="${w4:showValue(document, 'stadiumTypeCode')}" type="checkbox" required="true"/>
								<input type="text" name="prop_otherStadiumType" id="prop_otherStadiumType" value="${w4:showValue(document, 'otherStadiumType')}" />
							</td>
						</tr>
		                <tr>
		                    <td style="padding:inherit;" colspan="2">
		                        <table>
		                            <tbody class="thL">
		                                <tr>
		                                    <th>建成时间（年、月）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'buildDate') }"/></th>
		                                    <td><input type="text" name="prop_buildDate" id="prop_buildDate" value="${w4:showValue(document, 'buildDate')}" data-validation-engine="validate[required,custom[date]]" /></td>
		                                </tr>
		                                <tr>
		                                    <th>建设成本（万元）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'buildCost') }"/></th>
		                                    <td><input type="text" name="prop_buildCost" id="prop_buildCost" value="${w4:showNumber(document, 'buildCost')}" data-validation-engine="validate[required,custom[number]]" /></td>
		                                </tr>
		                                <tr>
		                                    <th>经费来源1（单位名称）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'source1') }"/></th>
		                                    <td>
		                                        <table>
		                                            <tbody>
		                                                <tr>
		                                                    <td><input type="text" name="prop_source1" id="prop_source1" value="${w4:showValue(document, 'source1')}" /></td>
		                                                    <td>提供</td>
		                                                    <td><input type="text" name="prop_sourceMoney1" id="prop_sourceMoney1" value="${w4:showNumber(document, 'sourceMoney1')}" data-validation-engine="validate[custom[number]]"/></td>
		                                                    <td>万元</td>
		                                                </tr>
		                                            </tbody>
		                                        </table>
		                                    </td>
		                                </tr>
		                                <tr>
		                                    <th>经费来源2（单位名称）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'source1') }"/></th>
		                                    <td>
		                                        <table>
		                                            <tbody>
		                                                <tr>
		                                                    <td><input type="text" name="prop_source2" id="prop_source2" value="${w4:showValue(document, 'source2')}" /></td>
		                                                    <td>提供</td>
		                                                    <td><input type="text" name="prop_sourceMoney2" id="prop_sourceMoney2" value="${w4:showNumber(document, 'sourceMoney2')}" data-validation-engine="validate[custom[number]]"/></td>
		                                                    <td>万元</td>
		                                                </tr>
		                                            </tbody>
		                                        </table>
		                                    </td>
		                                </tr>
		                                <tr>
		                                    <th>经费来源3（单位名称）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'source1') }"/></th>
		                                    <td>
		                                        <table>
		                                            <tbody>
		                                                <tr>
		                                                    <td><input type="text" name="prop_source3" id="prop_source3" value="${w4:showValue(document, 'source3')}" /></td>
		                                                    <td>提供</td>
		                                                    <td><input type="text" name="prop_sourceMoney3" id="prop_sourceMoney3" value="${w4:showNumber(document, 'sourceMoney3')}" data-validation-engine="validate[custom[number]]"/></td>
		                                                    <td>万元</td>
		                                                </tr>
		                                            </tbody>
		                                        </table>
		                                    </td>
		                                </tr>
		                                <tr>
		                                    <th>设计使用年限：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'useLimitYear') }"/></th>
		                                    <td><input type="text" name="prop_useLimitYear" id="prop_useLimitYear" value="${w4:showValue(document, 'useLimitYear')}" data-validation-engine="validate[required,custom[integer]]"/>年</td>
		                                </tr>
		                            </tbody>
		                        </table>
		                    </td>
		                </tr>
		                <tr>
		                    <td style="padding:inherit;" colspan="2">
		                        <table>
		                            <thead>
		                                <tr><th colspan="2">${w4:showStatYear(document)}年：</th></tr>
		                            </thead>
		                            <tbody>
		                                <tr>
		                                    <th>场馆营运成本（万元）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'operationCost') }"/></th>
		                                    <td><input type="text" name="prop_operationCost" id="prop_operationCost" value="${w4:showNumber(document, 'operationCost')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>场馆营业收入合计（万元）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'operationRevenue') }"/></th>
		                                    <td><input type="text" name="prop_operationRevenue" id="prop_operationRevenue" value="${w4:showNumber(document, 'operationRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>&nbsp;&nbsp;&nbsp;&nbsp;其中举办竞赛表演收入合计（万元）：
		                                        <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'actRevenue') }"/>
		                                    </th>
		                                    <td><input type="text" name="prop_actRevenue" id="prop_actRevenue" value="${w4:showNumber(document, 'actRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;承接体育训练收入（万元）：
		                                        <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'trainingRevenue') }"/>
		                                    </th>
		                                    <td><input type="text" name="prop_trainingRevenue" id="prop_trainingRevenue" value="${w4:showNumber(document, 'trainingRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;体育相关广告收入（万元）：
		                                        <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'adRevenue') }"/>
		                                    </th>
		                                    <td><input type="text" name="prop_adRevenue" id="prop_adRevenue" value="${w4:showNumber(document, 'adRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;其他非体育活动收入（万元）：
		                                        <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'notSportsRevenue') }"/>
		                                    </th>
		                                    <td><input type="text" name="prop_notSportsRevenue" id="prop_notSportsRevenue" value="${w4:showNumber(document, 'notSportsRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;其中：商业出租收入（万元）：
		                                        <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'rentRevenue') }"/>
		                                    </th>
		                                    <td><input type="text" name="prop_rentRevenue" id="prop_rentRevenue" value="${w4:showNumber(document, 'rentRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;停车场收入（万元）：
		                                        <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'parkRevenue') }"/>
		                                    </th>
		                                    <td><input type="text" name="prop_parkRevenue" id="prop_parkRevenue" value="${w4:showNumber(document, 'parkRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;各类其他文化活动收入（展会、演唱会等）（万元）：
		                                        <img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'culturalRevenue') }"/>
		                                    </th>
		                                    <td><input type="text" name="prop_culturalRevenue" id="prop_culturalRevenue" value="${w4:showNumber(document, 'culturalRevenue')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
		                                </tr>
		                                <tr>
		                                    <th>场馆个数（个）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'buildingNum') }"/></th>
		                                    <td><input type="text" name="prop_buildingNum" id="prop_buildingNum" value="${w4:showNumber(document, 'buildingNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
		                                </tr>
		                                <tr>
		                                    <th>场馆面积（平方米）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'buildingArea') }"/></th>
		                                    <td><input type="text" name="prop_buildingArea" id="prop_buildingArea" value="${w4:showNumber(document, 'buildingArea')}" data-validation-engine="validate[required,custom[number]]"/></td>
		                                </tr>
		                                <tr>
		                                    <th>场馆活动进场人数（人）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'attendanceNum') }"/></th>
		                                    <td><input type="text" name="prop_attendanceNum" id="prop_attendanceNum" value="${w4:showNumber(document, 'attendanceNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
		                                </tr>
		                                <tr>
		                                    <th>举办活动次数（次）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'activityNum') }"/></th>
		                                    <td><input type="text" name="prop_activityNum" id="prop_activityNum" value="${w4:showNumber(document, 'activityNum')}" data-validation-engine="validate[required,custom[number]]"/></td>
		                                </tr>
		                                <tr>
		                                    <th>承接体育比赛天数：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'matchDays') }"/></th>
		                                    <td><input type="text" name="prop_matchDays" id="prop_matchDays" value="${w4:showNumber(document, 'matchDays')}" data-validation-engine="validate[required,custom[number]]"/></td>
		                                </tr>
		                                <tr>
		                                    <th>平均从业人员（人）：<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'employeeNum') }"/></th>
		                                    <td><input type="text" name="prop_employeeNum" id="prop_employeeNum" value="${company.employeeNum}" disabled="disabled"/></td>
		                                </tr>
		                                <tr>
		                                    <th>其中：</th>
		                                    <td>
		                                        <table class="lineTable">
		                                            <tbody>
		                                                <tr>
		                                                    <th>研究生</th>
		                                                    <td><input type="text" style="width:100px;" name="prop_graduateNum" id="prop_graduateNum" value="${company.masterNum}" disabled="disabled"/></td>
		                                                    <td>人</td>
		                                                    <th>本科学历 </th>
		                                                    <td><input type="text" style="width:100px;" name="prop_bachelorNum" id="prop_bachelorNum" value="${company.bachelorNum}" disabled="disabled"/></td>
		                                                    <td>人</td>
		                                                    <th>专科学历 </th>
		                                                    <td><input type="text" style="width:100px;" name="prop_collegeNum" id="prop_collegeNum" value="${company.collegeNum}" disabled="disabled"/></td>
		                                                    <td>人</td>
		                                                    <th>其他 </th>
		                                                    <td><input type="text" style="width:100px;" name="prop_otherNum" id="prop_otherNum" value="${company.otherNum}" disabled="disabled"/></td>
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
	                           </tbody>
	                       </table>
	                   </td>
	               </tr>