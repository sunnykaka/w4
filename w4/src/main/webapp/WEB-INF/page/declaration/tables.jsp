<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/page/inc/taglibs.jsp"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="tb" %>
            <c:set var="desc" value="${document.descriptor }" />
            <dd>
		        <table class="table_input" width="100%">
		            <thead>
		                <tr>
		                    <th colspan="4"><c:out value="${desc.name }" /></th>
		                </tr>
		            </thead>
		            <tbody>
		            	<c:if test="${fn:indexOf(desc.code,'102') != -1}">
		            		<tr><td colspan="2">注：体育彩票销售网点不需填写102表 </td></tr>
		            	</c:if>
		                <tr>
		                    <td style="padding:inherit;" colspan="2">
		                        <table>
		                            <tbody>
		                                <tr>
		                                    <td  style="padding:inherit;" width="50%">
		                                       <table>
		                                           <tbody>
		                                               <tr>
		                                                   <th>组织机构代码：</th>
		                                                   <td><c:out value="${company.code }" /></td>
		                                               </tr>
		                                               <tr>
		                                                   <th>单位名称：</th>
		                                                   <td><c:out value="${company.name }" /></td>
		                                               </tr>
		                                               <c:if test="${fn:indexOf(desc.code,'107') != -1}">
			                                               <tr>
			                                                   <th>级别：</th>
			                                                   <td><w4tag:code kind="hotel_star" name="prop_hotelStarCode" value="${w4:showValue(document, 'hotelStarCode')}" type="radio" /></td>
			                                               </tr>		                                               
		                                               </c:if>
		                                               <tr>
		                                                   <th></th>
		                                                   <td style="text-align:right;font-size:18px;"><b>${w4:showStatYear(document)}年</b></td>
		                                               </tr>
		                                           </tbody>
		                                       </table>
		                                    </td>
		                                    <td style="padding:inherit;">
		                                       <table>
		                                           <tbody>
		                                               <tr>
		                                                   <th>表    号：</th>
		                                                   <td><c:out value="${desc.code }" /></td>
		                                               </tr>
		                                               <tr>
		                                                   <th>制定机关：</th>
		                                                   <td><c:out value="${desc.drafter }" /></td>
		                                               </tr>
		                                               <tr>
		                                                   <th>批准机关：</th>
		                                                   <td><c:out value="${desc.approver }" /></td>
		                                               </tr>
		                                               <tr>
		                                                   <th>批准文号：</th>
		                                                   <td><c:out value="${desc.approvalNumber }" /></td>
		                                               </tr>
		                                               <c:if test="${not empty desc.surveyCategory }">
			                                               <tr>
			                                                   <th>调查类别：</th>
			                                                   <td><c:out value="${desc.surveyCategory }" /></td>
			                                               </tr>		                                               
		                                               </c:if>
		                                               <tr>
		                                                   <th>有效期至： 	</th>
		                                                   <td><c:out value="${desc.validDate }" /></td>
		                                               </tr>
		                                           </tbody>
		                                       </table>
		                                    </td>
		                                </tr>
		                            </tbody>
		                        </table>
		                    </td>
		                </tr>
			         	<c:choose>
			         		<c:when test="${fn:indexOf(desc.code,'102') != -1}">
								<tb:t102 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'103') != -1}">
								<tb:t103 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'104') != -1}">
								<tb:t104 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'105') != -1}">
								<tb:t105 document="${document }" company="${company }" />
							</c:when>
			         		<c:when test="${fn:indexOf(desc.code,'106') != -1}">
								<tb:t106 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'107') != -1}">
								<tb:t107 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'108') != -1}">
								<tb:t108 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'109') != -1}">
								<tb:t109 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'110') != -1}">
								<tb:t110 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'111') != -1}">
								<tb:t111 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'112') != -1}">
								<tb:t112 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'113') != -1}">
								<tb:t113 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'114') != -1}">
								<tb:t114 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'115') != -1}">
								<tb:t115 document="${document }" company="${company }" />
							</c:when>
							<c:when test="${fn:indexOf(desc.code,'116') != -1}">
								<tb:t116 document="${document }" company="${company }" />
							</c:when>
						</c:choose>
				</tbody>
			</table>
            </dd>
</body>
</html>

