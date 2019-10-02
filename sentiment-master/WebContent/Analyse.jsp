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
var s = document.formsearch1.scat.value;
alert(s);
document.formsearch1.h1.value = s;
alert(document.formsearch1.h1.value);
document.formsearch1.submit;
}

</script>
<body>
<form id="formsearch1" name="formsearch1" method="get" action="result.jsp">
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
<input name="Analyse" type="submit" value="Analyse"" onClick="getprod()">
</form>
</body>
</html>


