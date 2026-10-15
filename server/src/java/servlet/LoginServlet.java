package servlet;
import koneksi.Koneksi;
import java.io.*;import javax.servlet.*;import javax.servlet.http.*;
import java.sql.*;
public class LoginServlet extends HttpServlet{
  protected void doPost(HttpServletRequest r,HttpServletResponse s)throws ServletException,IOException{
    try{
      Connection c=Koneksi.getConnection();
      PreparedStatement p=c.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
      p.setString(1,r.getParameter("u"));p.setString(2,r.getParameter("p"));
      ResultSet rs=p.executeQuery();
      if(rs.next()){r.getSession().setAttribute("user",rs.getString("username"));s.sendRedirect("dashboard.jsp");}
      else s.sendRedirect("login.jsp?err=1");
    }catch(Exception e){e.printStackTrace();}
  }
}