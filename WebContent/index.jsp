<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" %>
<%@ page import="uts.ws.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%
	User user = (User)session.getAttribute("user");
	boolean isLogged = false;
	if(user!=null)
	{
		isLogged = true;
	}
%> 
 <%
 
 //this store all our categories
 //we loop through this array and print each one out in the nav menu
	String[] navItems = new String[6];
	 navItems[0]="all";
	 navItems[1]="sports";
	 navItems[2]="games";
	 navItems[3]="entertainment";
	 navItems[4]="business";
	 navItems[5]="politics";
	 String id = "000";
	 String cat = "all";//if there are no params in url then it is set to default to all
 	if(request.getParameter("cat")!=null)//checks if the choosen category is not null
 	{
 		cat = request.getParameter("cat");//sets cat to the current category in url
 	}
 	else if(request.getParameter("id")!= null){
		id = request.getParameter("id");
	}
 	else{
 		response.sendRedirect("index.jsp?cat=all");//reloads index.jsp and sets category to all
 	}
 %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>News Page</title>
<link type="text/css" rel="stylesheet" href="css/index.css" media="screen"/>
<link type="text/css" rel="stylesheet" href="css/index_class.css" media="screen"/>
</head>
<body>
	<div id="left">
		<div id="appname" class="appname">
			NEWSAPP
		</div>
		<div id="nav">
		<%
		/**
			Loop For the News Category menu
		 */
			for(int i=0;i<navItems.length;i++)
			{
				if(navItems[i].equals(cat))
				{
				%>
				<a href="?cat=<%=navItems[i]%>">
					<div id="nav_item" class="nav_item" style="background : #5b5b5b">
						<%=navItems[i].toUpperCase()%>
					</div>
				</a>
				<%
				}
				else
				{
				%>
				<a href="?cat=<%=navItems[i]%>">
					<div id="nav_item" class="nav_item">
						<%=navItems[i].toUpperCase()%>
					</div>
				</a>
				<%
				}
			}
		%>
		</div>
		<% 
		if(isLogged)
		{
			out.println("Welcome, "+user.getEmail());
			%>
				<br/><a href="cpanel.jsp">Manage</a> | <a href="logout.jsp">Logout</a>
			<%
		}
		else
		{
		%>
			<div id="login">
			<form action="login.jsp" method="POST">
				<div id="log_label" class="log_label">LOGIN</div>
				<label>Username : </label><br/>
					<input id="log_input" type="text" name="log_username" /><br/>
				<label>Password : </label><br/>
					<input id="log_input" type="password" name="log_password"/><br/>
				<input type="submit" value="Login" id="log_submit"/>
			</form>
		</div>
		<%
		}
		 %>
		
	</div>
<!-- 	Getting articles after category -->
	<div id="right">
	<% if (cat.equalsIgnoreCase("all") && id.equals("000")){ %>
	<c:import var="xml" url="WEB-INF/articles.xml" />
	<c:import var="xslt" url="WEB-INF/articles.xsl" />
	<x:transform xml="${xml}" xslt="${xslt}" />
	<% }%>
	<% if (cat.equalsIgnoreCase("sports") && id.equals("000")){ %>
	<c:import var="xml" url="http://localhost:8080/WebServiceDevelopmentAssessment/rest/articles/tag?tag=sport" />
	<c:import var="xslt" url="WEB-INF/articles.xsl" />
	<x:transform xml="${xml}" xslt="${xslt}" />
	<% }%>
	<% if (cat.equalsIgnoreCase("games") && id.equals("000")){ %>
	<c:import var="xml" url="http://localhost:8080/WebServiceDevelopmentAssessment/rest/articles/tag?tag=games" />
	<c:import var="xslt" url="WEB-INF/articles.xsl" />
	<x:transform xml="${xml}" xslt="${xslt}" />
	<% }%>
	<% if (cat.equalsIgnoreCase("entairtainment") && id.equals("000")){ %>
	<c:import var="xml" url="http://localhost:8080/WebServiceDevelopmentAssessment/rest/articles/tag?tag=sport" />
	<c:import var="xslt" url="WEB-INF/articles.xsl" />
	<x:transform xml="${xml}" xslt="${xslt}" />
	<% }%>
	<% if (cat.equalsIgnoreCase("business") && id.equals("000")){ %>
	<c:import var="xml" url="http://localhost:8080/WebServiceDevelopmentAssessment/rest/articles/tag?tag=business" />
	<c:import var="xslt" url="WEB-INF/articles.xsl" />
	<x:transform xml="${xml}" xslt="${xslt}" />
	<% }%>
	<% if (cat.equalsIgnoreCase("politics") && id.equals("000")){ %>
	<c:import var="xml" url="http://localhost:8080/WebServiceDevelopmentAssessment/rest/articles/tag?tag=politics" />
	<c:import var="xslt" url="WEB-INF/articles.xsl" />
	<x:transform xml="${xml}" xslt="${xslt}" />
	<% }%>
	
<!-- 	Getting a Article after ID -->
	<%
	if (!id.equals("000")){
	%>
	<c:set var="ID" value="<%=id%>"/>
	<c:import var="xml" url="http://localhost:8080/WebServiceDevelopmentAssessment/rest/articles/article?id=${ID}" />
	<c:import var="xslt" url="WEB-INF/articlefull.xsl" />
	<x:transform xml="${xml}" xslt="${xslt}" />
	<%}%>
	</div>
</body>
</html>