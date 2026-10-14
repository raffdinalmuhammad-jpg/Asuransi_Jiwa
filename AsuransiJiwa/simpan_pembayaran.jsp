<%@ page import="java.sql.*" %>
<%
  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection(
      "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
    PreparedStatement ps = c.prepareStatement(
      "INSERT INTO pembayaran (polis_id, jumlah, tanggal, metode, status) VALUES (?,?,?,?,?)");
    ps.setInt(1, Integer.parseInt(request.getParameter("polis_id")));
    ps.setInt(2, Integer.parseInt(request.getParameter("jumlah")));
    ps.setString(3, request.getParameter("tanggal"));
    ps.setString(4, request.getParameter("metode"));
    ps.setString(5, request.getParameter("status"));
    ps.executeUpdate();
    c.close();
    response.sendRedirect("tambah_pembayaran.jsp?sukses=1");
  } catch(Exception e) {
    out.println("Error: " + e.getMessage());
  }
%>