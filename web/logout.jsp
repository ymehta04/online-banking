<%-- 
    Document   : logout
    Created on : 27 Jun, 2018, 3:15:41 PM
    Author     : Yash
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <script
        src="https://code.jquery.com/jquery-3.3.1.js"
        integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.24.1/sweetalert2.all.min.js"></script>
        
    
    </head>
    <body>
       <% 
           session.invalidate();
       %>
        <script>
                  swal({
                 title:'Sucess',
                 text:'Logout Sucessful',
                 type:'success'
              }).then(function(){
                  window.location.href="home.html";
              });
                
            
        </script>
    </body>
</html>
