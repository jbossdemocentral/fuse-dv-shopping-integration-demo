<%= request.getAttribute("message") %>. 
<a href="<%= request.getContextPath()%>/camel/authorize?callBackUrl=<%= request.getAttribute("callBackUrl")%>">Click here</a> to authorize this application to access your Google Contacts.This is necessary to buy products.

<%@ include file="bottom.jsp" %>