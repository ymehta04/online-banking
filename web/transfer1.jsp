<%-- 
    Document   : transfer1
    Created on : 17 Jun, 2018, 7:03:59 PM
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.24.1/sweetalert2.all.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

<%
   String id=session.getAttribute("uid").toString();
   String from_account=id;         
   Connection con=null;
   PreparedStatement pst=null;
   ResultSet rs=null;
   String to_account=request.getParameter("ano");
   int amount=Integer.parseInt(request.getParameter("amt"));
   
       
       try
    { 
      int receiver_oldbalance=0;
      int receiver_newbalance=0;
              
      String message;
      Class.forName("oracle.jdbc.driver.OracleDriver");    
      con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "HR", "HR");
      
      /*Fetch balance data of sender*/
      pst=con.prepareStatement("SELECT * FROM FINAL1 WHERE ACCOUNT_NO=?");
      pst.setString(1, from_account);
      rs=pst.executeQuery();
      
      int sender_oldbalance=0;
      while(rs.next())
      {
      sender_oldbalance=Integer.parseInt(rs.getString(9));
      }
      int sender_newbalance=sender_oldbalance-amount;
      if(sender_newbalance>=0)
      {
      try{
       /*Transfer part*/   
          
      /*fetch old balance of the reciever*/
      pst=con.prepareStatement("SELECT * FROM FINAL1 WHERE ACCOUNT_NO=?");
      pst.setString(1,to_account);
      rs=pst.executeQuery();
      while(rs.next())
      {
         receiver_oldbalance=Integer.parseInt(rs.getString(9));
         
      }
    
      /*Update sender balance*/
      receiver_newbalance=receiver_oldbalance+amount;
      pst=con.prepareStatement("UPDATE FINAL1 SET BALANCE=? WHERE ACCOUNT_NO=?");
      pst.setInt(1, sender_newbalance);
      pst.setString(2 , from_account);
      pst.executeQuery();
      
      
      
      /*Update receiver balance*/
      pst=con.prepareStatement("UPDATE FINAL1 SET BALANCE=? WHERE ACCOUNT_NO=?");
      pst.setInt(1, receiver_newbalance);
      pst.setString(2 , to_account);
      pst.executeQuery();
      
      /*Insert new transaction*/
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
                 title:'Sucess',
                 text:'Transaction Sucessful',
                 type:'success'
              }).then(function(){
                  window.location.href="home2.html";
              });
                
            
        </script>
           <%
      
      }
      catch(Exception e)
      {
      out.println(e.getMessage());
      }
      }
      else
      {
       %>
        <script>
                  swal({
                 title:'Failure',
                 text:'Amount exceeded balance limit',
                 type:'error'
              }).then(function(){
                  window.location.href="transfer.html";
              });
                
            
        </script>
           <%
      }
      
    }
    catch(Exception e)
    {
     out.println(e.getMessage());
    }
%>
</body>
</html>
