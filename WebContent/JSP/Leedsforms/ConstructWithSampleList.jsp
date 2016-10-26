<%-- @Author Petr Troshin aka pvt43 --%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="/WEB-INF/pims.tld" prefix="pims" %>

<c:if test="${!empty param.style}"> 
	<c:set var="style" value="style='${param.style}'"/>
</c:if>
<c:if test="${!empty param.class}">
	<c:set var="class" value="class='${param.class}'"/>
</c:if>

<select name='${param.name}' '${style}' "${class}" id='${param.name}'>
			<c:if test="${!empty entryCloneList}">					
			<optgroup label="Entry Clones">
					<c:forEach items="${entryCloneList}" var="clone">
						<c:if test="${currentValue == clone.linkingSample._Hook}">
							<c:set var="selected" value="selected='selected'"/>
							<c:set var="valueFound" value="true"/>
						</c:if>
						<option value="${clone.linkingSample._Hook}" ${selected}>${clone.name}</option>
						<c:remove var="selected" />
					</c:forEach>
				</optgroup>
				</c:if>
				<c:if test="${!empty deepFrozenList}">
					<optgroup label="Deep Frozen Cultures">
					<c:forEach items="${deepFrozenList}" var="clone">
						<c:if test="${currentValue == clone.linkingSample._Hook}">
							<c:set var="selected" value="selected='selected'"/>
							<c:set var="valueFound" value="true"/>
						</c:if>
						<option value="${clone.linkingSample._Hook}" ${selected}>${clone.name}</option>
						<c:remove var="selected" />
					</c:forEach>
				</optgroup>
			 </c:if>
				<c:if test="${!empty expressionList}">
					<optgroup label="Expression constructs">
					<c:forEach items="${expressionList}" var="express">
						<c:if test="${currentValue == express.linkingSample._Hook}">
							<c:set var="selected" value="selected='selected'"/>
							<c:set var="valueFound" value="true"/>
						</c:if>
						<option value="${express.linkingSample._Hook}" ${selected}>${express.name}</option>
						<c:remove var="selected" />
					</c:forEach>
				</optgroup>
				</c:if>
	  		<c:if test="${empty valueFound}">
						<option value="" selected='selected'></option>
				</c:if>				
	</select>

<!-- OLD -->
