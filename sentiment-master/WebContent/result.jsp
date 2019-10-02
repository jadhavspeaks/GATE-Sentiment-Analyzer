<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="com.sentimentanalysis.*"%>
<%@page import="java.sql.*"%>

<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/arial.js"></script>
<script type="text/javascript" src="js/cuf_run.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="js/jquery.tools.js"></script>
    <script type="text/javascript" src="js/ikonik.js"></script>
<!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">

      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {
		alert("Analysis of Comment");
    	  var n1 = parseInt(document.getElementById("h2").value);
    	  var n2 = parseInt(document.getElementById("h3").value);
    	  alert(n1 + ","+ n2);
        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Positive');
        data.addColumn('number', 'Negative');
	
        data.addRows([
          ['Positive', n1],
          ['Negative', n2]
        ]);
		
        // Set chart options
        var options = {'title':'User Opinion',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
<!-- CuFon ends -->

<%!
            Connection con = null;
            PreparedStatement ps=null;
            PreparedStatement ps1=null;
            ResultSet rs1=null;
            ResultSet rs2=null;
            String cc=null;
            TextAnalysis.Result analysisOfComment =null;
            %>
<% 
	   DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	   con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM","manager");
       String pname = request.getParameter("h1");
	   String query1 = "select * from commenttab where product_name = ?";
       ps1 = con.prepareStatement(query1);
       ps1.setString(1,pname);
       rs2=ps1.executeQuery();
	String s="";
	while(rs2.next())
	{
	s = s + "." + rs2.getString(2);
	}
	SentenceSplitter splitter = new SentenceSplitter();
	splitter.init();
	analysisOfComment = splitter.calculateScore(s);
	System.out.println("Analysing the Comment ....");
	
	Statement pst1 = con.createStatement();
	ResultSet rs3 = pst1.executeQuery("select * from Score");
	int n1,n2;
	n1=0;
	n2=0;
	while(rs3.next())
	{
	 n1 = n1+rs3.getInt(1);
	 n2 = n2+rs3.getInt(2);
	}
	out.print("<input type='hidden' id='h2' value="+n1+">");
	out.print("<input type='hidden' id='h3' value="+n2+">");
	System.out.println("Score is : "+n1+","+n2);
	Statement st = con.createStatement();
	st.executeQuery("delete from Score");
   //pw.close();
%>
         <h2 align="center" style="color:#CCC;">Analysing the Comment</h2>
<table width="605" align="center" style="font-size: 16px; background-color:#CCC; padding-top:5px;" cellpadding="5" cellspacing="10" border="0">
  <tr>
   
  </tr>
</table>
<div id="chart_div" style="margin-left: auto; margin-right: auto;" align="center"></div>
          </li></ol>
<br></br> <hr></hr>        
