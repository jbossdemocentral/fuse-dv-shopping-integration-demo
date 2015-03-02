
<%
	String buyResult = (String) request.getAttribute("buyResult");
	if (buyResult != null) {
%>
<div class="result">
	<%=buyResult%>
</div>
<%
	}
	String showResult = (String) request.getAttribute("showProducts");
	if (showResult != null && !showResult.isEmpty()) {
%>
<div class="result">
	<table class="resultsDisplay" id="showProducts">
	</table>
</div>


<script>
	$(document).ready(function() {
		buildHtmlTable("#showProducts",<%=showResult%>);
	});
</script>
<%
	}
%>