<%@ page import="java.sql.*" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@page import="com.sentimentanalysis.SentenceSplitter"%>
<%@page import="com.sentimentanalysis.TextAnalysis"%><html>
<%@page import="oracle.jdbc.driver.OracleDriver"%>
<head>
<title>DELVE Online Shopee</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
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

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Positive');
        data.addColumn('number', 'Negative');
        data.addRows([
          ['Positive', 1+analysisOfComment.score],
          ['Negative', 1+analysisOfComment.score],
        ]);

        // Set chart options
        var options = {'title':'User Openion',
                       'width':400,
                       'height':300};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
<!-- CuFon ends -->
</head>
<body>

<div class="main">
  <div class="header">
    <div class="header_resize">
      <div class="logo">
      <h1><a href="index.html"><span>DELVE</span> Online Shop <small>Explore Your World</small></a></h1></div>
      <div class="searchform">
        <form id="formsearch" name="formsearch" method="post" action="">
          <input name="button_search" src="images/search_btn.gif" class="button_search" type="image" />
          <span><input name="editbox_search" class="editbox_search" id="editbox_search" maxlength="80" value="Search" type="text" /></span>
        </form>
      </div>
      <div class="clr"></div>
    </div>
  </div>
</div>

  <div class="hbg">
    <div class="hbg_resize">
      <div class="menu_nav">
        <ul>
          <li class="active"><a href="Index.jsp">Home</a></li>
          <li><a href="Support.jsp">Support</a></li>
          <li><a href="About.jsp">About Us</a></li>
          <li><a href="Contact.jsp">Contact Us</a></li>
        </ul>
      </div>
    </div>
    
</div>
<%
	String email1 = request.getParameter("email");
	String comment1 = request.getParameter("message");
	try {
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM","manager");
		PreparedStatement pst = con.prepareStatement("insert into Commenttab values(?,?)");
		pst.setString(1, email1);
		pst.setString(2, comment1);
		ResultSet rs = pst.executeQuery();
		session.setAttribute("emailid", email1);
		session.setAttribute("usercomment", comment1);
		out.println("Thank You User!!!");
		
		pst.close();
		con.close();

		SentenceSplitter splitter = new SentenceSplitter();
		splitter.init();
		TextAnalysis.Result analysisOfComment = splitter.calculateScore(comment1);
		System.out.println("Analysing the Comment ....");
		System.out.println(analysisOfComment);
%>
<h2 align="center" style="color:#CCC;">Analysing the Comment</h2>
<table width="605" align="center" style="font-size: 16px; background-color:#CCC; padding-top:5px;" cellpadding="5" cellspacing="10" border="0">
  <tr>
    <td><%=analysisOfComment %></td>
  </tr>
   <tr>
    <td><div id="chart_div"></div></td>
  </tr>
</table>


<%

	}catch (SQLException se) {

		System.out.println("sql exception has occuttreee " + se);
		
	}
%>
</body>
</html>