<%-- 
Page to display primer
@author Petr Troshin 
April 2007
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="/WEB-INF/pims.tld" prefix="pims" %>
<%@page import="org.pimslims.presentation.leeds.AbstractSavedPlasmid,org.pimslims.leeds.FormFieldsNames,org.pimslims.metamodel.ModelObject"%>
<%--  Primer resource bundle --%>
<jsp:useBean id="rb" type="java.util.Map" scope="request" />
<jsp:useBean id="primer" class="org.pimslims.presentation.PrimerBean" scope="request" />

<h3>${param.Title}&nbsp;</h3>
<div class="primer" style="background-color: #ccf; border-width: 1px 1px 0px 1px;">
	<div class="columnLeft">
		<div class="separate formrow">
		<span class="label">Name&nbsp;<span class="required">*</span></span><input name="${rb.name}" id="${rb.name}" class="box" value="${primer.name}" type="text"/>
		</div>
	</div>
		<div class="columnRight">
			<div class="separate formrow">
		</div>
	</div>
</div>

<!-- First primer form-->
<div class="primer" style="border-width: 0px 1px 1px 1px;">
		<%-- 
		<div class="formrow separate" style="text-align: left;">
			<span class="label">Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<input name="${rb.name}" class="box" value="${primer.name}" type="text"/>
		</div> --%>
	<div class="formrow separate sequenceVal">
		<span class="label">Sequence&nbsp;<span class="required">*</span></span><input name="${rb.sequence}" id="${rb.sequence}" class="sequence" value="${primer.sequence}" type="text"/>
	</div>
	<div class="columnLeft">
	<%--
		<div class="separate formrow">
			<span class="label">Name</span>	
			<input name="${rb.name}" class="box" value="${primer.name}" type="text"/>
	</div>
	--%>
	<div class="separate formrow">
			<span class="label">Storage location</span>	
			<input name="${rb.location}" id="${rb.location}" class="box" value="${primer.location}" type="text"/>
	</div>
		<div id="${rb.boxBarcode}Label" class="separate formrow">
			<!-- 
			<span class="label">Box Barcode</span>
			<input maxlength="24" name="${rb.boxBarcode}" readonly="readonly" disabled="disabled" id="${rb.boxBarcode}" class="box" value="${primer.boxBarcode}" type="text"/>
			-->
		</div>
		<div class="separate formrow">
			<span class="label">Box </span>
			<input name="${rb.box}" class="box" value="${primer.box}" type="text"/>
		</div>
		<div class="formrow separate">
			<span class="label">Length (bp)</span> <input maxlength="5" readonly="readonly" disabled="disabled" name="${rb.length}" id="${rb.length}" class="digit" value="${primer.length}" type="text"/>
		</div>
		<div class="separate formrow">
			<span class="label">T<sub>m</sub><sup>seller</sup>(C&deg;)</span><input maxlength="5" name="${rb.tmseller}" id="${rb.tmseller}" class="digit" value="${primer.tmseller}" type="text"/> 
		</div>
		<div class="separate formrow">
			<span class="label">Concentration (mM)</span><input maxlength="5" name="${rb.concentration}" id="${rb.concentration}" class="digit" value="${primer.concentration}" type="text"/>
		</div>
		<div class="separate formrow">
			<span class="label">GC<sup>full</sup>(%)</span><input maxlength="5" readonly="readonly" disabled="disabled" name="${rb.gcfull}" id="${rb.gcfull}" class="digit" value="${primer.gcFull}" type="text"/>
		</div>
		<div class="separate formrow">
			<span class="label">Molecular mass</span><input maxlength="8" name="${rb.molecularMass}" id="${rb.molecularMass}" class="digit" value="${primer.molecularMass}" type="text"/>
		</div>
		<div class="separate formrow">
			<span class="label">Amount (ug)</span><input maxlength="5" name="${rb.amount}" id="${rb.amount}" class="digit" value="${primer.amount}" type="text"/>
		</div>
		<div class="separate formrow">
			<span class="label">Grade</span>
			<input maxlength="20" name="${rb.particularity}" id="${rb.particularity}" class="box" value="${primer.particularity}" type="text"/>
		</div>
		
	</div> <!-- leftColumn -->
	
	<div class="columnRight">
		<%--
		<div class="separate formrow">
			<span class="label"></span> 
		</div>
		--%>
		<div class="separate formrow">
			<span class="label">Seller</span> 
			<input name="${rb.seller}" class="box" value="${primer.seller}" type="text"/>
		</div>
		<div class="separate formrow">
		 <span class="label">Position Barcode</span> <input maxlength="16" name="${rb.positionBarcode}" id="${rb.positionBarcode}" class="box" value="${primer.positionBarcode}" type="text"/>
		</div>
		<div class="separate formrow">
		 <span class="label">Position</span> <input maxlength="3" name="${rb.position}" id="${rb.position}" class="digit" value="${primer.position}" type="text"/>
		</div>
		<div class="separate formrow">
		<span class="label">Length on the gene(bp)</span><input maxlength="5" name="${rb.lengthongene}" id="${rb.lengthongene}" class="digit" value="${primer.lengthOnGeneString}" type="text"/>
		</div>
		<div class="separate formrow">
		  <span class="label">T<sub>m</sub><sup>full</sup>(C&deg;)</span><input maxlength="5" name="${rb.tmfull}" id="${rb.tmfull}" class="digit" value="${primer.tmfull}" type="text"/>
		 </div>
		 <div class="separate formrow">
		  <span class="label">T<sub>m</sub><sup>gene</sup>(C&deg;)</span><input maxlength="5" name="${rb.tmgene}" id="${rb.tmgene}" class="digit" value="${primer.tmGene}" type="text"/>
	    </div>
		<div class="separate formrow">
		</div>
		<div class="separate formrow">
			<span class="label">OD</span><input maxlength="5" name="${rb.OD}" id="${rb.OD}"  class="digit" value="${primer.OD}" type="text"/>
		</div>
		<div class="separate formrow">
			<span class="label">ug/OD</span><input maxlength="5" id="odrelation" readonly="readonly" disabled="disabled" class="digit" value="${primer.amountperOD}" type="text"/>
		</div>
		<div class="separate formrow">
			<span class="label">Restriction site</span> <input maxlength="8" name="${rb.restrictionsite}"  class="box" value="${primer.restrictionsite}" type="text"/>
		</div>
	
	</div> 
	<!-- rightColumn -->
</div> <!-- first Primer div end -->
<!-- Primer tooltips -->
<jsp:include page="/JSP/Leedsforms/PrimerToolTips.jsp"/>

<!-- OLD -->
