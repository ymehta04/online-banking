<%-- 
    Document   : past
    Created on : 26-Jun-2018, 11:23:10
    Author     : NISHI
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
      <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="styley.css">
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Cookie" rel="stylesheet"> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<style type="text/css">

.btn
{
	margin-top: 50px;
}
.form-group
{
	margin-top: 40px;
	padding: 10px;
}
#wrapper
{
    height: 100%;
}
.about_section
{
	margin-top: 0;
}
</style>
</head>
<body>
<nav class="navbar navbar-expand-lg sticky-top">
 <div class="container">
  <a class="navbar-brand" href="#">
  <img src="logo1.png" width="100" height="50" class="d-inline-block align-top" alt="">
  </a>
  <button class="navbar-toggler  navbar-dark" type="button" data-toggle="collapse" data-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  
  <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
    <div class="navbar-nav">
      <a class="nav-item nav-link" href="home2.html">Home </a>
      </div>
  </div>

</div>
</nav>

<div class="transact">
	<nav aria-label="breadcrumb">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="home2.html">Home</a></li>
    		<li class="breadcrumb-item active" aria-current="page">Statement</li>
  		</ol>
	</nav>

<div id="wrapper">
   <div class="container contt">
<%
try {
    
    java.util.Date date=new java.util.Date();
    long t=date.getTime();
    java.sql.Date sqlData=new java.sql.Date(t);
    
    Class.forName("oracle.jdbc.driver.OracleDriver");  // MySQL database connection
    Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "HR", "HR");    
    //String id=(String)session.getAttribute("uid");
    String id=session.getAttribute("uid").toString();
    PreparedStatement pst = con.prepareStatement("Select * from TRANSACTIONS where TO_ACCOUNT=? or FROM_ACCOUNT=? AND ROWNUM<4 ORDER BY TRANS_DATE DESC");
    pst.setString(1,id);
    pst.setString(2, id);
    ResultSet rs = pst.executeQuery();
  if(!rs.next())
  {
   %>
   <h4>NO TRANSACTIONS</h4>
       
       <%  
           
  }
else{

%>
<H4 style="text-align:center;">LAST 5 TRANSACTIONS</h4>  
<TABLE cellpadding="15" border="0px " style="background-color: white;" >
 <TR>
<TD>DATE</TD>
<TD>TO</TD>
<TD>FROM</TD>
<TD>AMOUNT</TD>
</TR>
<%
while (rs.next()) {
%>

<TR>
<TD><%=rs.getDate(4)%></TD>
<TD><%=rs.getInt(1)%></TD>
<TD><%=rs.getInt(2)%></TD>
<TD><%=rs.getInt(3)%></TD>
</TR>
<% } %>
<%

}
}
catch (Exception ex) {

out.println(ex.getMessage());
}
%>

</TABLE>
    
 </div> 
</div>
</div>
            



<div class="footer">
	<div class="container">
		<div class="section">
			<ul style="list-style-type: none; z-index: 1;">
				<li class="l1" style="color:#777;">About us</li>
				<li>Mission</li>
				<li>CSR Activities</li>
				<li>History</li>
			</ul>
		</div>

		<div class="section">
			<ul style="list-style-type: none; z-index: 1;">
				<li class="l1" style="color:#777;">Services</li>
				<li>Withdrawal of money</li>
				<li>Deposit of money</li>
				<li>Transfer of money</li>
			</ul>
		</div>

		<div class="section">
			<ul style="list-style-type: none;">
				<li class="l1" style="color:#777; z-index: 1;">Customer Relation</li>
				<li>Call support</li>
				<li>Mailing adress</li>
				<li>Location</li>
			</ul>
		</div>

        
		<div class="section">
			<ul style="list-style-type: none;">
				<li class="l1" style="color:#777; z-index: 1;">Finances</li>
				<li>Investment Schemes</li>
				<li>Funds</li>
				<li>Stock options</li>
			</ul>
		</div>        
        <div class="social">
			<h4>Connect with us</h4>
			<ul id="sprite">
            	<li class="fa fa-facebook"></li>
            	<li class="fa fa-twitter"></li>
            	<li class="fa fa-google-plus"></li>
            	<li class="fa fa-instagram"></li>
            </ul> 
		
		</div>

        </div>
</div>
</body>
</html>
