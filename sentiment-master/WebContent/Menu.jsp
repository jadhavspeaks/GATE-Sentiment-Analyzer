<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link href="style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/arial.js"></script>
<script type="text/javascript" src="js/cuf_run.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="js/jquery.tools.js"></script>
    <script type="text/javascript" src="js/ikonik.js"></script>

<!-- CuFon ends -->
</head>
<body>
<div class="sidebar">
        <div class="gadget">
          <h2 class="star"><span>Categories</span></h2><div class="clr"></div>
          <div id="categories">
            <ul>
  <li><a href="#">Mobiles</a>
	<ul>
    <li><a href="Products.jsp?Category=Mobile&productCategory=Apple">Apple</a></li>
    <li><a href="Products.jsp?Category=Mobile&productCategory=Samsung" onClick="2">Samsung</a></li>
    <li><a href="Products.jsp?Category=Mobile,productCategory=Nokia" onClick="3">Nokia</a></li>
	<li><a href="Products.jsp?Category=Mobile&productCategory=HTC" onClick="4">HTC</a></li>
    <li><a href="Products.jsp?Category=Mobile&productCategory=Sony" onClick="5">Sony</a></li>
    <li><a href="Products.jsp?Category=Mobile&productCategory=BlackBerry" onClick="6">BlackBerry</a></li>
    </ul>
</li>
<li><a href="#" >Cameras</a>
	<ul>
    <li><a href="Products.jsp?Category=Camera&productCategory=Nikon">Nikon</a></li>
    <li><a href="Products.jsp?Category=Camera&productCategory=Canon" onClick="2">Canon</a></li>
    <li><a href="Products.jsp?Category=Camera&productCategory=Sony" onClick="3">Sony</a></li>
	<li><a href="Products.jsp?Category=Camera&productCategory=Fujifilm" onClick="4">Fujifilm</a></li>
    <li><a href="Products.jsp?Category=Camera&productCategory=Panasonic" onClick="5">Panasonic</a></li>
    <li><a href="Products.jsp?Category=Camera&productCategory=Samsung" onClick="6">Samsung</a></li>
    </ul>
</li>
<li><a href="#">Computers</a>
	<ul>
	<li><a href="Products.jsp?Category=Computer&productCategory=HP" >HP</a></li>
    <li><a href="Products.jsp?Category=Computer&productCategory=Apple" onClick="2">Apple</a></li>
    <li><a href="Products.jsp?Category=Computer&productCategory=Dell" onClick="3">Dell</a></li>
	<li><a href="Products.jsp?Category=Computer&productCategory=Lenovo" onClick="4">Lenovo</a></li>
    <li><a href="Products.jsp?Category=Computer&productCategory=Asus" onClick="5">Asus</a></li>
    <li><a href="Products.jsp?Category=Computer&productCategory=Sony" onClick="6">Sony</a></li>
	<li><a href="Products.jsp?Category=Computer&productCategory=Acer" onClick="7">Acer</a></li>
    <li><a href="Products.jsp?Category=Computer&productCategory=HCL" onClick="8">HCL</a></li>
	</ul>
</li>
<li><a href="#">Television</a>
	<ul>
	<li><a href="Products.jsp?Category=Television&productCategory=Samsung">Samsung</a></li>
    <li><a href="Products.jsp?Category=Television&productCategory=LG" onClick="2">LG</a></li>
    <li><a href="Products.jsp?Category=Television&productCategory=Sony" onClick="3">Sony</a></li>
	<li><a href="Products.jsp?Category=Television&productCategory=Panasonic" onClick="4">Panasonic</a></li>
    <li><a href="Products.jsp?Category=Television&productCategory=Sharp" onClick="5">Sharp</a></li>
	</ul>
</li>
<li><a href="#">Memory</a>
    <ul>
    <li><a href="Products.jsp?Category=Memory&productCategory=WD">WD</a></li>
    <li><a href="Products.jsp?Category=Memory&productCategory=Transcend" onClick="2">Transcend</a></li>
    <li><a href="Products.jsp?Category=Memory&productCategory=HP" onClick="3">HP</a></li>
    <li><a href="Products.jsp?Category=Memory&productCategory=Sandisk" onClick="4">Sandisk</a></li>
    <li><a href="Products.jsp?Category=Memory&productCategory=SDHC" onClick="5">SDHC</a></li>
     </ul>
</li>

</ul>
		</div>

        </div>
         <div class="gadget">
        <h2 class="star"><span style="margin-left:40px;"><a href="Login.jsp">Sign in</a></span></h2>
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
		if (!validate(USERID, PASSWORD) ) 
			{
					int count = Integer.parseInt( session.getAttribute("count") );
							if (count > 1) 
								{
										response.sendRedirect("Index.jsp");
								}
								else 
									{
												count++;
												session.setAttribute("count");			
												response.sendRedirect("Login.jsp");
														}
	}
	}
</script>

        <form name="login" method="get" action="ValidateUser.jsp"
	onSubmit="javascript:return validate();">
          <label for="name">User ID </label>
          <br />
            <input id="name" name="uname" class="text" style="height:25px; width:200px;"/>
            <p>
              <label for="password">Password </label><br />
            <input id="password" name="pass" class="text" type="password" style="height:25px; width:200px;"/>
        </p>
        <input type="image" src="images/submit.gif" class="button" value="Submit" align="middle" style="margin-left:60px; margin-right:auto;"/>
        </form>
        <h5 style="margin-left:40px;">
        <a href="Registration.jsp">New User? <font size="+1">Sign Up</font></a></h5>
        </div>
      </div>
</body>
</html>