<!-- Imports -->
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>
<%@ page import= "QHandle.*" %>
<!-- Used to give a prefix for custom tags -->
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" type="text/css" href="BaseStyle.css">
</head>

<body>

<div>
	<header>
		<nav>
				<a href="index.jsp">Home</a>
				<a href="Drinker.jsp">Drinker</a>
				<a href="Beer.jsp">Beer</a>
				<a href="Bar.jsp">Bar</a>
				<a href="Modification.jsp">Modification</a>
				<a href="Give Query.jsp">MySQL Query</a>
				<a href="Database Info.jsp">Database Info</a>
		</nav>
		
	</header>
</div>

<table>
<% 
try {
	Class.forName("com.mysql.jdbc.Driver"); 
    String connectionURL = "jdbc:mysql://bar-beer-drinker-plus.cqyzjclyvard.us-east-2.rds.amazonaws.com:3306/BBDP";
    Connection connection = null; 
    connection = DriverManager.getConnection(connectionURL, "TestUser", "TestUser");
    if(!connection.isClosed()){
         
    	//out.println("Successfully connected to " + "MySQL server using TCP/IP...\n");
        
         out.newLine();
    	//Perform a query... TESTTTTT
    	Statement st = null;
    	ResultSet rs = null;
    	st = connection.createStatement();
    	
    	String qry; 
    	//= "SELECT * FROM beer_transactions";
    	//QueryState Q = new QueryState("HELLO");
    	qry = "";
    	qry = (String)request.getParameter("T");
    	String ip = request.getHeader("X-Forwarded-For");  
		
		ip = QS.GetIp(ip,request);
		
		ip+="Query";
		System.out.printf("\nIP + Q-%s\n",ip);
		
    	request.setAttribute("Query",qry);
    	//IF WANT TO KEEP TRACK OF IPS...
    	//QueryState Q = new QueryState("","");
    	
    	%>
    	<my:IpSession qry = "<%= qry %>" />
    	<% 
   
		//Gets last result set
		
		rs = QS.ReadQueryResults(st,qry,-1*qry.split(";").length);
    	
    	if(rs==null){
    		out.println("Unable to get result from query");
    	}
    	else{
    	
    	ResultSetMetaData rsmd = rs.getMetaData();
    		
    	out.println("\n");
    	
    	%>
    	<my:PrintTable rsmd="<%= rsmd %>" rs="<%= rs %>" />
    	<% 
    	
    	}//Result
 
    }//Conn
    connection.close();
}catch(Exception ex){
	%>
	<tr>
	<td>
	<%
    out.println(ex);
	%>
	</td>
	</tr>
	<%
}
%>
</table>

</body>
<%!
public void PrintTable(ResultSet rs){
	
}
%>
</html>