<%@ page import="java.sql.*" %>
<%
  String nama = request.getParameter("nama");
  String email = request.getParameter("email");
  String telepon = request.getParameter("telepon");
  String subjek = request.getParameter("subjek");
  String pesan = request.getParameter("pesan");

  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection(
      "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");

    PreparedStatement ps = c.prepareStatement(
      "INSERT INTO pesan (nama, email, telepon, subjek, pesan) VALUES (?,?,?,?,?)");
    ps.setString(1, nama);
    ps.setString(2, email);
    ps.setString(3, telepon);
    ps.setString(4, subjek);
    ps.setString(5, pesan);
    ps.executeUpdate();
    c.close();

    response.sendRedirect("kontak.jsp?status=sukses");
  } catch(Exception e) {
    out.println("Error: " + e.getMessage());
    // response.sendRedirect("kontak.jsp?status=gagal");
  }
%>