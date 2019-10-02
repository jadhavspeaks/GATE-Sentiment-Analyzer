<html>
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

  <div class="hbg">
    <div class="hbg_resize">
      <div class="menu_nav">
        <ul>
         <li><a href="adIndex.jsp">Home</a></li>
          <li><a href="adSupport.jsp">Support</a></li>
          <li><a href="adAbout.jsp">About Us</a></li>
          <li><a href="#">Modify Product</a></li>
          <li><a href="#">Analyse</a></li>
          <li class="active"><a href="adContact.jsp">Contact Us</a></li>
        </ul>
      </div>
    </div>
  </div>

  <div class="content">
    <div class="content_resize">
      <div class="mainbar">
        <div class="article">
          <h2><span>Contact</span></h2><div class="clr"></div>
          <p>Contact us for any queries.</p>
        </div>
        <div class="article">
          <h2><span>Send us</span> mail</h2><div class="clr"></div>
          <form action="#" method="post" id="sendemail">
          <ol><li>
            <label for="name">Name (required)</label>
            <input id="name" name="name" class="text" />
          </li><li>
            <label for="email">Email Address (required)</label>
            <input id="email" name="email" class="text" />
          </li><li>
            <label for="message">Your Message</label>
            <textarea id="message" name="message" rows="8" cols="50"></textarea>
          </li><li>
            <input type="image" name="imageField" id="imageField" src="images/submit.gif" class="send" />
            <div class="clr"></div>
          </li></ol>
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
      <p class="lf"> Copyright <a href="#">DELVE</a>. Layout by DELVE Team</p>
      <ul class="fmenu">
        <li><a href="adIndex.jsp">Home</a></li>
          <li><a href="adSupport.jsp">Support</a></li>
          <li><a href="adAbout.jsp">About Us</a></li>
          <li><a href="#">Modify Product</a></li>
          <li><a href="#">Analyse</a></li>
          <li class="active"><a href="adContact.jsp">Contact Us</a></li>
      </ul>
      <div class="clr"></div>
    </div>
  </div>
</div>
</body>
</html>
