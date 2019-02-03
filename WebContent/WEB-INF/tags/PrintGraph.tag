<%@ tag body-content="empty"%>
<%@ tag import="QHandle.Graph"%>
<%@ tag import="java.sql.*"%>
<%@ tag import="java.io.*" %>
<%@ tag import="java.lang.String.*"%>
<%@ tag import="java.util.*"%>
<%@ tag import="javax.servlet.*" %>
<%@ attribute name="setType" required="true"%>
			
			<% 
			//3 or 5 ../
			//String Path = "../../webapps/";
			String CPATH = "";
			CPATH=request.getContextPath()+"/";
			
			//String CURRP = session.getServletConfig().getServletContext().getRealPath("/");
			
			//System.out.printf("\nCURR PATH:%s",CURRP);
			File FF = new File(".");
			
			System.setProperty("tomcat.util.http.parser.HttpParser.requestTargetAllow", "{}");
			
			System.out.printf("\nABS PATH:%s", FF.getAbsolutePath());
			
			//System.out.printf("\nREAL PATH:",request.getRealPath("/apache-tomcat-9.0.6/")));
			//CPATH = System.getProperty("catalina.base")+"/domains/group155database.com/";
			
			System.out.printf("\n\n CONTEXT PATH:%s\n\n",CPATH);
			System.out.printf("\n\n SERVLET PATH:%s\n\n",request.getServletPath());
			System.out.printf("\n\n PATH INFO:%s\n\n",request.getPathInfo());
			
			
			
			//String F = CPATH+"/"+Graph.Files.get(Integer.parseInt(setType));
			
			String F = Graph.Files.get(Integer.parseInt(setType));
			
			//File FFF = Graph.FFiles[Integer.parseInt(setType)];
			
			System.out.printf("\nFILE:%s\n",F);
			String PP = this.getClass().getResource("/").getPath()+"../../../../../webapps/";
			PP=PP.replace("file:","");
			System.out.printf("\n\n PROMISING PATH:%s\n\n",PP
					);
			
			if(!F.contains(".png")){
				out.println("File path failure1");
				System.exit(-1);
			}
			
			//String CPATH = request.getContextPath();
			
			//System.out.printf("\n\nCurr Dir:%s\n\n",CPATH);
			
			
			Graph.Keys=null;
			
			long CurrMillis = System.currentTimeMillis();
			
			while(Graph.Bytes[Integer.parseInt(setType)]==null){
				long X = System.currentTimeMillis()-CurrMillis;
				if(X>=100){
					//throw new Exception("WAITED TOO LONG FOR RESPONSE FOR GRAPHS!!");
					System.out.println("WAIT TIME1:"+X);
					//response.setHeader("Refresh","1; URL="+request.getRequestURL()+"?"+request.getQueryString());
					//return;
				}
			}
			
			while(Graph.Bytes[Integer.parseInt(setType)].length()==0){
				long X = System.currentTimeMillis()-CurrMillis;
				if(X>=100){
					//throw new Exception("WAITED TOO LONG FOR RESPONSE FOR GRAPHS!!");
					System.out.println("WAIT TIME2:"+X);
					//response.setHeader("Refresh","1; URL="+request.getRequestURL()+"?"+request.getQueryString());
					return;
				}
			}
			
			
			%>
			
			<img src="data:image/jpg;base64,<%=Graph.Bytes[Integer.parseInt(setType)]%>"/>
		
	