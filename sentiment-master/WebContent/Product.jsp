<%@page import="javax.swing.text.html.ImageView"%><html>
<%@page import="oracle.jdbc.driver.OracleDriver"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.*"%>
<head>
<title>DELVE Online Shopee</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/arial.js"></script>
<script type="text/javascript" src="js/cuf_run.js"></script>


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
<h2><%=request.getParameter("productName")%></h2>
<%
	String productName = request.getParameter("productName");
	String Category = request.getParameter("Category");
	session.setAttribute("nameOfProduct",productName);
	
	String imageURL = null;
	try {

		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM", "manager");

		PreparedStatement pst = con.prepareStatement("Select * from " + Category + " where PRODUCTNAME =?");
		pst.setString(1, request.getParameter("productName"));
		ResultSet rs = pst.executeQuery();

		int columnCount = rs.getMetaData().getColumnCount();

		while (rs.next()) {
			imageURL = rs.getString("imageUrl");
%>
<div class="clr"></div>
<table width="605" align="center" style="font-size: 16px;">
	<tr>
		<td colspan="2" style="height: 300px;">
		<center><img src="<%=imageURL%>"></center>
		</td>
	</tr>
</table>

<table width="600" border="0" style="font-size: 16px;">
	<%
		for (int i = 1; i < columnCount; i++) {
	%>
	<tr>
		<td class="text"><b><%=rs.getMetaData().getColumnName(i)%></b></td>
		<td><%=rs.getString(rs.getMetaData().getColumnName(i))%></td>
	</tr>

	<%
		}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</table>
<h2><span> </span></h2>
<h4 style="margin-left: 30px;"></h4>


<h2><span><br>
Comment</span></h2>
<p><input type="text" name="nameOfProduct"  value="<%=productName %>" /> </p>

<form method="get" id="sendemail" action="ValidateComment.jsp"
	onSubmit="javascript:return validate();">
<ol>
	<li><label for="email" style="padding-top: 2px;">Email
	Address (required)</label> <input id="email" name="email" class="text"
		style="height: 30px;" /></li>
	<li><label for="message" id="comment">Your Comment</label> <textarea
		id="message" name="message" rows="8" cols="50"></textarea></li>
	<li><input type="image" name="imageField" id="imageField"
		src="images/submit.gif" class="send" value=submit />
	<div class="clr"></div>
	</li>
</ol>
</form>
</div>
</div>
<%@include file="Menu.jsp"%>
<div class="clr"></div>
</div>
</div>

<div class="fbg"></div>
<div class="footer">
<div class="footer_resize">
<p class="lf">� Copyright <a href="#">ASUS</a>. Layout by ASUS
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
