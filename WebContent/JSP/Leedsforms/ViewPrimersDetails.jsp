<%-- 
Page to display primers details 
@author Petr Troshin 
April 2007
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="/WEB-INF/pims.tld" prefix="pims" %>
<%@page import="org.pimslims.presentation.leeds.PrimerForm"%>
<jsp:useBean id="primerform" type="org.pimslims.presentation.leeds.PrimerForm" scope="request" />
obsolete
<h3 >${param.Title}</h3>
<!-- Common form properties-->
<div class="primerform">
	<div class="columnLeft">
		<div class="separate formrow">
			<span class="label">Target ORF cloned from</span>${primerform.from}
		</div>
		<div class="separate formrow">
			<span class="label" id="plasmidConcerned">Plasmid concerned</span>
		    <pims:isHookValid version="${primerform.version}" hook="${primerform.plasmid}">
			   	<c:set var="valid" value="valid"/>
			    <c:set var="plasmid">
								<pims:getter version="${primerform.version}" hook="${primerform.plasmid}" attributes="name" />
					</c:set>
					 ${plasmid}
         	<a href="${pageContext.request.contextPath}/Construct/${primerform.plasmid}" title="View Plasmid Concerned" >
				 	 View 
				 	 
					</a>
				</pims:isHookValid>
				<c:if test="${empty valid}"> 
					${primerform.plasmid}
				</c:if>
		</div>
		<div class="separate formrow">
			<span class="label">Designed by</span>
			<c:if test="${null ne primerform.designedBy}">
			<pims:getter version="${primerform.version}" hook="${primerform.designedBy}" attributes="name" delimiter=" " />
			</c:if>
		</div>
	</div> <!-- leftColumn -->
	<div class="columnRight">
		<div class="separate formrow">
			<span class="label">Target ORF cloned to</span>${primerform.to}
	    </div>
		<div class="separate formrow">
			<span class="label">PCR product length (bp)</span>${primerform.PCRProductLength}
		</div>
		
		<div class="separate formrow">
			<span class="label">Designing date</span>${primerform.date}
	    </div>
	</div> <!-- rightColumn -->
	<div class="comments formrow">
	   <span class="label">Comments</span>${primerform.comments}&nbsp;
	</div> 
</div><!-- Primer form details end-->
<script type="text/javascript">
Element.observe(window,"load",function(){
  addTooltip("plasmidConcerned","Entry Clone or Expression construct","Entry clone or expresison construct for which these primers were used");
  addTooltip("buttonEdit","Owner","You do not have permission to edit this record.");
});
</script>

<!-- OLD -->
