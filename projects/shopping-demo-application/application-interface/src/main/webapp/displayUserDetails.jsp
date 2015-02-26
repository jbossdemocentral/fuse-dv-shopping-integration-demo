<%@page import="com.redhat.shopping.demo.application.beans.User"%>
<% 
User userDetails = (User)session.getAttribute("userDetails");
if(userDetails!=null){%>
<a href="mailto:<%=userDetails.getEmailId()%>">Welcome <%=userDetails.getUserName()%></a>
<%}%>

