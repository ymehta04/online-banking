<%-- 
    Document   : withdraw1.jsp
    Created on : 20 Jun, 2018, 5:29:26 PM
    Author     : Yash
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.24.1/sweetalert2.all.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String id=session.getAttribute("uid").toString();
        String from_account=id;
        String to_account=id;
        int new_amount=Integer.parseInt(request.getParameter("withdraw_amt"));
        
     try {
             int old_balance=0;
             int new_balance=0;
             
             Connection con = null;
             PreparedStatement pst=null;
             ResultSet rs = null;
             int amount=Integer.parseInt(request.getParameter("withdraw_amt"));
             Class.forName("oracle.jdbc.driver.OracleDriver");
             con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "HR", "HR");
             
             /*Fetching balance data*/
             pst=con.prepareStatement("SELECT * FROM FINAL1 WHERE ACCOUNT_NO=?");
             pst.setString(1,from_account);
             rs=pst.executeQuery();
             
             while(rs.next())
             {
             old_balance=Integer.parseInt(rs.getString(9));
             }
             
             new_balance=old_balance-amount; 
             
             /*checking negative balance condition*/
             if(new_balance<0)
             {
                 /*if less than zero balance print error*/
             %>
             
        <script>
                  swal({
                 title:'Failure',
                 text:'Amount exceeded limit',
                 type:'error'
              }).then(function(){
                  window.location.href="withdraw.html";
              });
        </script>
           
        <% 
             }
            else
            {

            /*Update balance data*/
            pst=con.prepareStatement("UPDATE FINAL1 SET BALANCE=? WHERE ACCOUNT_NO=?");
            pst.setInt(1,new_balance);
            pst.setString(2,from_account);
            pst.executeUpdate();
            
            /*Make transaction entry*/
            pst=con.prepareStatement("INSERT INTO TRANSACTIONS VALUES(?,?,?,sysdate,seq_trans.nextval)");
            java.util.Date date = new java.util.Date();
            long t = date.getTime();
            java.sql.Date sqlDate = new java.sql.Date(t);
            pst.setString(1,to_account);
            pst.setString(2,from_account);
            pst.setInt(3,amount);
            pst.executeUpdate();
        %>
        
            <script>
                swal({
                     title:'Success',
                     text:'Transaction successful',
                     type:'success'
                    }).then(function(){
                        window.location.href="home2.html";
                        });
            </script>
        
           <% 
            }
                
         } 
            catch (Exception e) {
                out.println(e.getMessage());
           }
        
        
        %>
    </body>
</html>
