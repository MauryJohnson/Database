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

				<a href="index.jsp" class="selected">Home</a> <a href="Drinker.jsp">Drinker</a>
				<a href="Bar.jsp">Bar</a> <a href="Beer.jsp">Beer</a>
				<a href="Modification.jsp">Modification</a> 
				<a
href="Give Query.jsp">MySQL Query</a>
				<a href="Database Info.jsp">Database Info</a>

			</nav>


			<%
				Connection connection = QS.GetConnection();
			
				//RESET ALL FILE
				Graph.Files=null;
				Graph.Files=new LinkedList<String>();
			
					if (connection != null) {
						String ip = request.getHeader("X-Forwarded-For");
						ip = QS.GetIp(ip, request);

						Statement st = connection.createStatement();
						ResultSet rs = null;

						Graph.Files=null;
						Graph.Files=new LinkedList<String>();
						Graph.Count=0;
						Graph.Bytes=null;
						Graph.Bytes=new String[10];
						
						try{
						
						String Beer = ""+(String) request.getParameter("Beer1");
						if(Beer==null){
							throw new Exception("NO BEER ENTRY");
						}
						if(Beer.length()==0){
							throw new Exception("NO BEER ENTRY");
						}
						
						//Add drinker name to query

    					request.setAttribute(ip+"Beer",Beer);
						
			%>

			<my:IpSession qry="<%=Beer%>" />

			<%
			
			%>
			<h2><%=Beer%></h2>
			<%
					
				//First Image
					String qry = QS.SetQuery(Beer, 10);
					rs = st.executeQuery(qry);
					ResultSetMetaData rsmd = rs.getMetaData();
					
					String Title = "Bars Where "+Beer+" Sells the Most";
					
					Title = Title.replace(' ','-');
					
					%>
					<my:SetGraph setQry="<%=qry%>" setTitle="<%=Title%>" setCategory="Most Beer Sells in Bars" setXLabel="Beers" setYLabel="Frequency" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="5" />
					<my:PrintGraph setType="0"/>
					<% 
				//First Image
				
				//Second Image
					qry = QS.SetQuery(Beer,11);
					rs = st.executeQuery(qry);
					rsmd = rs.getMetaData();
				
					Title = "Drinkers who are the biggest consumers of "+Beer;
					
					Title = Title.replace(' ','-');
					
					%>
					<my:SetGraph setQry="<%=qry%>" setTitle="<%=Title%>" setCategory="Biggest Consumers" setXLabel="Drinkers" setYLabel="Frequency" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="6" />
					<my:PrintGraph setType="1"/>
					<%
					
				//Second Image
			
				//Third Image
					qry = QS.SetQuery(Beer,12);
					rs = st.executeQuery(qry);
					rsmd = rs.getMetaData();
				
					Title = "Time distribution of When "+Beer+" Sells the Most";
					
					Title = Title.replace(' ','-');
					
					%>
					<my:SetGraph setQry="<%=qry%>" setTitle="<%=Title%>" setCategory="Time Distribution" setXLabel="Time" setYLabel="Frequency" setRsmd="<%=rsmd%>" setRs="<%=rs%>" setType="6" />
					<my:PrintGraph setType="2"/>
					<%
					
					
				//Third Image
				
			}
			catch(Exception r){
				System.err.println(r);
				%><table><tr><td> <%
				out.println(r);
				%>
				</td></tr></table>
				<%
			}
			

					connection.close();
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