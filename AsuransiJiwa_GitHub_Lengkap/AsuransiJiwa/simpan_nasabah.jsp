<%@ page import="java.sql.*" %>
<%
  // Ambil parameter dari form
  String nama = request.getParameter("nama");
  String telepon = request.getParameter("telepon");
  String email = request.getParameter("email");
  String alamat = request.getParameter("alamat");

  // Validasi server-side (cadangan)
  if(nama == null || nama.trim().isEmpty() ||
     telepon == null || telepon.trim().isEmpty() ||
     email == null || email.trim().isEmpty() ||
     alamat == null || alamat.trim().isEmpty()){
    response.sendRedirect("tambah_nasabah.jsp?err=kosong");
    return;
  }

  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection(
      "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");

    PreparedStatement ps = c.prepareStatement(
      "INSERT INTO nasabah (nama, alamat, telepon, email) VALUES (?,?,?,?)");
    ps.setString(1, nama.trim());
    ps.setString(2, alamat.trim());
    ps.setString(3, telepon.trim());
    ps.setString(4, email.trim());
    ps.executeUpdate();
    c.close();

    // Redirect ke halaman nasabah dengan notifikasi sukses
    response.sendRedirect("nasabah.jsp?sukses=1");

  } catch(Exception e) {
    // Kalau error, redirect kembali dengan kode error
    response.sendRedirect("tambah_nasabah.jsp?err=db");
  }
%>