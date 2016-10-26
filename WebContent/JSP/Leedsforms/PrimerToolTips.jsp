<%-- @Author Petr Troshin aka pvt43 --%>
<script type="text/javascript">
Element.observe(window,"load",function(){
  addTooltip("${rb.position}","Position in the box","Valid positions are in range A-H, 1-24");
  addTooltip("${rb.molecularMass}","Molecular weight","Molecular weight of a primer");
  addTooltip("${rb.name}","Primer name","Must be unique");
  addTooltip("${rb.concentration}","Concentration","Concentration must be recorded in mM. Unit conversion is not supported");
  addTooltip("${rb.positionBarcode}","Barcode for position below","This is a barcode for a tube or position in the plate");
  addTooltip("${rb.amount}","Amount of a primer","Amount must be recorded in ng. Unit conversion is not supported");
  addTooltip("${rb.particularity}","Grade of primer purity","Common values - desalted, HPLC purified");
  addTooltip("${rb.OD}","Optical density","Optical density measured at 260 nm");
  addTooltip("odrelation","Amount per optical density","Calculated field, cannot be set");
  addTooltip("${rb.boxBarcode}","Barcode for the box","Please use box field to record barcode. You can use either box name or its barcode. ");
	addTooltip("${rb.boxBarcode}Label","Barcode for the box","Please use box field to record barcode. You can use either box name or its barcode. ");
});
</script>

<!-- OLD -->
