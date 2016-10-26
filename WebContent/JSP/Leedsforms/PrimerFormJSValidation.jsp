<%-- @Author Petr Troshin aka pvt43 --%>
<jsp:useBean id="prf" type="java.util.Map" scope="request" />

attachValidation("${prf.from}", { required:true, wholeNumber:true, alias:'Gene cloned ${prf.from}' });
attachValidation("${prf.to}",   { required:true, wholeNumber:true, alias:'Gene cloned ${prf.to}'   });
attachValidation("${prf.date}",          { date:true, alias:'${prf.date}' });
attachValidation("${prf.designedBy}",    { required:true, alias:'${prf.designedBy}' });
attachValidation("${prf.pcrprodlength}", { wholeNumber:true, alias:'${type} PCR product length' });