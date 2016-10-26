<%--
Page to display primer
@author Petr Troshin
April 2007
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="/WEB-INF/pims.tld" prefix="pims" %>
<%--  Primer resource bundle --%>
<%@page import="org.pimslims.presentation.PrimerBean"%>
<jsp:useBean id="primer" type="org.pimslims.presentation.PrimerBean" scope="request" />

<h3>${param.Title} &nbsp;${primer.name}</h3>
<!-- First primer form-->
<div class="primer">
	<div class="formrow separate sequenceVal">
		<span class="label">Sequence&nbsp;</span> ${fn:toUpperCase(primer.sequence)}
	</div>
	<div class="columnLeft">
	<div class="separate formrow">
			<span class="label">Storage location</span>
			<pims:getter version="${primer.version}" hook="${primer.location}" attributes="name" />
	</div>
	
	<div class="separate formrow">
			<!-- <span class="label">Box Barcode</span>${primer.boxBarcode} -->
	</div>
	
	<div class="separate formrow">
			<span class="label">Box</span>
			<pims:getter version="${primer.version}" hook="${primer.box}" attributes="name" />
		</div>
		<div class="separate formrow">
			<span class="label">Length (bp)</span>${primer.length}
		</div>
		<div class="separate formrow">
			<span class="label">T<sub>m</sub><sup>seller</sup>(C&deg;)</span>${primer.tmSeller}
		</div>
		<div class="separate formrow">
			<span class="label">Concentration (mM)</span>${primer.concentration}
		</div>
		<div class="separate formrow">
			<span class="label">GC<sup>full</sup>(%)</span>${primer.GCFull}
		</div>
		<div class="separate formrow">
			<span class="label">Molecular mass</span>${primer.molecularMass}
		</div>
		<div class="separate formrow">
			<span class="label">Amount (&micro;g)</span>${primer.amount}
		</div>
		<div class="separate formrow">
			<span class="label">Grade</span>${primer.particularity}
		</div>

	</div> <!-- leftColumn -->

	<div class="columnRight">
		<div class="separate formrow">
			<span class="label">Seller</span>
			<pims:getter version="${primer.version}" hook="${primer.seller}" attributes="name" />
		</div>
			<div class="separate formrow">
		 <span class="label">Position Barcode</span>${primer.positionBarcode}
		</div>
		<div class="separate formrow">
		 <span class="label">Position</span>${primer.position}
		</div>
		<div class="separate formrow">
		<span class="label">Length on gene (bp)</span>${primer.lengthOnGeneString}
		</div>
		<div class="separate formrow">
		  <span class="label">T<sub>m</sub><sup>full</sup>(C&deg;)</span>${primer.tmFull}
		 </div>
		 <div class="separate formrow">
		  <span class="label">T<sub>m</sub><sup>gene</sup>(C&deg;)</span>${primer.tmGene}
	    </div>
		<div class="separate formrow">
			<span class="label">GC<sup>gene</sup>(%)</span>${primer.GCGene}
		</div>
		<div class="separate formrow">
			<span class="label">OD</span>${primer.OD}
		</div>
		<div class="separate formrow">
			<span class="label">&micro;g/OD</span>${primer.amountperOD}
		</div>
		<div class="separate formrow">
			<span class="label">Restriction site</span>${primer.restrictionSite}
		</div> 

	</div>
	<!-- rightColumn -->
</div> <!-- first Primer div end -->

<c:if test="${singleView}">

	<div class="primer" style="border: 0pt none ; padding-top:0.5em;  text-align: right;">
 		<form action="${pageContext.request.contextPath}/update/EditPrimer/${primer.sample._Hook}" method="get">
			<c:choose>
				<c:when test="${primer.sample._MayUpdate}">
							<input class="button" type="submit" name="submit" value="Edit"/>
				</c:when>
				<c:otherwise>
						<div id="buttonEdit" style="position: relative; top: 0;">
						<input class="button" type="submit" disabled="disabled" name="edit" value="Owner:${primer.sample._Owner}"/>
						<div style="width: 8em; height:1.5em; background-color: transparent; position:absolute; top: 0; right: 0; z-index:2 ">&nbsp;</div>
						</div>	          									
				</c:otherwise>
		</c:choose>
 	  </form>
 	</div>

<c:if test="${! empty primer.order }">
		<a href="${pageContext.request.contextPath}/PrimerOrder/${primer.order}">View all primers within the same order</a>
	</c:if>
	<br/>
<c:choose>
	<c:when test="${! empty primer.cloningDesignExperiment._Hook}">
	<a href="${pageContext.request.contextPath}/FullPrimerForm/${primer.cloningDesignExperiment._Hook}">View Cloning design experiment</a>
	 <br/>
 </c:when>
 <c:otherwise>
 	There is no pair for this primer. <br/>
 </c:otherwise>
 </c:choose>
	<a href="${pageContext.request.contextPath}/ListFiles/${primer.primerDesignExperiment._Hook}">Manage Attached Files</a>
</c:if>

<!-- OLD -->
