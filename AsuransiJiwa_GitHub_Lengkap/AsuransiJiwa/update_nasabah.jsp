<%@ page import="java.sql.*" %>
<%
  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection(
      "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
    PreparedStatement ps = c.prepareStatement(
      "UPDATE nasabah SET nama=?, alamat=?, telepon=?, email=? WHERE id=?");
    ps.setString(1, request.getParameter("nama"));
    ps.setString(2, request.getParameter("alamat"));
    ps.setString(3, request.getParameter("telepon"));
    ps.setString(4, request.getParameter("email"));
    ps.setInt(5, Integer.parseInt(request.getParameter("id")));
    ps.executeUpdate();
    c.close();
    response.sendRedirect("nasabah.jsp");
  } catch(Exception e) {
    out.println("Error: " + e.getMessage());
  }
%>