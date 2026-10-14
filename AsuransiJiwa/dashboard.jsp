<% if (!"admin".equalsIgnoreCase((String)session.getAttribute("role"))) { response.sendRedirect("login.jsp"); return; } %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>
<div class="container">
  <h1>Dashboard Admin</h1>
  <%
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
      String[] t = {"produk","nasabah","polis","pembayaran","klaim"};
      for(String tb : t){
        ResultSet rs = c.createStatement().executeQuery("SELECT COUNT(*) FROM " + tb);
        rs.next();
  %>
  <div class="card"><b><%=tb.toUpperCase()%>:</b> <%=rs.getInt(1)%> data</div>
  <%  }
      c.close();
    } catch(Exception e) {
      out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
    }
  %>
</div>
<%@ include file="footer.jsp" %>