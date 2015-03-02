<%@page import="com.redhat.shopping.demo.application.beans.User"%>
<% 
User userDetails = (User)session.getAttribute("userDetails");
if(userDetails!=null){%>
<a href="/shoppingApplication/application/showTransactions" title="Previous Transactions">Welcome <%=userDetails.getUserName()%></a>
<%}%>

