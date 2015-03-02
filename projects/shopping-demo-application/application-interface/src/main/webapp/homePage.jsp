<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/shoppingApplication/css/styles.css" type="text/css"/>	
<script src='/shoppingApplication/js/jquery.min.js'></script>
<script src='/shoppingApplication/js/application.js'></script>
<title>Shopping Application</title>
</head>
<body>
	<%@ include file="displayUserDetails.jsp"%>
	<img src="/shoppingApplication/images/homeLogo.jpg" />
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