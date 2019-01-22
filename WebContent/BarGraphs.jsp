<%@ page import="QHandle.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML>
<html>

<head>
<link rel="stylesheet" type="text/css" href="BaseStyle.css">
<!--  <link rel="stylesheet" href="reset.css">
	<link rel="stylesheet" href="960_24_col.css">
	<link rel="stylesheet" href="text.css">
	<link rel ="stylesheet" href="STYLE10.css">
	-->

<title>My Website</title>


</head>


<body>
	<div class="container_24">
		<header>
			<nav>

				<a href="index.jsp">Home</a>
				<a href="Beer.jsp">Beer</a>
				<a href="Drinker.jsp">Drinker</a>
				<a href="Bar.jsp">Bar</a>
				<a href="Modification.jsp">Modification</a>
				<a href="Give Query.jsp">MySQL Query</a>
				<a href="Database Info.jsp">Database Info</a>

			</nav>


			<%
				Connection connection = QS.GetConnection();

					if (connection != null) {
						String ip = request.getHeader("X-Forwarded-For");
						ip = QS.GetIp(ip, request);

						Statement st = connection.createStatement();
						if(st==null){
							return;
						}
						ResultSet rs = null;

						ResultSetMetaData rsmd = null;
						
						System.out.println("BAR GRAPHS 0");
						
						Graph.Files = null;
						
						Graph.Files=new LinkedList<String>();
				
						Graph.Count=0;
						Graph.Bytes=null;
						Graph.Bytes=new String[10];
						
						try{
						
						String Bar = (String) request.getParameter("Bar1");
				    	if(Bar==null){
				    		throw new Exception("NO BAR ENTRY");
				    	}
				    	if(Bar.length()==0){
				    		throw new Exception("NO BAR ENTRY");
				    	}
						request.setAttribute(ip,Bar);
				    	
						//Add drinker name to query

						String qry = QS.SetQuery(Bar, 5);
						rs = st.executeQuery(qry);
			
						rsmd = rs.getMetaData();	
						
						if (qry == "") {
							return;
						}
						
					
						
						String Title = "Largest_Spenders_of_Drinkers_for_"+Bar.replace(" ","-");
						
						Title = Title.replace(' ','-');
							
						%>
						<my:SetGraph setQry="<%=qry%>" setTitle="<%=Title%>" setCategory="Largest Spenders of Drinkers" setXLabel="Drinkers" setYLabel="Price Total" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="2"/>
						<my:PrintGraph setType="0"/>
						<%
						
						Statement st2 = connection.createStatement();
						
						qry = QS.SetQuery(Bar,6);
						
						//Gets last result set
						
						rs = QS.ReadQueryResults(st2,qry,0);
						
						rsmd = rs.getMetaData();
						
						
						Title = "Most_Popular_Beers_for_" +Bar; 
						
						Title = Title.replace(' ','-');
						
						%>
						<my:SetGraph setQry="<%=qry%>" setTitle="<%=Title%>" setCategory="Most Popular Beers" setXLabel="Beers" setYLabel="Frequency" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="2"/>
						<my:PrintGraph setType="1"/>
						<%
						
						Statement st3 = connection.createStatement();
						
						qry = QS.SetQuery(Bar,7);
						
						//Gets last result set
						
						rs = QS.ReadQueryResults(st3,qry,1);
						
						rsmd = rs.getMetaData();
						
						Title = "Manufacturers-selling-the-most-beers-for-" +Bar; 
						
						Title = Title.replace(' ','-');
						
						%>
						<my:SetGraph setQry="<%=qry%>" setTitle="<%=Title%>" setCategory="Manufacturere Selling the Most Beers" setXLabel="Manufacturers" setYLabel="Frequency" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="3"/>
						<my:PrintGraph setType="2"/>
						<%
						
						Statement st4 = connection.createStatement();
						
						qry = QS.SetQuery(Bar,8);
						
						//Gets last result set
						
						rs = st4.executeQuery(qry);
						
						rsmd = rs.getMetaData();
						
						
						Title = "Time-Distribution-of-Sale-for-" +Bar; 
						
						Title = Title.replace(' ','-');
						
						%>
						<my:SetGraph setQry="<%=qry%>" setTitle="<%=Title%>" setCategory="Time Distribution of Sales" setXLabel="Time" setYLabel="Price" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="4"/>
						<my:PrintGraph setType="3"/>
						<%	
						
						Statement st5 = connection.createStatement();
						
						qry = QS.SetQuery(Bar,9);
						
						//Gets last result set
						
						rs = QS.ReadQueryResults(st5,qry,2);
						
						rsmd = rs.getMetaData();
						
						Title= "Busiest Periods of Day for "+ Bar;
						
						Title = Title.replace(' ','-');		
								
						%>
						<my:SetGraph setQry="<%=qry%>" setTitle= "<%=Title%>" setCategory="Busiest Periods of the Day" setXLabel="Consumables" setYLabel="Frequency" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="4"/>
						<my:PrintGraph setType="4"/>
						<%
						
						
						Statement st6 = connection.createStatement();
						qry = QS.SetQuery(Bar,14);
						
						rs = QS.ReadQueryResults(st6,qry,2);
						
						rsmd = rs.getMetaData();
						
						Title = "Busiest Periods of Week for "+Bar;
						
						Title = Title.replace(' ','-');		
								
						%>
						<my:SetGraph setQry="<%=qry%>" setTitle= "<%=Title%>" setCategory="Busiest Periods of the Week" setXLabel="Consumables" setYLabel="Frequency" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="4"/>
						<my:PrintGraph setType="5"/>
						<%
						
						}catch(Exception r){
							System.err.println(r);
							%><table><tr><td> <%
							out.println(r);
							%>
							</td></tr></table>
							<%
						}
									//Graph.Files = null;
									connection.close();
									if(st!=null){
										st.close();
									}
								}
					else{
						%><table><tr><td> <%
						out.println("CONNECTION FAILED");
						%>
						</td></tr></table>
						<%
					}
						%>


			<h1 class="clearfix">
				<a href="#"></a>
			</h1>
		</header>
	</div>

</body>
</html>