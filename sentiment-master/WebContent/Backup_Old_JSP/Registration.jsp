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

<script>
function isEmpty(str)
{
if(str=="")
{
return true;
}
else 
return false;
}
function valid()
{
f=document.form;
if(isEmpty(f.usernm.value))
{
alert("Please type your first name");
f.usernm.focus();
return false;
}
else 
return true;
}
function isAlphaNumeric(str1){
	len=str1.length;
	for(i=0; i<len; i++)
	{
	if( ((str1.charAt(i) >='a')&& (str1.charAt(i) <='z')) ||  ((str1.charAt(i) >='A')&& (str1.charAt(i) <='Z'))||((str1.charAt(i) >=0)&& (str1.charAt(i) <=9)) )
	{}
	else
	{
	return true; 
	break;
	}
	}
	}

function isValidusernmpassword(str) 
{
if(isEmpty(str) || str == "") 
return false;
var usernm = str.toString();
var n=password.length;	
var i;
for(i=0; i<n; i++) 
{
var ch = usernm.charAt(i);
if((!isAlphaNumeric(ch)) && (ch != "_")) 	
	 {
	return false;
  	}
  	}
	return true;
  }

function validate()
{
	alert("ok");	
var usernm = document.form.usernm.value;
var password = document.form.password.value;
var cname = document.form.cname.value;
var cadd = document.form.cadd.value;
var cphn = document.form.cphn.value;
var cfax = document.form.cfax.value;
var cemail = document.form.cemail.value;
var crno= document.form.crno.value;

var reg = new RegExp("^[A-Za-z0-9_]{1,}[.]?[A-Za-z0-9_]{1,}@{1}([A-Za-z0-9_]+[.]{1})+[A-Za-z0-9_]{1,}$");
if(isEmpty(usernm)) 
{
alert("Please type your first name.");
document.form.usernm.focus();
return false;
} 
else if(isEmpty(cemail)) 
{
alert("The Email_id is compulsory.");
document.form.cemail.focus();
return false;
} 
else if(isEmpty(cphn)) 
{
alert("Please type Phone.");
document.form.cphn.focus();
return false;
} 
else if(isEmpty(crno)) 
{
alert("Please type the Company registration no.");
document.form.crno.focus();
return false;
}
else if(isEmpty(password)) 
{
alert("Please type your password.");
document.form.password.focus();
return false;
} 

else if(isEmpty(cphn)) 
{
alert("Invalid characters in the office phone number. Please re-enter.");
document.form.cphn.focus();
return false;
}
else if(isEmpty(cfax)) 
{
alert("Invalid characters in the fax number entry. Please re-enter.");
document.form.cfax.focus();
return false;
}
return true;
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
        <form name="form1" method="post" action="">
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
<h3><span>Register Here</span></h3>
<div class="clr"></div>
<form name = "form" method="post" action="RegisterUserValidate.jsp"
                 onSubmit="javascript:return validate();">
          <ol><li>
            <label for="name">User ID (required)</label>
            <input id="usernm" name="usernm" class="text" style="height:25px;"/>
          </li><li>
            <label for="password">Password (required)</label>
            <input id="password" name="password" class="text" type="password" style="height:25px;"/>
          </li><li>
            <label for="cname">Company Name (required)</label>
            <input id="cname" name="cname" class="text" style="height:25px;" />
          </li><li>
            <label for="cadd">Company Address (required)</label>
            <textarea id="cadd" name="cadd" rows="8" cols="50"></textarea>
          </li><li>
            <label for="cphn">Company Phone</label>
            <input id="cphn"  name="cphn" maxlength=10 class="text" style="height:25px;" />
          </li><li>
            <label for="cfax">Company fax</label>
            <input id="cfax"  name="cfax" maxlength=4 class="text" style="height:25px;" />
          </li><li>
            <label for="cemail">Company E-Mail (required)</label>
            <input id="cemail" name="cemail" class="text" type="email" style="height:25px;" />
          </li><li>
            <label for="crno">Company Registration Number (required)</label>
            <input id="crno"  name="crno" maxlength=6 class="text" style="height:25px;" />
          </li><li>
           <div id="Captcha" >
    <script type="text/javascript">
     var RecaptchaOptions = {theme : 'white'};
    </script>
    <script type="text/javascript" src="http://www.google.com/recaptcha/api/challenge?k=6LeRscISAAAAACvYn-MrYaVHEftBW4z4rm63KHGz&amp;error=Invalid security code."></script>
	<noscript>
  		<iframe src="http://www.google.com/recaptcha/api/noscript?k=6LeRscISAAAAACvYn-MrYaVHEftBW4z4rm63KHGz&amp;error=Invalid security code." height="300" width="500" frameborder="0"></iframe><br/>
  		<textarea name="recaptcha_challenge_field" rows="3" cols="40"></textarea>
  		<input type="hidden" name="recaptcha_response_field" value="manual_challenge"/>
	</noscript>
    </div>
          </li><li>
            <input type="image" name="imageField" id="imageField" src="images/submit.gif" class="send" value="submit" />
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
