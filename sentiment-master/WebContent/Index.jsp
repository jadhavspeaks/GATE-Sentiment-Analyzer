<html>
<head>

<title>DELVE Online Shopee</title>
	<link href="style.css" rel="stylesheet" type="text/css" />
<!-- CuFon: Enables smooth pretty custom font rendering. 100% SEO friendly. To disable, remove this section -->
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/arial.js"></script>
<script type="text/javascript" src="js/cuf_run.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.js"></script>
    <script type="text/javascript" src="js/jquery.tools.js"></script>
    <script type="text/javascript" src="js/ikonik.js"></script>

<!-- CuFon ends -->
 <script>
 
	function validate() {
		var USERID = document.form.name.value;
		var PASSWORD = document.form.password.value;
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
        <div class="article">
          <h2><span>New Products</span></h2><div class="clr"></div>
          <div id="newest">
        <div class="grid clearfix">
        	<div class="newest-left">
        	  
        	  <p><a class="next browse right"><img src="images/prev.png" style="padding-left:-15px; margin-top:60px; border:none;"></a></p>
        	</div>
        	<div class="newest">
        	  <div class="newest-wrap">
        	    <div class="newest-divider">
        	      <div class="newest-item">
        	        <div class="newest-img"> <a href="product-single.html" title="Another Set"><img src="uploads/new-icon.png" alt="Another Set" width="170" height="145"/></a> </div>
        	        <div class="newest-desc">
        	          <p>Another Set <span>|</span> $30</p>
      	          </div>
      	        </div>
        	      <div class="newest-item">
        	        <div class="newest-img"> <a href="product-single.html" title="Another Set"><img src="uploads/new-icon.png" alt="Another Set" width="170" height="145"/></a> </div>
        	        <div class="newest-desc">
        	          <p>Another Set <span>|</span> $30</p>
      	          </div>
      	        </div>
        	      <div class="newest-item">
        	        <div class="newest-img"><a href="product-single.html" title="Another Set"></a><a href="product-single.html" title="Another Set"><img src="uploads/new-icon.png" alt="Another Set" width="170" height="145"/></a></div>
        	        <div class="newest-desc">
        	          <p>Another Set <span>|</span> $30</p>
      	          </div>
      	        </div>
      	      </div>
        	    <div class="newest-divider">
        	      <div class="newest-item">
        	        <div class="newest-img"> <a href="product-single.html" title="Another Set"><img src="uploads/new-icon.png" alt="Another Set" width="170" height="145"/></a> </div>
        	        <div class="newest-desc">
        	          <p>Another Set <span>|</span> $30</p>
      	          </div>
      	        </div>
        	      <div class="newest-item">
        	        <div class="newest-img"> <a href="product-single.html" title="Another Set"><img src="uploads/new-icon.png" alt="Another Set" width="170" height="145"/></a> </div>
        	        <div class="newest-desc">
        	          <p>Another Set <span>|</span> $30</p>
      	          </div>
      	        </div>
        	      <div class="newest-item">
        	        <div class="newest-img"> <a href="product-single.html" title="Another Set"><img src="uploads/new-icon.png" alt="Another Set" width="170" height="145"/></a> </div>
        	        <div class="newest-desc">
        	          <p>Another Set <span>|</span> $30</p>
      	          </div>
      	        </div>
      	      </div>
        	    <div class="newest-divider">
        	      <div class="newest-item">
        	        <div class="newest-img"> <a href="product-single.html" title="Another Set"><img src="uploads/new-icon.png" alt="Another Set" width="170" height="145"/></a> </div>
        	        <div class="newest-desc">
        	          <p>Another Set <span>|</span> $30</p>
      	          </div>
        	        <a class="add-cart" href="#" title="Contact"><span>Add to Cart</span></a> </div>
      	      </div>
      	    </div>
      	  </div>
        	<div class="newest-right">
        	  <p><a class="prev browse left"><img src="images/next.png" style="padding-left:-35px; margin-top:60px; border:none;"></a></p></div>
        </div>
      </div>

        </div>        <div class="article">
          <h2><span>Popular Gadgets</span></h2><div class="clr"></div>
          <p><span class="date">March 15, 2010</span> &nbsp;|&nbsp; Posted by <a href="#">Owner</a> &nbsp;|&nbsp; Filed under <a href="#">templates</a>, <a href="#">internet</a></p>
          <img src="images/img2.jpg" width="263" height="146" alt="image" class="fl" />
          <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec libero. Suspendisse bibendum. Cras id urna. <a href="#">Morbi tincidunt, orci ac convallis aliquam, lectus turpis varius lorem, eu posuere nunc justo tempus leo.</a> Donec mattis, purus nec placerat bibendum, dui pede condimentum odio, ac blandit ante orci ut diam. Cras fringilla magna. Phasellus suscipit, leo a pharetra condimentum, lorem tellus eleifend magna, eget fringilla velit magna id neque. Curabitur vel urna. In tristique orci porttitor ipsum. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec libero. Suspendisse bibendum. Cras id urna. Morbi tincidunt, orci ac convallis aliquam.</p>
          <p>Aenean commodo elit ac ante dignissim iaculis sit amet non velit. Donec magna sapien, molestie sit amet faucibus sit amet, fringilla in urna. Aliquam erat volutpat. Fusce a dui est. Sed in volutpat elit. Nam odio tortor, pulvinar non scelerisque in, eleifend nec nunc. Sed pretium, massa sed dictum dapibus, nibh purus posuere magna, ac porta felis lectus ut neque. Nullam sagittis ante vitae velit facilisis lacinia. Cras vehicula lacinia ornare. Duis et cursus risus. Curabitur consectetur justo sit amet odio viverra vel iaculis odio gravida. Ut imperdiet metus nec erat.</p>
          <p class="spec"><a href="#" class="rm"></a> <a href="#" class="com"></a></p>
        </div>
      </div>
        <%@include file="Menu.jsp"%>
      <div class="clr"></div>
    </div>
  </div>
         
      </div>
      <div class="clr"></div>
    

  <div class="fbg"></div>
  <div class="footer">
    <div class="footer_resize">
      <p class="lf"> Copyright <a href="#">DELVE</a>. Layout by DELVE Team</p>
      <ul class="fmenu">
        <li class="active"><a href="Index.jsp">Home</a></li>
        <li><a href="Support.jsp">Support</a></li>
               <li><a href="About.jsp">About Us</a></li>
        <li><a href="Contact.jsp">Contacts</a></li>
      </ul>
      <div class="clr"></div>\
    </div>
  </div>
</div>
</body>
</html>
