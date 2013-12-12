<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://ckeditor.com" prefix="ckeditor" %>
<%@ taglib uri="/WEB-INF/tld/w4.tld" prefix="w4"%>
<%@ taglib uri="/WEB-INF/tld/w4tag.tld" prefix="w4tag"%>
<%@ taglib uri="/WEB-INF/tld/platform.tld" prefix="platform"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<c:if test="${ctxPath == '/' }"><c:set var="ctxPath" value="" /></c:if>
