<%@ page import="java.sql.*" language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<%@page import="oracle.jdbc.driver.OracleDriver"%>
<head>
<script language="javascript">
	javascript:window.history.foward(-1);
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DELVE Online Shopee</title>
</head>
<body>
<%
	String uname1 = request.getParameter("usernm");
	String pass1 = request.getParameter("password");
	String cname1 = request.getParameter("cname");
	String cadd1 = request.getParameter("cadd");
	String cphn1= request.getParameter("cphn");
	String cfax1 = request.getParameter("cfax");
	String cemail1 = request.getParameter("cemail");
	String crno1 = request.getParameter("crno");
	PreparedStatement pst;
	ResultSet rs ;
	try {
		DriverManager.registerDriver(new OracleDriver());
		Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system","manager");
		pst=con.prepareStatement("insert into registeruser values(?,?,?,?,?,?,?,?)" );
		pst.setString(1, uname1);
		pst.setString(2, pass1);
		pst.setString(3, cname1);
		pst.setString(4, cadd1);
		pst.setString(5, cphn1);
		pst.setString(6, cfax1);
		pst.setString(7, cemail1);
		pst.setString(8, crno1);
	    pst.executeUpdate();
		out.println("success");
%>
<jsp:forward page="adIndex.jsp" />
<%
}
	catch (SQLException se) {
		System.out.println("sql exception has occuttreee " + se);
	}
%>

</body>
</html>