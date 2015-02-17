<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>

<%
Boolean displayAuthentication = true;
if(request.getSession().getAttribute("displayAuthentication")!=null){
    displayAuthentication = false;
}
%>


    <script src='http://code.jquery.com/jquery-1.11.2.min.js'></script>
    <script>
    
    
    $( document ).ready(function() {
        
    });


    function showProducts(){
        window.open("http://localhost:9090/route/shoppingApplication/products");
        }


function authenticate(){
        window.open("http://localhost:8080/authorize");
}

function buyProducts(){
        window.open('http://localhost:9090/route/shoppingApplication/products/'+document.getElementById('productCode').value+"/buy");
        }
                        
function createInputBuyProducts(){
        <%if(displayAuthentication){%>
            alert("Buying products requires authentication. You will be directed to the google authentication page now");
            authenticate();
        <%}%>
        $('#userInput').html("");
        $('#userInput').html("<input type='text' id='productCode'/>"+
            "<input type='button' id='buyProducts' value='BUY' onclick='buyProducts()'/>"
            );
    }
</script>


</head>
<body>
<h2>Welcome to shopping application!</h2>
<h5>Choose an option</h5>
<input type="button" id="showProducts" value="Show All Products" onclick="showProducts()"/>
<input type="button" id="buyProducts" value="Buy Existing Products" onclick="createInputBuyProducts()"/>
<%  if(displayAuthentication){%>
<input type="button" id="buyProducts" value="Authenticate" onclick="authenticate()"/>
<%}%>

<div id="userInput"/>
<table id="result" border="10" style="display:none"/></table>




</body>
</html>