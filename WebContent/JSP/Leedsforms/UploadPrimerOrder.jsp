<%--
A page for upload the primer order zip file which contains a xls file which is the main form and 
some related files.
TODO: choose protocol
Author: Bill Lin
Date: March 2007
--%>
<!-- UploadPrimerOrder.jsp  -->
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:catch var="error">




<jsp:include page="/JSP/core/Header.jsp">
	<jsp:param name="HeaderName" value="Primer Order Management" />
</jsp:include>

<!-- OLD -->

<jsp:useBean id="holdersOfOrder" scope="request" type="java.util.Map" /> 

<c:if test="${! empty holdersOfOrder }">
<table class="list">
	<%-- table head --%>
   	<tr>
		<th>Existing Orders</th>						
	</tr>
	<%-- table body --%>
    <c:forEach var="entry" items="${ holdersOfOrder }"> 
			<tr>
				<td><a href='${pageContext.request.contextPath}/PrimerOrder/<c:out value="${entry.key}"/>'>${entry.value}</a>
				</td>
			</tr>
	</c:forEach>
</table>
</c:if>
obsolete
obsolete
<h3>Add New Primer Order:</h3>
<form action="${pageContext.request.contextPath}/PrimerOrderFileUploader" 
			enctype="multipart/form-data"	
			method="post"
			style="background-color:#ccf; padding:0.25em;margin-top:0.5em"
			>

<span align="left" style="font-weight: bold;">1. Has this order been sent to supplier?</span>
<br/>
<input type="radio" name="hasBeenSent" value="true"  /> Yes
<input type="radio" name="hasBeenSent" value="false" checked="checked" /> No
<br/>
<br />						      
<span align="left" style="font-weight: bold;">2. Please navigate to the ZIP file which contains: your primer order form in XLS format and target related files.</span>
<br/>
<span align="left" style="font-weight: bold;">Then click 'Upload file' button.</span>
<br />
<input style="float:right; width:auto;"	type="submit" 
			 name="submit" value="Upload file" 
			 onClick="if (''==document.getElementById('primerOrderXlsFile').value) {alert('Please choose a file to upload'); return false;} return true"/> 
	Choose a file 
	<input type="file" name="primerOrderfile" id="primerOrderXlsFile"/>
</form>



<br />






</c:catch><c:if test="${error != null}">"/>
    <p class="error">error ${error}</p>
</c:if>
<c:if test="${error == null}">
<jsp:include page="/JSP/core/Footer.jsp" />
</c:if>
