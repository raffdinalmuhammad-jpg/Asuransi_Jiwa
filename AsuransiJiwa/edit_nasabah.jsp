<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<div class="container">
  <h2>✏️ Edit Nasabah</h2>

  <%
    int id = 0;
    String nama = "", alamat = "", telepon = "", email = "";
    try {
      id = Integer.parseInt(request.getParameter("id"));
      Class.forName("com.mysql.jdbc.Driver");
      Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
      PreparedStatement ps = c.prepareStatement("SELECT * FROM nasabah WHERE id=?");
      ps.setInt(1, id);
      ResultSet rs = ps.executeQuery();
      if(rs.next()){
        nama = rs.getString("nama");
        alamat = rs.getString("alamat");
        telepon = rs.getString("telepon");
        email = rs.getString("email");
      }
      c.close();
    } catch(Exception e) { out.println("<p style='color:red'>" + e.getMessage() + "</p>"); }
  %>

  <form action="update_nasabah.jsp" method="post" class="card">
    <input type="hidden" name="id" value="<%=id%>">
    <p>Nama: <input type="text" name="nama" value="<%=nama%>" required style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc"></p>
    <p>Alamat: <input type="text" name="alamat" value="<%=alamat%>" style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc"></p>
    <p>Telepon: <input type="text" name="telepon" value="<%=telepon%>" style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc"></p>
    <p>Email: <input type="email" name="email" value="<%=email%>" style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc"></p>
    <button class="btn" type="submit">💾 Update</button>
  </form>
</div>

<%@ include file="footer.jsp" %>