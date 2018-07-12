<%-- 
    Document   : deposit1
    Created on : 25 Jun, 2018, 5:24:35 PM
    Author     : Yash
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
     <script
        src="https://code.jquery.com/jquery-3.3.1.js"
        integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
        crossorigin="anonymous"></script>
    
        <!-- Optional: include a polyfill for ES6 Promises for IE11 and Android browser -->
        <script src="https://unpkg.com/promise-polyfill"></script>
        <link rel="stylesheet" href="sweetalert2.min.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
 <%
     String id=session.getAttribute("uid").toString();
     int old_balance=0;
     int new_balance=0;
     Connection con = null;
     PreparedStatement pst=null;
     ResultSet rs = null;
     int amount=Integer.parseInt(request.getParameter("deposit_amount"));
     String to_account=id;
     String from_account=id;
     try {
             
             
             Class.forName("oracle.jdbc.driver.OracleDriver");
             con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "HR", "HR");
             
             
             pst=con.prepareStatement("SELECT * FROM FINAL1 WHERE ACCOUNT_NO=?");
             pst.setString(1,from_account);
             rs=pst.executeQuery();
              
             while(rs.next())
             {
             old_balance=Integer.parseInt(rs.getString(9));
             }
              
            new_balance=old_balance+amount;
            pst=con.prepareStatement("UPDATE FINAL1 SET BALANCE=? WHERE ACCOUNT_NO=?");
            pst.setInt(1,new_balance);
            pst.setString(2,to_account);
            pst.executeUpdate();
            
            
            pst=con.prepareStatement("INSERT INTO TRANSACTIONS VALUES(?,?,?,sysdate,seq_trans.nextval)");
            java.util.Date date = new java.util.Date();
            long t = date.getTime();
            java.sql.Date sqlDate = new java.sql.Date(t);
            pst.setString(1,to_account);
            pst.setString(2,from_account);
            pst.setInt(3,amount);
            pst.executeUpdate();
            %>
            
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.24.1/sweetalert2.all.min.js"></script>
        <script>
       
            $(document).ready(function()
                {
                   
                  swal({
                 title:'Sucess',
                 text:'Transaction Sucessful',
                 type:'success'
              }).then(function(){
                  window.location.href="home2.html";
              });
                });
            
        </script>    
        <%
         }
         catch (Exception e) 
           {
            out.println(e.getMessage());
           }
        
        
        %>
    </body>
</html>
