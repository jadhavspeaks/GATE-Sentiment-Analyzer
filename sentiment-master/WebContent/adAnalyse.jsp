
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="com.sentimentanalysis.*"%>
<%@page import="java.sql.*"%>

<head>
<title>DELVE Online Shopee</title>
<meta http-equiv="Content-Type" content="text/html; 

charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% 

SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/arial.js"></script>
<script type="text/javascript" src="js/cuf_run.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.js"></script>
    <script type="text/javascript" 

src="js/jquery.tools.js"></script>
    <script type="text/javascript" src="js/ikonik.js"></script>

<!-- CuFon ends -->
</head>
<%--  <script language="javascript">
	function getSubCat()
	{
          document.forms[0].submit();
	}
</script>
--%>
<body>

<div class="main">

  <div class="header">
    <div class="header_resize">
      <div class="logo">
      <h1><a href="index.html"><span>DELVE</span> Online 

Shop <small>Explore Your World</small></a></h1></div>
      <div class="searchform">
        <form id="formsearch" name="formsearch" method="post" 

action="">
          <input name="button_search" src="images/search_btn.gif" 

class="button_search" type="image" />
          <span><input name="editbox_search" 

class="editbox_search" id="editbox_search" maxlength="80" 

value="Search" type="text" /></span>
        </form>
      </div>
      <div class="clr"></div>
    </div>
  </div>

  <div class="hbg">
    <div class="hbg_resize">
      <div class="menu_nav">
        <ul>
          <li><a href="adIndex.jsp">Home</a></li>
          <li><a href="adSupport.jsp">Support</a></li>
          <li><a href="adAbout.jsp">About Us</a></li>
          <li><a href="adModify.jsp">Modify Product</a></li>
          <li class="active"><a 

href="adAnalyse.jsp">Analyse</a></li>
          <li><a href="adContact.jsp">Contact Us</a></li>
        </ul>
      </div>
    </div>
  </div>

  <div class="content">
    <div class="content_resize">
      <div class="mainbar">
        <div class="article">
          <h2><span>Analyse Product</span></h2><div 

class="clr"></div>
         <form action="#" method="post" id="sendemail">
          <ol><li>
            <label for="name">Select Product</label>
            
            <%!
            Connection con = null;
            PreparedStatement ps=null;
            PreparedStatement ps1=null;
            ResultSet rs=null;
            ResultSet rs1=null;
            String cc=null;
            %>
             <%
   DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
   con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "SYSTEM","manager");
   String query="select distinct(cname)from category";
   ps=con.prepareStatement(query);
   rs=ps.executeQuery(query);
   
  %>
   <select name="prod" style="width:300px;">
   <option value = "mobile">Mobiles</option>
   <option value = "computer">Computers</option>
   <option value = "camera" >Cameras</option>
   <option value = "television" >Television</option>
   <option value = "memory" >Memory</option>
   </select>
   <select name="scat" onChange="test()">
			<%while(rs.next())
			{%>
				<option value="<%=rs1.getString(3)%>">
				</option>
			<%}%>
	</select> 
              
   <%  String query1 = "select * from commenttab where product_name = ?";
       String prodid = request.getParameter("prod");
       ps1 = con.prepareStatement(query1);
       ps1.setString(1,mprod);
       rs1=ps1.executeQuery();
     %>
        </select>
          </li><li>
            <input name="Analyse" type="button" value="Analyse" 

style="width:100px; margin-left:30px; margin-top:20px; 

height:30px;">
<%!
TextAnalysis.Result analysisOfComment =null;
%>




<%
	//String productName = "iphone5";
	String comment = "good";
	
	/*BufferedReader br = new BufferedReader(new FileReader("F://Sentiment1//CommentData//" + productName + ".txt"));
	String str = br.readLine();
	while (str != null) {
		comment += str;
		str = br.readLine();
	}*/
	String s="";
	while(rs1.next())
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
      </div>
        <%@include file="Menu.jsp"%>
      <div class="clr"></div>
    </div>
  </div>

  <div class="fbg"></div>
  <div class="footer">
    <div class="footer_resize">
      <p class="lf"> Copyright <a href="#">DELVE</a>. Layout 

by DELVE Team</p>
      <ul class="fmenu">
        <li><a href="adIndex.jsp">Home</a></li>
          <li><a href="adSupport.jsp">Support</a></li>
          <li><a href="adAbout.jsp">About Us</a></li>
          <li><a href="adModify.jsp">Modify Product</a></li>
          <li class="active">;<a 

href="adAnalyse.jsp">Analyse</a></li>
          <li><a href="adContact.jsp">Contact Us</a></li>
      </ul>
      <div class="clr"></div>
    </div>
  </div>
</div>

<p><%=analysisOfComment %></p>
</body>
</html>


