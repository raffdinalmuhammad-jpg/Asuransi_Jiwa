<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<div class="container">
  <h2>Laporan Penjualan</h2>
  <%
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
      ResultSet r1 = c.createStatement().executeQuery("SELECT COUNT(*) FROM polis");
      r1.next();
      ResultSet r2 = c.createStatement().executeQuery("SELECT IFNULL(SUM(jumlah),0) FROM pembayaran");
      r2.next();
  %>
  <div class="card">Total Polis Terjual: <b><%=r1.getInt(1)%></b></div>
  <div class="card">Total Pendapatan: <b>Rp <%=r2.getInt(1)%></b></div>
  <%
      c.close();
    } catch(Exception e) {
      out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
    }
  %>
</div>
<%@ include file="footer.jsp" %>