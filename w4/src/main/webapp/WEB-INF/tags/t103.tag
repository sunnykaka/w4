<%@ tag pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>

<%@ attribute name="company" required="true" rtexprvalue="true" type="com.lianhua.company.model.Company" %>
<%@ attribute name="document" required="true" rtexprvalue="true" type="com.lianhua.document.model.Document" %>
						<script type="text/javascript">
							$(function() {
								checksumer = TableChecksum();
								checksumer.checksum([
									{id:"prop_prop2",text:"固定资产原价"}, 
									{id:"prop_prop3",text:"本年折旧"}
									]
								);
								checksumer.checksum([
									{id:"prop_prop5",text:"收入合计"}, 
									{id:"prop_prop6",text:"财政拨款"},
									{id:"prop_prop7",text:"上级补助收入"}, 
									{id:"prop_prop8",text:"事业收入"},
									{id:"prop_prop9",text:"经营收入"}
									]
								);
								checksumer.checksum([
									{id:"prop_prop10",text:"支出合计"}, 
									{id:"prop_prop11",text:"经营支出"},
									{id:"prop_prop12",text:"人员支出"},
									{id:"prop_prop13",text:"公用支出"},
									{id:"prop_prop21",text:"对个人和家庭补助支出"}
									]
								);
								checksumer.checksum([
									{id:"prop_prop13",text:"公用支出"}, 
									{id:"prop_prop14",text:"福利费"},
									{id:"prop_prop15",text:"劳务费"},
									{id:"prop_prop16",text:"就业补助费"},
									{id:"prop_prop17",text:"水电费"}, 
									{id:"prop_prop18",text:"取暖费（燃气费）"},
									{id:"prop_prop19",text:"差旅费"},
									{id:"prop_prop20",text:"各种设备、交通工具及图书资料购置费"}
									]
								);
								checksumer.checksum([
									{id:"prop_prop21",text:"对个人和家庭补助支出"}, 
									{id:"prop_prop22",text:"助学金"},
									{id:"prop_prop23",text:"抚恤金和生活补助"}
									]
								);
							});
						</script>
						<tr>
                            <td style="padding:inherit;" colspan="2">
                                <table>
                                    <thead>
                                        <tr>
                                            <th style="width:30%">指标名称</th>
                                            <th style="width:8%">代码</th>
                                            <th style="width:8%">单位</th>
                                            <th>本年实际</th>
                                        </tr>
                                    </thead>
                                    <tbody class="thL">
                                        <tr>
                                            <td>甲</td>
                                            <td>乙</td>
                                            <td>丙</td>
                                            <td>1</td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp;1.资产总计<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop1') }"></th>
                                            <td>01</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop1" id="prop_prop1" value="${w4:showNumber(document, 'prop1')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp;2.固定资产原价<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop2') }"></th>
                                            <td>02</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop2" id="prop_prop2" value="${w4:showNumber(document, 'prop2')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	本年折旧（限体育彩票管理中心填写）<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop3') }"></th>
                                            <td>03</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop3" id="prop_prop3" value="${w4:showNumber(document, 'prop3')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp;
                                            	3.负债合计<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop4') }"></th>
                                            <td>04</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop4" id="prop_prop4" value="${w4:showNumber(document, 'prop4')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp;
                                            	4.收入合计<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop5') }"></th>
                                            <td>05</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop5" id="prop_prop5" value="${w4:showNumber(document, 'prop5')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
                                            	其中：财政拨款<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop6') }"></th>
                                            <td>06</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop6" id="prop_prop6" value="${w4:showNumber(document, 'prop6')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
                                            	上级补助收入<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop7') }"></th>
                                            <td>07</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop7" id="prop_prop7" value="${w4:showNumber(document, 'prop7')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	事业收入<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop8') }"></th>
                                            <td>08</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop8" id="prop_prop8" value="${w4:showNumber(document, 'prop8')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	经营收入<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop9') }"></th>
                                            <td>09</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop9" id="prop_prop9" value="${w4:showNumber(document, 'prop9')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; 
                                            	5.支出合计<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop10') }"></th>
                                            <td>10</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop10" id="prop_prop10" value="${w4:showNumber(document, 'prop10')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
                                            	其中：经营支出<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop11') }"></th>
                                            <td>11</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop11" id="prop_prop11" value="${w4:showNumber(document, 'prop11')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	人员支出<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop12') }"></th>
                                            <td>12</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop12" id="prop_prop12" value="${w4:showNumber(document, 'prop12')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	公用支出<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop13') }"></th>
                                            <td>13</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop13" id="prop_prop13" value="${w4:showNumber(document, 'prop13')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	其中：福利费<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop14') }"></th>
                                            <td>14</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop14" id="prop_prop14" value="${w4:showNumber(document, 'prop14')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	劳务费<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop15') }"></th>
                                            <td>15</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop15" id="prop_prop15" value="${w4:showNumber(document, 'prop15')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	就业补助费<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop16') }"></th>
                                            <td>16</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop16" id="prop_prop16" value="${w4:showNumber(document, 'prop16')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	水电费</th>
                                            <td>17</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop17" id="prop_prop17" value="${w4:showNumber(document, 'prop17')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
                                            	取暖费（燃气费）<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop18') }"></th>
                                            <td>18</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop18" id="prop_prop18" value="${w4:showNumber(document, 'prop18')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	差旅费<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop19') }"></th>
                                            <td>19</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop19" id="prop_prop19" value="${w4:showNumber(document, 'prop19')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
                                            	各种设备、交通工具及图书资料购置费<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop20') }"></th>
                                            <td>20</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop20" id="prop_prop20" value="${w4:showNumber(document, 'prop20')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; 
                                            	对个人和家庭补助支出<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop21') }"></th>
                                            <td>21</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop21" id="prop_prop21" value="${w4:showNumber(document, 'prop21')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	其中：助学金<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop22') }"></th>
                                            <td>22</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop22" id="prop_prop22" value="${w4:showNumber(document, 'prop22')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
                                        <tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
                                            	抚恤金和生活补贴<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop23') }"></th>
                                            <td>23</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop23" id="prop_prop23" value="${w4:showNumber(document, 'prop23')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
										<tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; 
                                            	6.收支结余<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop24') }"></th>
                                            <td>24</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop24" id="prop_prop24" value="${w4:showNumber(document, 'prop24')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
                                        </tr>
										<tr>
                                            <th>&nbsp;&nbsp;&nbsp;&nbsp; 
                                            	7.经营税金（限事业单位和体育彩票管理中心填写）<img class="info" width="12px" height="12px" src="${ctxPath }/ico/info.png" title="${w4:getTip(document, 'prop25') }"></th>
                                            <td>25</td>
                                            <td>万元</td>
                                            <td><input type="text" name="prop_prop25" id="prop_prop25" value="${w4:showNumber(document, 'prop25')}" data-validation-engine="validate[required,custom[number]]" money="true"/></td>
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
