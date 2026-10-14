<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<style>
  .agen-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
    margin-top: 20px;
  }
  .agen-card {
    background: #fff;
    border-radius: 12px;
    padding: 25px 20px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    border-top: 4px solid #1976d2;
  }
  .agen-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 25px rgba(25, 118, 210, 0.25);
  }
  .agen-card img {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    border: 4px solid #1976d2;
    object-fit: cover;
    margin-bottom: 12px;
  }
  .agen-card h3 {
    color: #0d47a1;
    margin: 8px 0 4px;
    font-size: 18px;
  }
  .agen-card .jabatan {
    display: inline-block;
    background: #e3f2fd;
    color: #1976d2;
    font-size: 12px;
    padding: 4px 12px;
    border-radius: 20px;
    margin-bottom: 12px;
    font-weight: 600;
  }
  .agen-card .info {
    font-size: 14px;
    color: #555;
    margin: 6px 0;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
  }
  .agen-card .btn-kontak {
    display: inline-block;
    margin-top: 12px;
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 8px 18px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 13px;
    transition: 0.3s;
  }
  .agen-card .btn-kontak:hover {
    background: #0d47a1;
    box-shadow: 0 4px 10px rgba(13, 71, 161, 0.4);
  }
  .stat-bar {
    display: flex;
    justify-content: space-around;
    background: linear-gradient(90deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 25px;
    flex-wrap: wrap;
  }
  .stat-bar div {
    text-align: center;
    padding: 10px;
  }
  .stat-bar .angka {
    font-size: 26px;
    font-weight: bold;
  }
  .stat-bar .label {
    font-size: 13px;
    opacity: 0.9;
  }
</style>

<div class="container">
  <h2>👥 Daftar Agen Resmi</h2>
  <p style="color:#666;margin-bottom:10px">Tim agen profesional kami siap membantu Anda di seluruh Indonesia.</p>

  <div class="stat-bar">
    <div>
      <div class="angka" id="totalAgen">0</div>
      <div class="label">Total Agen</div>
    </div>
    <div>
      <div class="angka">34</div>
      <div class="label">Kota Terjangkau</div>
    </div>
    <div>
      <div class="angka">10+</div>
      <div class="label">Tahun Pengalaman</div>
    </div>
    <div>
      <div class="angka">4.9★</div>
      <div class="label">Rating Pelanggan</div>
    </div>
  </div>

  <div class="agen-grid">
  <%
    int total = 0;
    boolean pakaiDB = true;
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
      ResultSet rs = c.createStatement().executeQuery(
        "SELECT nama, kota, telepon, email, jabatan, foto FROM agen ORDER BY id");

      while(rs.next()){
        total++;
        String nama = rs.getString("nama");
        String kota = rs.getString("kota");
        String telp = rs.getString("telepon");
        String email = rs.getString("email");
        String jab = rs.getString("jabatan");
        String foto = rs.getString("foto");
        if(foto == null || foto.isEmpty())
          foto = "https://i.pravatar.cc/150?u=" + nama;
  %>
      <div class="agen-card">
        <img src="<%=foto%>" alt="<%=nama%>">
        <h3><%=nama%></h3>
        <div class="jabatan"><%=jab%></div>
        <div class="info">📍 <%=kota%></div>
        <div class="info">📞 <%=telp%></div>
        <div class="info">✉️ <%=email%></div>
        <a class="btn-kontak" href="https://wa.me/62<%=telp.replaceAll("[^0-9]","").substring(1)%>" target="_blank">
          💬 Hubungi
        </a>
      </div>
  <%
      }
      c.close();
    } catch(Exception e) {
      pakaiDB = false;
      // ====== FALLBACK DATA DUMMY (kalau database belum siap) ======
      String[][] data = {
        {"Budi Santoso",   "Jakarta",    "0812-3456-7890", "budi@asuransi.com",  "Senior Agent",     "https://i.pravatar.cc/150?img=12"},
        {"Siti Aminah",    "Bandung",    "0813-4567-8901", "siti@asuransi.com",  "Agency Manager",   "https://i.pravatar.cc/150?img=45"},
        {"Andi Wijaya",    "Surabaya",   "0814-5678-9012", "andi@asuransi.com",  "Financial Advisor","https://i.pravatar.cc/150?img=33"},
        {"Dewi Lestari",   "Yogyakarta", "0815-6789-0123", "dewi@asuransi.com",  "Customer Relation","https://i.pravatar.cc/150?img=48"},
        {"Rudi Hartono",   "Medan",      "0816-7890-1234", "rudi@asuransi.com",  "Marketing Agent",  "https://i.pravatar.cc/150?img=15"},
        {"Maya Sari",      "Semarang",   "0817-8901-2345", "maya@asuransi.com",  "Junior Agent",     "https://i.pravatar.cc/150?img=23"}
      };
      for(String[] a : data){
        total++;
  %>
      <div class="agen-card">
        <img src="<%=a[5]%>" alt="<%=a[0]%>">
        <h3><%=a[0]%></h3>
        <div class="jabatan"><%=a[4]%></div>
        <div class="info">📍 <%=a[1]%></div>
        <div class="info">📞 <%=a[2]%></div>
        <div class="info">✉️ <%=a[3]%></div>
        <a class="btn-kontak" href="#">💬 Hubungi</a>
      </div>
  <%
      }
    }
  %>
  </div>
</div>

<script>
  document.getElementById('totalAgen').innerText = '<%=total%>';
</script>

<%@ include file="footer.jsp" %>