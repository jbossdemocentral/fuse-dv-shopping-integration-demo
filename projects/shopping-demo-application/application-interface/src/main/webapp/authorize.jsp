<%= request.getAttribute("message") %>. 
<a href="/shoppingApplication/camel/authorize?callBackUrl=<%= request.getAttribute("callBackUrl")%>">Click here</a> to authorize this application to access your Google Contacts.This is necessary to buy products.

<%@ include file="bottom.jsp" %>