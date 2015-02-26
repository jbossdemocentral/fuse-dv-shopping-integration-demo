<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/shoppingApplication/css/styles.css" type="text/css"/>	
<script src='/shoppingApplication/js/jquery.min.js'></script>
<script>
	var cookies;
	function readCookie(name) {
		if (cookies) {
			return cookies[name];
		}

		var c = document.cookie.split('; ');
		cookies = {};
		var C;
		for (var i = c.length - 1; i >= 0; i--) {
			C = c[i].split('=');
			cookies[C[0]] = C[1];
		}

		return cookies[name];
	}

	window.readCookie = readCookie; // or expose it however you want

	function showProducts() {
		var form = document.getElementById("formId");
		form.setAttribute("action", "/shoppingApplication/application/show");
		form.setAttribute("method", "get");
		form.submit();

	}


	function createInputBuyProducts() {
		if (readCookie("ACCESS-TOKEN")) {
			$('#userInput').html("");
			$('#userInput')
					.html(
							"<form id='buyProductTemplate' method='get' action='/shoppingApplication/application/buy'><input type='text' name='productCode'/> "
									+ "<input type='submit' id='buyProducts' value='Buy' /></form>");
		} else {
			authenticateUser();
		}
	}

	function  authenticateUser() {
		var form = document.getElementById("formId");
		form.setAttribute("action", "/shoppingApplication/application/authenticate");
		form.setAttribute("method", "get");
		form.submit();
		
	}
</script>
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
<%@ include file="bottom.jsp"%>