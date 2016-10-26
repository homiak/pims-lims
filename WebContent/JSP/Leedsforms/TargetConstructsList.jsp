<%@ taglib prefix="pimsForm" tagdir="/WEB-INF/tags/pimsForm" %>
<%@ taglib prefix="pimsWidget" tagdir="/WEB-INF/tags/pimsWidget" %>
<%--
Browse Target with Constructs JSP
@param _List_ - the list of the specific model objects provided by ListEntryClones servlet 
@param pagerSize set by 20 in ListEntryClones servlet
@param rowNum - set by ListEntryClones to false when the page firstly
@param includeHeader - set by ListEntryClones to false when the page firstly
displayed the header and footer come from a servlet. But then includeHeader
set to true at the end of this jsp, and since next request come to this jsp
and header and footer must be generated from here.

@author Petr Troshin
@date December 2006
--%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/pims.tld" prefix="pims" %>
<fmt:setLocale value='en_UK' />
<%@ page buffer = "32kb" %>



<c:if test="${includeHeader}">
 <jsp:include page="/JSP/core/Header.jsp">
     <jsp:param name="HeaderName" value='List all Targets with Constructs' />
 </jsp:include>
<!-- TargetConstructsList.jsp -->
<!-- OLD -->
</c:if>

<!--
	Setting up so we can keep a record of the boxes written
	- later we'll use that to close them all
-->
<script type="text/javascript">
var path="";
var thingsToHide = new Array();
</script>


<form method="get" style="width: auto; background-color: white;" >
Set number of elements displayed on one page
<c:forTokens items="10 20 30 50 100 -1" delims=" " var="token" >
	<c:set var="checked" value=""/>

	<c:if test="${token == param.pagerSize}">
		<c:set var="checked" value="checked"/>
	</c:if>

	<c:choose>
	<c:when test="${token == '-1'}">
		<input type="radio" ${checked} value="-1" name="pagerSize" />unlimited	
	</c:when>
	<c:otherwise>
		<input type="radio" ${checked} value="${token}" name="pagerSize" />${token}
	</c:otherwise>
	</c:choose>
</c:forTokens>
<input style="width:auto;" type="submit"	name="Submit" value="Update view" />
</form>


<%-- Put a 'create' link --%>
<div style=" display: inline;">
<a class="noprint" href='${pageContext.request.contextPath}/NewConstruct'>Create a new Entry clone construct  </a>
</div>
<br />


  <display:table class="list" style="width:400px;" id="row" name="${requestScope._List_}" 
  							  defaultsort="1" pagesize="${param.pagerSize}">

  <display:column style="padding:2px 0 0 3px;width:200px;" sortable="true" headerClass="sortable" title="Target Common Name" >
     <a href="${pageContext.request.contextPath}/View/${row.targetHook}">${row.commonName}</a>
 </display:column>
 <display:column style="padding:2px 0 0 3px;width:200px;" sortable="true" headerClass="sortable" title="Construct Name" >
     <a href="${pageContext.request.contextPath}/Construct/${row.experimentHook}">${row.constructName}</a>
 </display:column>


 			
	<display:setProperty name="paging.banner.group_size" value="15" />
	<display:setProperty name="export.decorated" value="false" />
	
	<display:setProperty name="export.excel.include_header" value="true" />
	<display:setProperty name="export.csv.include_header" value="true" />
	<display:setProperty name="export.amount" value="page" /> <!-- set list if want to export all -->
	<display:setProperty name="paging.banner.item_name" value="Record" />
  <display:setProperty name="paging.banner.items_name" value="Records" />
  </display:table>
  

<c:if test="${includeHeader}">
	<jsp:include page="/JSP/core/Footer.jsp" />
</c:if>


	<!--
		This script block closes all the boxes to keep the page short on load
	-->
	<script type="text/javascript">
	if(window.toggleView && window.thingsToHide) {
		numThings=thingsToHide.length;
		for(i=0;i<numThings;i++) {
			toggleView(thingsToHide[i],path);
		}
	}
	</script>


<c:set var="includeHeader" value="${true}" scope="request" target="includeHeader"/>
<!-- /browseConstruct.JSP -->
