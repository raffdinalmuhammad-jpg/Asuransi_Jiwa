<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<style>
  .nasabah-header {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.25);
  }
  .nasabah-header h2 { color: #fff; margin-bottom: 8px; font-size: 26px; }
  .nasabah-header p { opacity: 0.9; }

  .stat-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 25px;
  }
  .stat-card {
    background: #fff;
    padding: 22px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    display: flex;
    align-items: center;
    gap: 15px;
    border-left: 5px solid #1976d2;
    transition: 0.3s;
  }
  .stat-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(25, 118, 210, 0.2);
  }
  .stat-card .ikon {
    font-size: 16px;
    font-weight: bold;
    background: #e3f2fd;
    color: #1976d2;
    width: 55px; height: 55px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    letter-spacing: 0.5px;
  }
  .stat-card .isi .angka {
    font-size: 22px;
    font-weight: bold;
    color: #0d47a1;
  }
  .stat-card .isi .label {
    font-size: 13px;
    color: #666;
  }

  .toolbar {
    display: flex;
    justify-content: space-between;
    gap: 15px;
    margin-bottom: 20px;
    flex-wrap: wrap;
  }
  .toolbar input {
    flex: 1;
    min-width: 250px;
    padding: 12px 18px;
    border: 2px solid #e3f2fd;
    border-radius: 25px;
    font-size: 14px;
    outline: none;
    transition: 0.3s;
  }
  .toolbar input:focus {
    border-color: #1976d2;
    box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
  }
  .toolbar .btn-tambah {
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 12px 24px;
    border-radius: 25px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 600;
    transition: 0.3s;
    border: none;
    cursor: pointer;
    white-space: nowrap;
  }
  .toolbar .btn-tambah:hover {
    background: #0d47a1;
    box-shadow: 0 4px 12px rgba(13, 71, 161, 0.4);
  }

  .nasabah-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 20px;
  }
  .nasabah-card {
    background: #fff;
    border-radius: 14px;
    padding: 22px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border-top: 4px solid #1976d2;
    transition: 0.3s;
    display: flex;
    flex-direction: column;
  }
  .nasabah-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 25px rgba(25, 118, 210, 0.2);
  }
  .nasabah-top {
    display: flex;
    align-items: center;
    gap: 15px;
    margin-bottom: 15px;
  }
  .avatar {
    width: 60px; height: 60px;
    border-radius: 50%;
    background: linear-gradient(135deg, #1976d2, #0d47a1);
    color: #fff;
    font-size: 20px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    box-shadow: 0 4px 10px rgba(25, 118, 210, 0.3);
    letter-spacing: 1px;
  }
  .nasabah-top .nama {
    font-size: 17px;
    font-weight: bold;
    color: #0d47a1;
    margin-bottom: 3px;
  }
  .nasabah-top .id {
    font-size: 12px;
    color: #888;
  }
  .nasabah-info {
    font-size: 13px;
    color: #555;
    margin: 6px 0;
    display: flex;
    align-items: flex-start;
    gap: 8px;
  }
  .nasabah-info .ikon {
    flex-shrink: 0;
    width: 40px;
    font-weight: bold;
    color: #1976d2;
    font-size: 11px;
    letter-spacing: 0.3px;
  }
  .polis-badge {
    display: inline-block;
    background: #e8f5e9;
    color: #2e7d32;
    padding: 4px 12px;
    border-radius: 15px;
    font-size: 12px;
    font-weight: 600;
    margin-top: 10px;
    width: fit-content;
  }
  .polis-badge-kosong {
    background: #fff3e0;
    color: #e65100;
  }
  .aksi {
    display: flex;
    gap: 8px;
    margin-top: 15px;
  }
  .aksi button, .aksi a {
    flex: 1;
    padding: 9px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 12px;
    font-weight: 600;
    text-align: center;
    border: none;
    cursor: pointer;
    transition: 0.3s;
    font-family: inherit;
  }
  .btn-detail {
    background: #e3f2fd;
    color: #1976d2;
  }
  .btn-detail:hover { background: #bbdefb; }
  .btn-edit {
    background: #fff3e0;
    color: #e65100;
  }
  .btn-edit:hover { background: #ffe0b2; }

  .modal {
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.6);
    z-index: 9999;
    align-items: center;
    justify-content: center;
    padding: 20px;
  }
  .modal.aktif { display: flex; }
  .modal-box {
    background: #fff;
    padding: 30px;
    border-radius: 15px;
    max-width: 550px;
    width: 100%;
    max-height: 90vh;
    overflow-y: auto;
    animation: slideUp 0.3s ease;
  }
  @keyframes slideUp {
    from { transform: translateY(50px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
  }
  .modal-box h3 {
    color: #0d47a1;
    margin-bottom: 20px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e3f2fd;
  }
  .modal-box .row {
    margin: 10px 0;
    padding: 10px 12px;
    background: #f5f9ff;
    border-radius: 8px;
    display: flex;
    justify-content: space-between;
    font-size: 14px;
  }
  .modal-box .row strong { color: #0d47a1; }
  .modal-box .btn-tutup {
    display: block;
    width: 100%;
    margin-top: 20px;
    background: #1976d2;
    color: #fff;
    padding: 12px;
    border: none;
    border-radius: 25px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
  }
  .modal-box .btn-tutup:hover { background: #0d47a1; }

  .kosong {
    text-align: center;
    padding: 60px 20px;
    color: #999;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
  }
  .kosong h3 { color: #666; margin-bottom: 10px; }
</style>

<!-- ============ HEADER ============ -->
<div class="container">
  <div class="nasabah-header">
    <h2>Data Nasabah</h2>
    <p>Daftar nasabah asuransi jiwa yang terdaftar</p>
  </div>
</div>

<%
  // ====== STATISTIK ======
  int totalNasabah = 0;
  int totalPolis = 0;
  int nasabahDenganPolis = 0;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection(
      "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");

    ResultSet r1 = c.createStatement().executeQuery("SELECT COUNT(*) FROM nasabah");
    if(r1.next()) totalNasabah = r1.getInt(1);

    ResultSet r2 = c.createStatement().executeQuery("SELECT COUNT(*) FROM polis");
    if(r2.next()) totalPolis = r2.getInt(1);

    ResultSet r3 = c.createStatement().executeQuery(
      "SELECT COUNT(DISTINCT nasabah_id) FROM polis");
    if(r3.next()) nasabahDenganPolis = r3.getInt(1);

    c.close();
  } catch(Exception e) { /* diamkan */ }
%>

<!-- ============ STATISTIK ============ -->
<div class="container">
  <div class="stat-grid">
    <div class="stat-card">
      <div class="ikon">NASABAH</div>
      <div class="isi">
        <div class="angka"><%=totalNasabah%></div>
        <div class="label">Total Nasabah</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="ikon">POLIS</div>
      <div class="isi">
        <div class="angka"><%=totalPolis%></div>
        <div class="label">Total Polis</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="ikon">AKTIF</div>
      <div class="isi">
        <div class="angka"><%=nasabahDenganPolis%></div>
        <div class="label">Nasabah Aktif</div>
      </div>
    </div>
    <div class="stat-card">
      <div class="ikon">RATA2</div>
      <div class="isi">
        <div class="angka">
          <%= totalNasabah > 0 ? Math.round(totalPolis * 100.0 / totalNasabah) : 0 %>%
        </div>
        <div class="label">Rata-rata Polis</div>
      </div>
    </div>
  </div>
</div>

<!-- ============ TOOLBAR ============ -->
<div class="container">
  <div class="toolbar">
    <input type="text" id="cari" placeholder="Cari nama / email / telepon nasabah..." onkeyup="filterNasabah()">
    <a href="tambah_nasabah.jsp" class="btn-tambah">+ Tambah Nasabah</a>
  </div>

  <!-- ============ GRID NASABAH ============ -->
  <div class="nasabah-grid" id="nasabahGrid">
  <%
    boolean adaData = false;
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");

      String sql = "SELECT n.id, n.nama, n.alamat, n.telepon, n.email, " +
                   "COUNT(p.id) AS jml_polis " +
                   "FROM nasabah n " +
                   "LEFT JOIN polis p ON p.nasabah_id = n.id " +
                   "GROUP BY n.id, n.nama, n.alamat, n.telepon, n.email " +
                   "ORDER BY n.id DESC";

      ResultSet rs = c.createStatement().executeQuery(sql);
      while(rs.next()){
        adaData = true;
        int id = rs.getInt("id");
        String nama = rs.getString("nama");
        String alamat = rs.getString("alamat");
        String telepon = rs.getString("telepon");
        String email = rs.getString("email");
        int jmlPolis = rs.getInt("jml_polis");

        // Inisial nama (2 huruf pertama)
        String inisial = "-";
        if(nama != null && nama.length() > 0){
          String[] parts = nama.trim().split("\\s+");
          if(parts.length >= 2)
            inisial = ("" + parts[0].charAt(0) + parts[1].charAt(0)).toUpperCase();
          else
            inisial = nama.substring(0, Math.min(2, nama.length())).toUpperCase();
        }

        String badgeClass = jmlPolis > 0 ? "polis-badge" : "polis-badge polis-badge-kosong";
        String badgeText = jmlPolis > 0 ? jmlPolis + " Polis Aktif" : "Belum ada polis";
  %>
    <div class="nasabah-card" data-nama="<%=nama.toLowerCase()%> <%=email != null ? email.toLowerCase() : ""%> <%=telepon != null ? telepon : ""%>">
      <div class="nasabah-top">
        <div class="avatar"><%=inisial%></div>
        <div>
          <div class="nama"><%=nama%></div>
          <div class="id">ID Nasabah: #<%=id%></div>
        </div>
      </div>
      <div class="nasabah-info">
        <span class="ikon">ALAMAT</span>
        <span><%=alamat != null ? alamat : "-"%></span>
      </div>
      <div class="nasabah-info">
        <span class="ikon">TELP</span>
        <span><%=telepon != null ? telepon : "-"%></span>
      </div>
      <div class="nasabah-info">
        <span class="ikon">EMAIL</span>
        <span><%=email != null ? email : "-"%></span>
      </div>
      <div class="<%=badgeClass%>"><%=badgeText%></div>
      <div class="aksi">
        <button class="btn-detail" onclick="bukaModal(<%=id%>,'<%=nama.replace("'","\\'")%>','<%=alamat != null ? alamat.replace("'","\\'") : "-"%>','<%=telepon != null ? telepon : "-"%>','<%=email != null ? email : "-"%>',<%=jmlPolis%>)">Detail</button>
        <a href="edit_nasabah.jsp?id=<%=id%>" class="btn-edit">Edit</a>
      </div>
    </div>
  <%
      }
      c.close();
    } catch(Exception e) {
      out.println("<div class='kosong'><h3>Error</h3><p>" + e.getMessage() + "</p></div>");
    }

    if(!adaData){
  %>
    <div class="kosong" style="grid-column:1/-1">
      <h3>Belum Ada Data Nasabah</h3>
      <p>Klik tombol "+ Tambah Nasabah" untuk menambahkan data.</p>
    </div>
  <%
    }
  %>
  </div>
</div>

<!-- ============ MODAL DETAIL ============ -->
<div class="modal" id="modalDetail">
  <div class="modal-box">
    <h3>Detail Nasabah</h3>
    <div class="row"><strong>ID</strong> <span id="mId">-</span></div>
    <div class="row"><strong>Nama</strong> <span id="mNama">-</span></div>
    <div class="row"><strong>Alamat</strong> <span id="mAlamat">-</span></div>
    <div class="row"><strong>Telepon</strong> <span id="mTelepon">-</span></div>
    <div class="row"><strong>Email</strong> <span id="mEmail">-</span></div>
    <div class="row"><strong>Jumlah Polis</strong> <span id="mPolis">-</span></div>
    <button class="btn-tutup" onclick="tutupModal()">Tutup</button>
  </div>
</div>

<script>
function filterNasabah(){
  var input = document.getElementById('cari').value.toLowerCase();
  var items = document.querySelectorAll('.nasabah-card');
  items.forEach(function(item){
    var txt = item.getAttribute('data-nama') || '';
    item.style.display = txt.includes(input) ? 'flex' : 'none';
  });
}

function bukaModal(id, nama, alamat, telepon, email, polis){
  document.getElementById('mId').innerText = '#' + id;
  document.getElementById('mNama').innerText = nama;
  document.getElementById('mAlamat').innerText = alamat;
  document.getElementById('mTelepon').innerText = telepon;
  document.getElementById('mEmail').innerText = email;
  document.getElementById('mPolis').innerText = polis + ' polis';
  document.getElementById('modalDetail').classList.add('aktif');
}

function tutupModal(){
  document.getElementById('modalDetail').classList.remove('aktif');
}

document.getElementById('modalDetail').addEventListener('click', function(e){
  if(e.target === this) tutupModal();
});
</script>

<%@ include file="footer.jsp" %>