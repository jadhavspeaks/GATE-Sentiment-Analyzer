
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="com.sentimentanalysis.*"%>
<%@page import="java.sql.*"%>

<head>
<title>DELVE Online Shopee</title>
</head>
<script language="javascript">

function getprod()
{
	alert("ok");
 var s = document.formsearch2.scat.value;
 document.formsearch2.h1.value = s;
}

</script>
<body>
</script>
<div class="searchform1">
<form id="formsearch1" name="formsearch1" method="post" action="#" onSubmit="getProd() >
<input name="button_search" >
<h2><span>Analyse Product</span></h2>
<ol><li>
         <label for="name">Select Product</label>          
            <%!
            Connection con = null;
            PreparedStatement ps=null;
            PreparedStatement ps1=null;
            ResultSet rs1=null;
            ResultSet rs2=null;
            String cc=null;
            %>
             <%
   DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
   con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", 

"SYSTEM","manager");
   String query="select distinct(product_name) from commenttab";
   ps=con.prepareStatement(query);
   rs1=ps.executeQuery(query); 
  %>
  </div>
 <div class="searchform2">
 <form id="formsearch2" name="formsearch2" method="post">
 <select name="scat">
			<%
			while(rs1.next())
			{
			%>
				<option value="<%=rs1.getString(1)%>">
				<%=rs1.getString(1)%>
				</option>
			<%
			}
			%>
 </select>            
<input type = "hidden" name="h1">
 <% 
       String pname = request.getParameter("h1"); 
       String query1 = "select * from commenttab where product_name = ?";
       ps1 = con.prepareStatement(query1);
       ps1.setString(1,pname);
       rs2=ps1.executeQuery();
%>
</div>
</form>
</li><li>
<input name="Analyse" type="submit" value="Analyse"" 
style="width:100px; margin-left:30px; margin-top:20px; 
height:30px;">
<%!
TextAnalysis.Result analysisOfComment =null;
%>

<%
	/*BufferedReader br = new BufferedReader(new 

FileReader("F://Sentiment1//CommentData//" + productName + ".txt"));
	String str = br.readLine();
	while (str != null) 
	{
		comment += str;
		str = br.readLine();
	}*/

	String s="";
	while(rs2.next())
	{
	s = s + "." + rs1.getString(2);
	}
	SentenceSplitter splitter = new SentenceSplitter();
	splitter.init();
	analysisOfComment = splitter.calculateScore(s);
	System.out.println("Analysing the Comment ....");
%>
            <div class="clr"></div>
          </li></ol>
          </form>
<br></br> <hr></hr>        
<h3><%=analysisOfComment %></h3>
        </div>

<p><%=analysisOfComment %></p>
</body>
</html>


