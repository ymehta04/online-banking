/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package p1;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Yash
 */
public class transfer1 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
    
   String first_ano="1";         
   Connection con=null;
   PreparedStatement pst=null;
   ResultSet rs=null;
   String second_ano=request.getParameter("ano");
   int amount=Integer.parseInt(request.getParameter("amt"));
   
       
       try
    { int secoldamt=0;
      String message;
      Class.forName("oracle.jdbc.driver.OracleDriver");    
      con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "HR", "HR");
      pst=con.prepareStatement("SELECT * FROM CUSTOMER WHERE ACCOUNT_NO=?");
      pst.setString(1, first_ano);
      rs=pst.executeQuery();
      int minbal=2000;
      while(rs.next())
      {
      int oldamt=Integer.parseInt(rs.getString(3));
      if(oldamt-amount>=2000)
      {
      try{
      
      pst=con.prepareStatement("SELECT * FROM CUSTOMER WHERE ACCOUNT_NO=?");
      pst.setString(1,second_ano);
      rs=pst.executeQuery();
      while(rs.next())
      {
         secoldamt=Integer.parseInt(rs.getString(3));
         
      }
          
          
          
      pst=con.prepareStatement("UPDATE CUSTOMER SET BALANCE=? WHERE ACCOUNT_NO=?");
      pst.setInt(1, oldamt-amount);
      pst.setString(2 , first_ano);
      pst.execute();
      
      
      
      
      pst=con.prepareStatement("UPDATE CUSTOMER SET BALANCE=? WHERE ACCOUNT_NO=?");
      pst.setInt(1, amount+secoldamt);
      pst.setString(2 , second_ano);
      pst.execute();
      
      out.println("Success");
      }
      catch(Exception e)
      {
      out.println(e.getMessage());
      }
      }
      else
      {
      out.println("Amount exceeds transfer limit");
      }
      
      
      }
    
    }
    catch(Exception e)
    {
     out.println(e.getMessage());
    }
    
        
        
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
   
        
        
    
    
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
