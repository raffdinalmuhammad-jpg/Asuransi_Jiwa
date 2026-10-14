<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<style>
  .pembayaran-header {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.25);
  }
  .pembayaran-header h2 {
    color: #fff;
    margin-bottom: 8px;
    font-size: 26px;
  }
  .pembayaran-header p { opacity: 0.9; }

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
    background: #e3f2fd;
    width: 60px;
    height: 60px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
  .stat-card .ikon svg {
    width: 30px;
    height: 30px;
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
  .toolbar .input-wrap {
    position: relative;
    flex: 1;
    min-width: 250px;
  }
  .toolbar .input-wrap svg {
    position: absolute;
    left: 18px;
    top: 50%;
    transform: translateY(-50%);
    width: 16px;
    height: 16px;
    pointer-events: none;
  }
  .toolbar input {
    width: 100%;
    padding: 12px 18px 12px 45px;
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
    display: flex;
    align-items: center;
    gap: 8px;
    white-space: nowrap;
  }
  .toolbar .btn-tambah:hover {
    background: #0d47a1;
    box-shadow: 0 4px 12px rgba(13, 71, 161, 0.4);
  }
  .toolbar .btn-tambah svg {
    width: 14px;
    height: 14px;
  }

  .tabel-wrap {
    background: #fff;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
  }
  table {
    width: 100%;
    border-collapse: collapse;
  }
  thead {
    background: linear-gradient(90deg, #0d47a1, #1976d2);
    color: #fff;
  }
  th {
    padding: 15px;
    text-align: left;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }
  td {
    padding: 15px;
    border-bottom: 1px solid #eee;
    font-size: 14px;
  }
  tbody tr {
    transition: 0.2s;
  }
  tbody tr:hover {
    background: #f5f9ff;
  }
  .no-polis {
    font-family: 'Courier New', monospace;
    font-weight: bold;
    color: #1976d2;
    background: #e3f2fd;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
  }
  .jumlah {
    font-weight: bold;
    color: #1976d2;
  }
  .badge {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 4px 12px;
    border-radius: 15px;
    font-size: 12px;
    font-weight: 600;
  }
  .badge svg {
    width: 11px;
    height: 11px;
  }
  .badge-lunas {
    background: #e8f5e9;
    color: #2e7d32;
  }
  .badge-pending {
    background: #fff3e0;
    color: #e65100;
  }
  .badge-transfer {
    background: #e3f2fd;
    color: #1976d2;
  }
  .badge-tunai {
    background: #f3e5f5;
    color: #7b1fa2;
  }
  .badge-va {
    background: #e0f7fa;
    color: #00695c;
  }
  .kosong {
    text-align: center;
    padding: 50px 20px;
    color: #999;
  }
  .kosong .ikon {
    margin-bottom: 15px;
  }
  .kosong .ikon svg {
    width: 60px;
    height: 60px;
  }
</style>

<!-- ============ HEADER ============ -->
<div class="container">
  <div class="pembayaran-header">
    <h2>Riwayat Pembayaran Premi</h2>
    <p>Daftar transaksi pembayaran premi asuransi nasabah</p>
  </div>
</div>

<%
  // ====== AMBIL STATISTIK ======
  int totalTransaksi = 0;
  long totalPendapatan = 0;
  int totalLunas = 0;
  int totalPending = 0;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection(
      "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");

    ResultSet r1 = c.createStatement().executeQuery("SELECT COUNT(*) FROM pembayaran");
    if(r1.next()) totalTransaksi = r1.getInt(1);

    ResultSet r2 = c.createStatement().executeQuery("SELECT IFNULL(SUM(jumlah),0) FROM pembayaran");
    if(r2.next()) totalPendapatan = r2.getLong(1);

    ResultSet r3 = c.createStatement().executeQuery(
      "SELECT COUNT(*) FROM pembayaran WHERE status='Lunas'");
    if(r3.next()) totalLunas = r3.getInt(1);

    ResultSet r4 = c.createStatement().executeQuery(
      "SELECT COUNT(*) FROM pembayaran WHERE status='Pending'");
    if(r4.next()) totalPending = r4.getInt(1);

    c.close();
  } catch(Exception e) { /* diamkan */ }
%>

<!-- ============ STATISTIK ============ -->
<div class="container">
  <div class="stat-grid">

    <!-- Total Transaksi -->
    <div class="stat-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
          <line x1="1" y1="10" x2="23" y2="10"></line>
        </svg>
      </div>
      <div class="isi">
        <div class="angka"><%=totalTransaksi%></div>
        <div class="label">Total Transaksi</div>
      </div>
    </div>

    <!-- Total Pendapatan -->
    <div class="stat-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#2e7d32" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="12" y1="1" x2="12" y2="23"></line>
          <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
        </svg>
      </div>
      <div class="isi">
        <div class="angka">Rp <%=String.format("%,d", totalPendapatan)%></div>
        <div class="label">Total Pendapatan</div>
      </div>
    </div>

    <!-- Lunas -->
    <div class="stat-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#2e7d32" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
      </div>
      <div class="isi">
        <div class="angka"><%=totalLunas%></div>
        <div class="label">Lunas</div>
      </div>
    </div>

    <!-- Pending -->
    <div class="stat-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#e65100" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <polyline points="12 6 12 12 16 14"></polyline>
        </svg>
      </div>
      <div class="isi">
        <div class="angka"><%=totalPending%></div>
        <div class="label">Pending</div>
      </div>
    </div>

  </div>
</div>

<!-- ============ TOOLBAR & TABEL ============ -->
<div class="container">
  <div class="toolbar">
    <div class="input-wrap">
      <svg viewBox="0 0 24 24" fill="none" stroke="#999" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="11" cy="11" r="8"></circle>
        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
      </svg>
      <input type="text" id="cari" placeholder="Cari berdasarkan nama nasabah..." onkeyup="filterTabel()">
    </div>
    <a href="tambah_pembayaran.jsp" class="btn-tambah">
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="3" stroke-linecap="round">
        <line x1="12" y1="5" x2="12" y2="19"></line>
        <line x1="5" y1="12" x2="19" y2="12"></line>
      </svg>
      Tambah Pembayaran
    </a>
  </div>

  <div class="tabel-wrap">
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>No. Polis</th>
          <th>Nasabah</th>
          <th>Jumlah</th>
          <th>Metode</th>
          <th>Tanggal</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody id="tabelBody">
      <%
        boolean adaData = false;
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection c = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");

          String sql = "SELECT p.id, p.polis_id, p.jumlah, p.tanggal, " +
                       "COALESCE(p.metode,'Transfer') AS metode, " +
                       "COALESCE(p.status,'Lunas') AS status, " +
                       "COALESCE(pl.no_polis,'-') AS no_polis, " +
                       "COALESCE(n.nama,'-') AS nama_nasabah " +
                       "FROM pembayaran p " +
                       "LEFT JOIN polis pl ON p.polis_id = pl.id " +
                       "LEFT JOIN nasabah n ON pl.nasabah_id = n.id " +
                       "ORDER BY p.tanggal DESC";

          ResultSet rs = c.createStatement().executeQuery(sql);
          while(rs.next()){
            adaData = true;
            int id = rs.getInt("id");
            long jumlah = rs.getLong("jumlah");
            String tgl = rs.getString("tanggal");
            String metode = rs.getString("metode");
            String status = rs.getString("status");
            String noPolis = rs.getString("no_polis");
            String namaNasabah = rs.getString("nama_nasabah");

            // Badge class + SVG icon
            String badgeStatus = "Lunas".equalsIgnoreCase(status) ? "badge-lunas" : "badge-pending";
            String svgStatus = "";
            if("Lunas".equalsIgnoreCase(status)){
              svgStatus = "<svg viewBox='0 0 24 24' fill='none' stroke='#2e7d32' stroke-width='3' stroke-linecap='round' stroke-linejoin='round'><polyline points='20 6 9 17 4 12'></polyline></svg>";
            } else {
              svgStatus = "<svg viewBox='0 0 24 24' fill='none' stroke='#e65100' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><circle cx='12' cy='12' r='10'></circle><polyline points='12 6 12 12 16 14'></polyline></svg>";
            }

            String badgeMetode = "badge-transfer";
            String svgMetode = "";
            if("Tunai".equalsIgnoreCase(metode)){
              badgeMetode = "badge-tunai";
              svgMetode = "<svg viewBox='0 0 24 24' fill='none' stroke='#7b1fa2' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><line x1='12' y1='1' x2='12' y2='23'></line><path d='M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6'></path></svg>";
            } else if(metode.contains("Virtual")){
              badgeMetode = "badge-va";
              svgMetode = "<svg viewBox='0 0 24 24' fill='none' stroke='#00695c' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><rect x='2' y='4' width='20' height='16' rx='2'></rect><line x1='2' y1='10' x2='22' y2='10'></line></svg>";
            } else {
              svgMetode = "<svg viewBox='0 0 24 24' fill='none' stroke='#1976d2' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><polyline points='17 1 21 5 17 9'></polyline><path d='M3 11V9a4 4 0 0 1 4-4h14'></path><polyline points='7 23 3 19 7 15'></polyline><path d='M21 13v2a4 4 0 0 1-4 4H3'></path></svg>";
            }
      %>
        <tr data-nama="<%=namaNasabah.toLowerCase()%>">
          <td><b>#<%=id%></b></td>
          <td><span class="no-polis"><%=noPolis%></span></td>
          <td><b><%=namaNasabah%></b></td>
          <td class="jumlah">Rp <%=String.format("%,d", jumlah)%></td>
          <td><span class="badge <%=badgeMetode%>"><%=svgMetode%> <%=metode%></span></td>
          <td><%=tgl%></td>
          <td><span class="badge <%=badgeStatus%>"><%=svgStatus%> <%=status%></span></td>
        </tr>
      <%
          }
          c.close();
        } catch(Exception e) {
          out.println("<tr><td colspan='7' style='color:red;text-align:center;padding:20px'>Error: " + e.getMessage() + "</td></tr>");
        }

        if(!adaData){
      %>
        <tr>
          <td colspan="7" class="kosong">
            <div class="ikon">
              <svg viewBox="0 0 24 24" fill="none" stroke="#ccc" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
              </svg>
            </div>
            <h3>Belum Ada Data Pembayaran</h3>
            <p>Data akan muncul setelah nasabah melakukan pembayaran premi.</p>
          </td>
        </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</div>

<script>
function filterTabel(){
  var input = document.getElementById('cari').value.toLowerCase();
  var rows = document.querySelectorAll('#tabelBody tr');
  rows.forEach(function(row){
    var nama = row.getAttribute('data-nama') || '';
    row.style.display = nama.includes(input) ? '' : 'none';
  });
}
</script>

<%@ include file="footer.jsp" %>