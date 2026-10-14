<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<style>
  .produk-header {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 30px;
    border-radius: 12px;
    margin-bottom: 20px;
    text-align: center;
  }
  .produk-header h2 {
    color: #fff;
    margin-bottom: 8px;
    font-size: 26px;
  }
  .produk-header p {
    opacity: 0.9;
  }
  .search-box {
    max-width: 400px;
    margin: 0 auto 25px;
    display: flex;
    gap: 10px;
    position: relative;
  }
  .search-box svg {
    position: absolute;
    left: 18px;
    top: 50%;
    transform: translateY(-50%);
    width: 16px;
    height: 16px;
    pointer-events: none;
  }
  .search-box input {
    flex: 1;
    padding: 12px 18px 12px 45px;
    border: 2px solid #e3f2fd;
    border-radius: 25px;
    font-size: 14px;
    outline: none;
    transition: 0.3s;
    width: 100%;
  }
  .search-box input:focus {
    border-color: #1976d2;
    box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
  }
  .produk-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
    gap: 20px;
  }
  .produk-item {
    background: #fff;
    border-radius: 14px;
    padding: 25px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border-top: 5px solid #1976d2;
    position: relative;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
  }
  .produk-item:hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 30px rgba(25, 118, 210, 0.25);
    border-top-color: #ffd54f;
  }
  .produk-badge {
    position: absolute;
    top: -12px;
    right: 20px;
    background: linear-gradient(90deg, #ff6f00, #ffa726);
    color: #fff;
    font-size: 11px;
    font-weight: bold;
    padding: 4px 12px;
    border-radius: 12px;
    letter-spacing: 0.5px;
  }
  .produk-icon {
    width: 60px;
    height: 60px;
    background: #e3f2fd;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 15px;
  }
  .produk-icon svg {
    width: 32px;
    height: 32px;
  }
  .produk-item h3 {
    color: #0d47a1;
    font-size: 20px;
    margin-bottom: 10px;
  }
  .produk-item .harga {
    font-size: 26px;
    font-weight: bold;
    color: #1976d2;
    margin: 10px 0;
  }
  .produk-item .harga span {
    font-size: 13px;
    color: #999;
    font-weight: normal;
  }
  .produk-item .manfaat {
    color: #555;
    font-size: 14px;
    line-height: 1.5;
    margin-bottom: 18px;
    flex: 1;
    display: flex;
    align-items: flex-start;
    gap: 8px;
  }
  .produk-item .manfaat svg {
    width: 16px;
    height: 16px;
    flex-shrink: 0;
    margin-top: 2px;
  }
  .produk-item .aksi {
    display: flex;
    gap: 8px;
  }
  .produk-item .btn-pilih {
    flex: 1;
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 10px 16px;
    border-radius: 20px;
    text-decoration: none;
    text-align: center;
    font-size: 13px;
    font-weight: 600;
    transition: 0.3s;
    border: none;
    cursor: pointer;
  }
  .produk-item .btn-pilih:hover {
    background: #0d47a1;
    box-shadow: 0 4px 12px rgba(13, 71, 161, 0.4);
  }
  .produk-item .btn-detail {
    background: #e3f2fd;
    color: #1976d2;
    padding: 10px 16px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 600;
    transition: 0.3s;
    border: none;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 5px;
  }
  .produk-item .btn-detail:hover {
    background: #bbdefb;
  }
  .produk-item .btn-detail svg {
    width: 13px;
    height: 13px;
  }

  .modal {
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.6);
    z-index: 9999;
    align-items: center;
    justify-content: center;
  }
  .modal.aktif {
    display: flex;
  }
  .modal-box {
    background: #fff;
    padding: 30px;
    border-radius: 15px;
    max-width: 500px;
    width: 90%;
    animation: slideUp 0.3s ease;
  }
  @keyframes slideUp {
    from { transform: translateY(50px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
  }
  .modal-box h3 {
    color: #0d47a1;
    margin-bottom: 15px;
  }
  .modal-box .row {
    margin: 10px 0;
    padding: 10px;
    background: #f5f9ff;
    border-radius: 8px;
    display: flex;
    justify-content: space-between;
  }
  .modal-box .row strong {
    color: #0d47a1;
  }
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
  .modal-box .btn-tutup:hover {
    background: #0d47a1;
  }

  .kosong-produk {
    text-align: center;
    padding: 40px;
    color: #999;
  }
  .kosong-produk svg {
    width: 60px;
    height: 60px;
    margin-bottom: 15px;
  }
</style>

<!-- ============ HEADER PRODUK ============ -->
<div class="container">
  <div class="produk-header">
    <h2>Daftar Produk Asuransi</h2>
    <p>Pilih perlindungan yang paling sesuai dengan kebutuhan keluarga Anda</p>
  </div>

  <div class="search-box">
    <svg viewBox="0 0 24 24" fill="none" stroke="#999" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <circle cx="11" cy="11" r="8"></circle>
      <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
    </svg>
    <input type="text" id="cariProduk" placeholder="Cari produk asuransi..." onkeyup="cariProduk()">
  </div>

  <div class="produk-grid" id="produkGrid">
  <%
    int jumlah = 0;
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
      ResultSet rs = c.createStatement().executeQuery("SELECT * FROM produk ORDER BY id");
      while(rs.next()){
        jumlah++;
        int id = rs.getInt(1);
        String nama = rs.getString(2);
        int premi = rs.getInt(3);
        String manfaat = rs.getString(4);

        // Variasi warna icon (bergantian)
        String[] warna = {"#1976d2", "#ff6f00", "#2e7d32", "#7b1fa2", "#c62828", "#00838f"};
        String warnaIcon = warna[(jumlah-1) % warna.length];

        // Badge unggulan untuk produk pertama
        String badge = (jumlah == 1) ? "TERPOPULER" : "";
  %>
    <div class="produk-item" data-nama="<%=nama.toLowerCase()%>">
      <% if(!badge.isEmpty()){ %><div class="produk-badge"><%=badge%></div><% } %>
      <div class="produk-icon">
        <svg viewBox="0 0 24 24" fill="none" stroke="<%=warnaIcon%>" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
        </svg>
      </div>
      <h3><%=nama%></h3>
      <div class="harga">Rp <%=String.format("%,d", premi)%><span>/tahun</span></div>
      <div class="manfaat">
        <svg viewBox="0 0 24 24" fill="none" stroke="#2e7d32" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
        <%=manfaat%>
      </div>
      <div class="aksi">
        <a href="simulasi.jsp?produk=<%=nama%>&premi=<%=premi%>" class="btn-pilih">Pilih Produk</a>
        <button class="btn-detail" onclick="bukaModal('<%=nama%>','<%=premi%>','<%=manfaat%>')">
          <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
            <circle cx="12" cy="12" r="3"></circle>
          </svg>
          Detail
        </button>
      </div>
    </div>
  <%
      }
      c.close();
    } catch(Exception e) {
      out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
    }
  %>
  </div>

  <% if(jumlah == 0){ %>
    <div class="kosong-produk">
      <svg viewBox="0 0 24 24" fill="none" stroke="#ccc" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
      </svg>
      <h3>Belum Ada Produk</h3>
      <p>Silakan import database terlebih dahulu.</p>
    </div>
  <% } %>
</div>

<!-- ============ MODAL DETAIL ============ -->
<div class="modal" id="modalDetail">
  <div class="modal-box">
    <h3>Detail Produk</h3>
    <div class="row"><strong>Nama</strong> <span id="mNama">-</span></div>
    <div class="row"><strong>Premi</strong> <span id="mPremi">-</span></div>
    <div class="row"><strong>Manfaat</strong> <span id="mManfaat">-</span></div>
    <div class="row"><strong>Periode</strong> <span>1 Tahun</span></div>
    <div class="row"><strong>Pembayaran</strong> <span>Bulanan / Tahunan</span></div>
    <button class="btn-tutup" onclick="tutupModal()">Tutup</button>
  </div>
</div>

<script>
  function cariProduk(){
    var input = document.getElementById('cariProduk').value.toLowerCase();
    var items = document.querySelectorAll('.produk-item');
    items.forEach(function(item){
      var nama = item.getAttribute('data-nama');
      item.style.display = nama.includes(input) ? 'flex' : 'none';
    });
  }

  function bukaModal(nama, premi, manfaat){
    document.getElementById('mNama').innerText = nama;
    document.getElementById('mPremi').innerText = 'Rp ' + parseInt(premi).toLocaleString('id-ID') + '/tahun';
    document.getElementById('mManfaat').innerText = manfaat;
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