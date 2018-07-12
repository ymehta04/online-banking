<%-- 
    Document   : register
    Created on : 19-Jun-2018, 16:03:57
    Author     : NISHI
--%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
String a;
    Connection con=null;
   PreparedStatement pst=null;
   ResultSet rs=null; 
String fname=request.getParameter("fname"); 
String lname=request.getParameter("lname");
String mobileno=request.getParameter("mobileno");
String aadhaar=request.getParameter("ano");
String pan=request.getParameter("pan");
String email=request.getParameter("email");
String password=request.getParameter("password");
try
{
   
Class.forName("oracle.jdbc.driver.OracleDriver");    
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/XE", "HR", "HR");
PreparedStatement ps = con.prepareStatement("INSERT INTO FINAL1(ACCOUNT_NO,FNAME,LNAME,MOBILENO,AADHAAR,PAN,EMAIL,PASSWORD) VALUES(seq_person.nextval,?,?,?,?,?,?,?)");
ps.setString(1,fname);
ps.setString(2,lname);
ps.setString(3,mobileno);
ps.setString(4,aadhaar);
ps.setString(5,pan);
ps.setString(6,email);
ps.setString(7,password);
int i = ps.executeUpdate();
if (i!=0)
{
pst = con.prepareStatement("SELECT ACCOUNT_NO FROM FINAL1 WHERE PAN=?");
pst.setString(1,pan);
rs = pst.executeQuery();
rs.next();
{
a=rs.getString("ACCOUNT_NO");
//out.println(a);
}
%>
                 
        <script>
       
            $(document).ready(function()
                {
                   var s=<%=a%>;
                    swal({
                 title:'Sucess',
                 //text:'Registration Sucessful',
                 
                 text:'Registration Sucessful. Your Account No is '+s+'\n Kindly note it.',
                 type:'success'
              }).then(function(){
                  window.location.href="login.html";
              });
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
