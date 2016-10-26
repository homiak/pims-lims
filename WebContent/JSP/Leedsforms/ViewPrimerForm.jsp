<%-- 
Page to display primer form 
@author Petr Troshin 
April 2007
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="/WEB-INF/pims.tld" prefix="pims" %>
<%@page import="org.pimslims.presentation.leeds.PrimerForm"%>
<jsp:useBean id="primerform" type="org.pimslims.presentation.leeds.PrimerForm" scope="request" />
<%  %>
<jsp:include page="/JSP/core/Header.jsp">
    <jsp:param name="HeaderName" value='View primer form' />
    <jsp:param name="usePrimerManagementCSS" value='true' />
</jsp:include>



<c:catch var="error">

<!-- Common links -->
<a href="${pageContext.request.contextPath}/NewConstruct?fprimer=${primerform.forwardPrimer.name}&amp;rprimer=${primerform.reversePrimer.name}">New entry clone for these primers</a>
 /
<a href="${pageContext.request.contextPath}/ListPrimerForms">List all primer pairs</a> /
<a href="${pageContext.request.contextPath}/NewPrimerForm">Create new primer form</a>


<!-- Forward primer -->
<c:choose><c:when test="${null==primerform.forwardPrimer}">
    No forward primer specified<br />
</c:when><c:otherwise>
<c:set var="primer" scope="request" value="${primerform.forwardPrimer}" />
<jsp:include page="/JSP/Leedsforms/ViewPrimer.jsp">
    <jsp:param name="Title" value='Forward primer' />
</jsp:include>
</c:otherwise></c:choose>

<!-- Reverse primer -->
<c:choose><c:when test="${null==primerform.reversePrimer}">
    No reverse primer specified<br />
</c:when><c:otherwise>
<c:set var="primer" scope="request" value="${primerform.reversePrimer}" />
<jsp:include page="/JSP/Leedsforms/ViewPrimer.jsp" >
    <jsp:param name="Title" value='Reverse primer' />
</jsp:include>
</c:otherwise></c:choose>

<!-- Primers details -->
<jsp:include page="/JSP/Leedsforms/ViewPrimersDetails.jsp" >
    <jsp:param name="Title" value='Details' />
</jsp:include>
<br/>

<div class="primer" style="border: 0; text-align: right;">
<form action="${pageContext.request.contextPath}/EditPrimerForm/${primerform.hook}" method="get" >
    <c:choose>
                <c:when test="${primerform.experiment._MayUpdate}">
                            <input type="submit" style="text-align: right;" name="Edit" class="button" value="Edit"/>
                </c:when>
                <c:otherwise>
                        <div id="buttonEdit" style="position: relative; top: 0;">
                        <input class="button" type="submit" disabled="disabled" name="edit" value="Owner:${primerform.experiment._Owner}"/>
                        <div style="width: 8em; height:1.5em; background-color: transparent; position:absolute; top: 0; right: 0; z-index:2 ">&nbsp;</div>
                        </div>                                              
                </c:otherwise>
        </c:choose>
</form>     
</div>

</c:catch>
<c:if test="${error != null}">
    <p class="error">error ${error}</p> 
		<p class="error">error ${error.message}</p>
 	<p class="error">
 	<% Exception err = (Exception)pageContext.getAttribute("error"); 
 			err.printStackTrace();
 		%></p>
    </c:if>
    
<jsp:include page="/JSP/core/Footer.jsp" />
