<%-- @Author Petr Troshin aka pvt43 --%>
<%--
This page displays a list of Deep-Frozen culture stock
on the Entry  Clone and Expression constructs "Deep-Frozen culture"
tabs
--%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/pims.tld" prefix="pims" %>
<!-- ListDeepFrozenCultures.JSP -->
<c:catch var="error" >
<fmt:setLocale value='en_UK' />

<display:table class="list" id="row" name="${requestScope.construct.deepFrozenCultures}"
  							 defaultsort="1" pagesize="${param.pagerSize}">


 <display:column style="padding:2px 0 0 3px;width:20px;" media="html" title="" >
    <a href="${pageContext.request.contextPath}/Construct/${row.hook}">${row.name}</a>
 </display:column>

 <c:if test="${param.rowNum == 'on'}">
  	 <display:column style="padding:2px 0 0 3px;width:20px;" title="Row num" >${row_rowNum}</display:column>
 </c:if>

   		<display:column title="Designed By" escapeXml="true" >
			<pims:getter version="${row.version}" hook="${row.designedBy}" attributes="name" delimiter=" " />
   		</display:column>
   		<display:column title="Location" escapeXml="true" >
				<pims:getter version="${row.version}" hook="${row.location1}" attributes="name" />
   		</display:column>
   		<display:column  title="Box" escapeXml="true" >
				<pims:getter version="${row.version}" hook="${row.box1}" attributes="name" />
   		</display:column>
 			<display:column escapeXml="true"  property="position1" title="Position" />
			<display:column style="padding:2px 0 0 3px;width:20px;" title="VNTI&nbsp;map" >
			<c:set var="file" value="${row.VNTIMap}"/>
				<c:choose>
					<c:when test="${! empty file}">
		        <a href="${pageContext.request.contextPath}/ViewFile/${file.hook}/${file.name}" title="view file" >Map</a>
					</c:when>
						<c:otherwise></c:otherwise>
				</c:choose>
			</display:column>

	<display:setProperty name="paging.banner.group_size" value="15" />
	<display:setProperty name="export.decorated" value="false" />
	<display:setProperty name="sort.amount" value="list" /> <!-- set page if want to sort only first page before viewing -->
	<display:setProperty name="export.amount" value="page" /> <!-- set list if want to export all -->
	<display:setProperty name="paging.banner.item_name" value="Record" />
  <display:setProperty name="paging.banner.items_name" value="Records" />
  </display:table>

</c:catch><c:if test="${error != null}">"/>
    <p class="error">error ${error}<error /></p>
</c:if>

<!-- OLD -->
