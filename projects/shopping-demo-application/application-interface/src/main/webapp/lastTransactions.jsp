<%  String lastTransactions = (String) request.getAttribute("lastTransactions");
	if (lastTransactions != null && !lastTransactions.isEmpty()) {
%>
<div class="result">
	<table class="resultsDisplay" id="lastTransactions">
	</table>
</div>


<script>
	$(document).ready(function() {
		buildHtmlTable("#lastTransactions",<%=lastTransactions%>);
	});
</script>
<%
	}
%>