<%-- @Author Petr Troshin aka pvt43 --%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/javascript">
Element.observe(window,"load",function(){
  addTooltip("${f.position1}","Position in the box","Valid positions are in range A-H, 1-24");
  addTooltip("${f.position2}","Position in the box","Valid positions are in range A-H, 1-24");
  addTooltip("${f.name}","Construct name","Must be unique");
  addTooltip("${f.box1}","Box name or barcode","Must be unique");
  addTooltip("${f.position1Barcode}","Barcode for position above","This is a barcode for a tube or position in the plate");
	addTooltip("edit","Owner","You do not have permission to edit this record.");
	<%-- If this is for deepfrozen culture page, ignore --%>
	<c:if test="${empty param.dp}">
  	addTooltip("${f.cloneSaverPosition}","Position on the card","Valid positions are in range A-H, 1-24");
  	addTooltip("card","Card","Clone saver card, not changeable");
		<c:choose>
			<c:when test="${! empty param.edit}">
	  	addTooltip("box_barcode","Barcode for a box above","Please note that the barcode is displayed for a current box. You cannot edit it");
  		addTooltip("${f.fprimer}","Forward Primer","If you'd like the system to link the this construct with the recorded primer, please provide the exact primer name.");
	  	addTooltip("${f.rprimer}","Reverse Primer","If you'd like the system to link the this construct with the recorded primer, please provide the exact primer name.");
  	</c:when>
  	<c:otherwise>
		  addTooltip("${f.box1Barcode}","Barcode for the box above","This is no longer supported, please use either the box name or the box barcode in the Box No field.");
  		addTooltip("${f.fprimer}","Forward Primer","If the view icon to the right is not active, that means that the primer with this name is not found in the system.");
	  	addTooltip("${f.rprimer}","Reverse Primer","If the view icon to the right is not active, that means that the primer with this name is not recorded in the system.");
  	</c:otherwise>
  	</c:choose>
  </c:if>
});
</script>

<!-- OLD -->
