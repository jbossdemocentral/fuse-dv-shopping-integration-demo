<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<% String contextName = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
var contextName = '<%= contextName%>';
</script>

<link rel="stylesheet" href="<%= contextName%>/css/styles.css" type="text/css"/>	
<script src='<%= contextName%>/js/jquery.min.js'></script>
<script src='<%= contextName%>/js/shopping.js'></script>
<title>Shopping Application</title>
</head>
<body>
	<%@ include file="displayUserDetails.jsp"%>
	<img src="<%= contextName%>/images/homeLogo.jpg" />
	<h2>Welcome to shopping application!</h2>
	<h5>Choose an option</h5>
	<form id="formId">
		<input type="button" id="displayProducts" value="Show All Products"
			onclick="showProducts()" /> 
		<input type="button" id="buyProducts"
			value="Buy Existing Products" onclick="createInputBuyProducts()" />
	</form>
	<div id="userInput"></div>
</body>
</html>
<%@ include file="result.jsp"%>
<%@ include file="lastTransactions.jsp"%>
<%@ include file="bottom.jsp"%>