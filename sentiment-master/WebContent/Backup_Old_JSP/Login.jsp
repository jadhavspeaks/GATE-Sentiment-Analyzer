<html>
<head>
<title>DELVE Online Shopee</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/arial.js"></script>
<script type="text/javascript" src="js/cuf_run.js"></script>

<!-- CuFon ends -->
        <script>
	function validate() {
		var USERID = document.form.uname.value;
		var PASSWORD = document.form.pass.value;
		if (USERID == "") {
			alert("Enter Username!");
			return false;
		}
		if (PASSWORD == "") {
			alert("Enter Password!");
			return false;
		}
		return true;
		if (!login(USERID, PASSWORD) ) 
			{
					int count = Integer.parseInt( session.getAttribute("count") );
							if (count > 3) 
								{
										response.sendRedirect("Login.jsp");
								}
								else 
									{
												count++;
												session.setAttribute("count");			
												response.sendRedirect("Index.jsp");
														}
	}
	}
</script>

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
        

<form name="login" method="get" action="ValidateUser.jsp"
	onSubmit="javascript:return validate();">
	
<div class align="center">
UserID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" style="color: blue;font-size: medium" name="uname" /><br />
<br />
Password&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" style="color: blue;font-size: medium" name="pass" /><br />
   <br /> 
   <input type="image" src="images/submit.gif" class="button" value="Submit" align="middle" /><br>

<div class="clearthis">&nbsp;</div>
</div>
</form>

<div id="link_cancel" align="center" ><a href="Registration.jsp" style="font: bold;color: black;font-size: medium;">Sign Up</a></div>
</div>

       <%@include file="Menu.jsp"%>
      <div class="clr"></div>
    </div>
  </div>
        <%

    String uname=(String)session.getAttribute("uname");
    if(uname!=null)
    {
           out.println(uname+" logged out, <a href=\"Login.jsp\">Back</a>");
           session.removeAttribute("uname");
            
        }
     else 
         {
         out.println("You are already not login <a href=\"Login.jsp\">Back</a>");
     }



%>  
        </div>
      <div class="clr"></div>
   
  <div class="fbg"></div>
  <div class="footer">
    <div class="footer_resize">
      <p class="lf">� Copyright <a href="#">DELVE</a>. Layout by DELVE Team</p>
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

</body>
</html>
