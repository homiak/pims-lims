<%-- @Author Petr Troshin aka pvt43 --%>
<jsp:useBean id="pr" type="java.util.Map" scope="request" />
<jsp:useBean id="type" type="java.lang.String" scope="request" />

attachValidation("${pr.name}", { required:true, alias:"${type} name"});
attachValidation("${pr.sequence}", { required:true, dnaSequence:true, alias:"${type} sequence"});
attachValidation("${pr.tmseller}", { minimum:40, maximum:100, alias:'${type} Tm seller'});
attachValidation("${pr.concentration}", { numeric:true, alias:'${type} concentration}'});

attachValidation("${pr.location}", { alias:'${type} location', mutuallyRequire:"${pr.position}", otherAlias:'${type} position'});
attachValidation("${pr.position}", { holderPosition:true, alias:'${type} position'});
attachValidation("${pr.tmfull}", { minimum:40, maximum:100, alias:'${type} Tm Full'});

attachValidation("${pr.lengthongene}", { wholeNumber:true, alias:'${type} length on gene'} );
attachValidation("${pr.tmgene}", { numeric:true, alias:'${type} Tm gene'});
attachValidation("${pr.molecularMass}", { numeric:true, alias:'${type} molecular mass'});
attachValidation("${pr.amount}", { numeric:true, alias:'${type} amount'});
