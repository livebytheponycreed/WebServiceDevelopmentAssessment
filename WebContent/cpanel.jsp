<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="uts.ws.User" %>
<%
	User user = (User)session.getAttribute("user");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
	if(user==null)
	{
%>
		You are not logged in.<br/>
		You will be redirected shortly..
		
<%
		response.setHeader("Refresh","3;url=index.jsp?cat=all");
	}
	else
	{
%>
		You are logged in as <%=user.getName()%> < <%=user.getEmail()%> ><br/>
		<a href="index.jsp?cat=all">Index</a> | <a href="logout.jsp">Logout</a>
<%
	}
%>
</body>
</html>