<html>
<head>
<title>DELVE Online Shopee</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/arial.js"></script>
<script type="text/javascript" src="js/cuf_run.js"></script>
<%@page language="java" import="java.sql.*;"%>
<!-- CuFon ends -->
</head>
<body>
<div class="main">

<div class="header">
<div class="header_resize">
<div class="logo">
<h1><a href="Index.jsp"><span>DELVE</span> Online Shop <small>Explore
Your World</small></a></h1>
</div>
<div class="searchform">
<form id="formsearch" name="formsearch" method="post" action="">
<input name="button_search" src="images/search_btn.gif"
	class="button_search" type="image" /> <span><input
	name="editbox_search" class="editbox_search" id="editbox_search"
	maxlength="80" value="Search" type="text" /></span></form>
</div>
<div class="clr"></div>
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

<div class="content">
<div class="content_resize">
<div class="mainbar">
<div class="article">

<h2><span> <%!ResultSet rs = null;
	ResultSet Metadata = null;
	String name = null;

	int numcolumns;
	int i;%>
<% 
 	String company = null;
 	String productName = null;
 	String imageURL = null;
 	String name = request.getParameter("productCategory");
  	String Category = request.getParameter("Category");
 	try {

 		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
 		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "manager");
		PreparedStatement pst = con.prepareStatement("Select * from " + Category+ " where company =?");
 		pst.setString(1, name);
 		ResultSet rs = pst.executeQuery();
 		while (rs.next()) {
 				company = rs.getString("COMPANY");
 				productName = rs.getString("PRODUCTNAME");
 				imageURL = rs.getString("IMAGEURL");
 				
 				%>
		 <table><tr height="250px">	<td valign="top">
		<h3><%=productName%></h3>
		<div class="newest-item">
		<div class="newest-img" style="height:145px; width:170px;">
		<a	href="Product.jsp?productName=<%=productName%>&Category=<%=Category%>"> 
		<img src="<%=imageURL%>" alt="<%=productName%>" height="145px" width="170px"/></a>
		</div>
		</div>
		</td>
	</tr>
</table> 				
 				
 				<%
 		}
%> 		


<%
	}

	catch (Exception e) {
		out.println(e.toString());
	}
%> </span></h2>
<h4 style="margin-left: 30px;"></h4>




</div>
</div>
<%@include file="Menu.jsp"%>
 <div class="clr"></div>
    </div>
  </div>
<div class="fbg"></div>
<div class="footer">
<div class="footer_resize">
<p class="lf">� Copyright <a href="#">DELVE</a>. Layout by DELVE
Team</p>
<ul class="fmenu">
	<li class="active"><a href="Index.jsp">Home</a></li>
	<li><a href="Support.jsp">Support</a></li>
	<li><a href="Blog.jsp">Blog</a></li>
	<li><a href="About.jsp">About Us</a></li>
	<li><a href="Contact.jsp">Contacts</a></li>
</ul>
<div class="clr"></div>
</div>
</div>
</div>
</body>
</html>
