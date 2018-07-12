<%-- 
    Document   : userlogin
    Created on : 28-Jun-2018, 11:53:33
    Author     : NISHI
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
.user_login
{
	min-height: 600px;
	height: auto;
	background: grey url("userlogin.jpg") center center no-repeat;
	background-size: cover; 
	max-width: 100%;
	width: auto;
	margin-top: 0px;

}
.btn
{
	margin-top: 50px;
}
.form-group
{
	margin-top: 40px;
	padding: 10px;
}
.about_section
{
	margin-top: 0;
}
</style>
</head>
<body>
    <%
        String a;
        String id=session.getAttribute("uid").toString();
        Connection con=null;
        PreparedStatement pst=null;
        ResultSet rs=null; 
        Class.forName("oracle.jdbc.driver.OracleDriver");    
        con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "HR", "HR");
        pst = con.prepareStatement("SELECT * FROM FINAL1 WHERE ACCOUNT_NO=?");
        pst.setString(1,id);
        rs = pst.executeQuery();
    %>
            
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

<div class="user_login">
	<nav aria-label="breadcrumb">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="home2.html">Home</a></li>
    		<li class="breadcrumb-item active" aria-current="page">User-Info</li>
  		</ol>
	</nav>

<div id="wrapper">
	<div class="container contb">
		
            
            <%
                    
                       while( rs.next())
                        {
                            %>
                            <div class="row" style="margin-bottom:30px;">
				<div class=" col-sm-6" >
					UserName:
        		        </div>
        		<div class="col-sm-5" >
                            <%
                                out.println(rs.getString(2)+" "+rs.getString(3));

                                %>
        		</div>
        	</div>
                        
                        
                        <div class="row" style="margin-bottom:30px;">
				<div class=" col-sm-6" >
					AccountNo:
        		        </div>
        		<div class="col-sm-5" >
                            <%
                                out.println(rs.getInt(1));

                                %>
        		</div>
        	</div>
                        
                        
                        
                        
                        <div class="row" style="margin-bottom:30px;">
				<div class=" col-sm-6" >
					Balance:
        		        </div>
        		<div class="col-sm-5" >
                            <%
                                out.println(rs.getInt(9));

                                %>
        		</div>
        	</div>
                        
                        
                        
                        
                        
                            <%
                            
                            
                        }
                %>
			
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







                  <%-- <% 
                       String name=(String)session.getAttribute("sessname"); 
                       out.print(name); 
                    %> --%>
                
                  
                  
                  
                  <%--  <% 
                       out.print(id); 
                    %>  --%>
                
                  
                  
                  
                  <%--  <%
                        
                        pst = con.prepareStatement("Select * from final1 where userid=?");
                        pst.setString(1,id);
                        rs = pst.executeQuery();
                        rs.next();
                        {
                          a=rs.getString("balance");
                        } 
                     out.println(a);
                    %>
                   --%>
             