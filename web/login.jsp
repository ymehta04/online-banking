<%-- 
    Document   : login
    Created on : 19-Jun-2018, 22:27:52
    Author     : NISHI
--%>

<%@page import="org.apache.catalina.Session"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
         <script
        src="https://code.jquery.com/jquery-3.3.1.js"
        integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
        crossorigin="anonymous"></script>  
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.24.1/sweetalert2.all.min.js"></script>
    </head>
    <body>
        <% 
   
   try{
        String id = request.getParameter("userid");   
        String password = request.getParameter("password");
        Class.forName("oracle.jdbc.driver.OracleDriver");  // MySQL database connection
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "HR", "HR");  
        PreparedStatement pst = con.prepareStatement("SELECT ACCOUNT_NO,PASSWORD FROM FINAL1 WHERE ACCOUNT_NO=? AND PASSWORD=?");
        pst.setString(1,id);
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();  
        if(rs.next()) 
        {
        session.setAttribute("uid",id);
        
        %>
       <script>
            $(document).ready(function()
                {
                   
                swal({
                 title:'Sucess',
                 text:'Login Sucessful',
                 type:'success'
              }).then(function(){
                  window.location.href="home2.html";
              });
                });
            </script>
<%  }
           
           else
           {%>
         <script>
       
            $(document).ready(function()
                {
                   
                    swal({
                 title:'Failure',
                 text:'Login Not Sucessful',
                 type:'error'
              }).then(function(){
                  window.location.href="login.html";
              });
                });
            </script>    <%       
}
}
   catch(Exception e){       
       out.println(e.getMessage());       
   }      
      %>
    </body>
</html>
