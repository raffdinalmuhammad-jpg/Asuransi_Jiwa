<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<style>
  .form-header {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.25);
  }
  .form-header h2 { color: #fff; margin-bottom: 8px; font-size: 26px; }
  .form-header p { opacity: 0.9; }

  .form-card {
    background: #fff;
    padding: 35px;
    border-radius: 14px;
    box-shadow: 0 6px 25px rgba(0,0,0,0.08);
    max-width: 700px;
    margin: 0 auto;
  }

  .form-group {
    margin-bottom: 20px;
  }
  .form-group label {
    display: block;
    color: #0d47a1;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 14px;
  }
  .form-group label .wajib { color: #e53935; }
  .form-group input,
  .form-group select,
  .form-group textarea {
    width: 100%;
    padding: 13px 16px;
    border: 2px solid #e3f2fd;
    border-radius: 10px;
    font-size: 14px;
    font-family: inherit;
    outline: none;
    transition: 0.3s;
    background: #fafcff;
    box-sizing: border-box;
  }
  .form-group input:focus,
  .form-group select:focus,
  .form-group textarea:focus {
    border-color: #1976d2;
    background: #fff;
    box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
  }
  .form-group textarea {
    resize: vertical;
    min-height: 90px;
  }

  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
  }
  @media(max-width:600px){
    .form-row { grid-template-columns: 1fr; }
  }

  .info-box {
    background: linear-gradient(135deg, #e3f2fd, #f0f7ff);
    padding: 15px 20px;
    border-radius: 10px;
    border-left: 4px solid #1976d2;
    margin-bottom: 25px;
    font-size: 13px;
    color: #0d47a1;
    display: flex;
    align-items: flex-start;
    gap: 12px;
  }
  .info-box svg {
    width: 20px;
    height: 20px;
    flex-shrink: 0;
    margin-top: 2px;
  }

  .form-aksi {
    display: flex;
    gap: 12px;
    margin-top: 25px;
  }
  .btn-simpan {
    flex: 2;
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 14px;
    border: none;
    border-radius: 25px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
  }
  .btn-simpan:hover {
    background: #0d47a1;
    box-shadow: 0 6px 15px rgba(13, 71, 161, 0.4);
    transform: translateY(-2px);
  }
  .btn-simpan svg { width: 16px; height: 16px; }
  .btn-batal {
    flex: 1;
    background: #f5f5f5;
    color: #666;
    padding: 14px;
    border-radius: 25px;
    text-decoration: none;
    font-size: 15px;
    font-weight: 600;
    text-align: center;
    transition: 0.3s;
  }
  .btn-batal:hover {
    background: #eeeeee;
    color: #333;
  }

  .alert-error {
    background: #ffebee;
    color: #c62828;
    padding: 15px;
    border-radius: 10px;
    border-left: 5px solid #f44336;
    margin-bottom: 20px;
    font-size: 14px;
  }
</style>

<!-- ============ HEADER ============ -->
<div class="container">
  <div class="form-header">
    <h2>Ajukan Klaim Baru</h2>
    <p>Lengkapi data klaim di bawah ini</p>
  </div>

  <%
    String err = request.getParameter("err");
    if(err != null){
  %>
    <div class="alert-error" style="max-width:700px;margin:0 auto 20px">
      <b>Gagal mengajukan klaim.</b>
      <% if("db".equals(err)){ %>Terjadi error pada database.<% } %>
      <% if("kosong".equals(err)){ %>Data wajib belum lengkap.<% } %>
    </div>
  <%
    }
  %>

  <div class="info-box" style="max-width:700px;margin:0 auto 25px">
    <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <circle cx="12" cy="12" r="10"></circle>
      <line x1="12" y1="8" x2="12" y2="12"></line>
      <line x1="12" y1="16" x2="12.01" y2="16"></line>
    </svg>
    <div>
      <b>Info:</b> Field dengan tanda <span style="color:#e53935">*</span> wajib diisi.
      Klaim akan berstatus <b>"Diproses"</b> sampai diverifikasi oleh admin.
    </div>
  </div>

  <!-- ============ FORM ============ -->
  <div class="form-card">
    <form action="simpan_klaim.jsp" method="post" onsubmit="return validasi()">

      <!-- No. Polis -->
      <div class="form-group">
        <label>No. Polis <span class="wajib">*</span></label>
        <select name="polis_id" id="polis_id" required>
          <option value="">-- Pilih Polis --</option>
          <%
            try {
              Class.forName("com.mysql.jdbc.Driver");
              Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
              String sql = "SELECT p.id, p.no_polis, n.nama " +
                           "FROM polis p " +
                           "LEFT JOIN nasabah n ON p.nasabah_id = n.id " +
                           "WHERE p.status='Aktif' " +
                           "ORDER BY p.no_polis";
              ResultSet rs = c.createStatement().executeQuery(sql);
              while(rs.next()){
          %>
            <option value="<%=rs.getInt("id")%>">
              <%=rs.getString("no_polis")%> — <%=rs.getString("nama") != null ? rs.getString("nama") : "-"%>
            </option>
          <%
              }
              c.close();
            } catch(Exception e) {
              out.println("<option value=''>Error: " + e.getMessage() + "</option>");
            }
          %>
        </select>
      </div>

      <!-- Jumlah Klaim -->
      <div class="form-group">
        <label>Jumlah Klaim (Rp) <span class="wajib">*</span></label>
        <input type="number" name="jumlah" id="jumlah" required
               min="100000" step="50000"
               placeholder="Contoh: 5000000">
      </div>

      <!-- Tanggal -->
      <div class="form-row">
        <div class="form-group">
          <label>Tanggal Klaim <span class="wajib">*</span></label>
          <input type="date" name="tanggal" id="tanggal" required>
        </div>
        <div class="form-group">
          <label>Status Awal</label>
          <select name="status" id="status">
            <option value="Diproses">Diproses</option>
            <option value="Disetujui">Disetujui</option>
            <option value="Ditolak">Ditolak</option>
          </select>
        </div>
      </div>

      <!-- Keterangan -->
      <div class="form-group">
        <label>Keterangan / Alasan Klaim <span class="wajib">*</span></label>
        <textarea name="keterangan" id="keterangan" required
                  placeholder="Contoh: Klaim rawat inap rumah sakit selama 3 hari..."></textarea>
      </div>

      <!-- Aksi -->
      <div class="form-aksi">
        <a href="klaim.jsp" class="btn-batal">Batal</a>
        <button type="submit" class="btn-simpan">
          <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path>
            <polyline points="17 21 17 13 7 13 7 21"></polyline>
            <polyline points="7 3 7 8 15 8"></polyline>
          </svg>
          Simpan Klaim
        </button>
      </div>
    </form>
  </div>
</div>

<script>
  // Set tanggal hari ini secara default
  window.addEventListener('DOMContentLoaded', function(){
    var tgl = document.getElementById('tanggal');
    if(!tgl.value){
      var d = new Date();
      var bulan = ('0' + (d.getMonth()+1)).slice(-2);
      var hari = ('0' + d.getDate()).slice(-2);
      tgl.value = d.getFullYear() + '-' + bulan + '-' + hari;
    }
  });

  function validasi(){
    var polis = document.getElementById('polis_id').value;
    var jumlah = +document.getElementById('jumlah').value;
    var tanggal = document.getElementById('tanggal').value;
    var ket = document.getElementById('keterangan').value.trim();

    if(!polis){
      alert('Pilih polis terlebih dahulu!');
      return false;
    }
    if(jumlah < 100000){
      alert('Jumlah klaim minimal Rp 100.000!');
      return false;
    }
    if(!tanggal){
      alert('Tanggal klaim wajib diisi!');
      return false;
    }
    if(ket.length < 10){
      alert('Keterangan minimal 10 karakter!');
      return false;
    }
    return true;
  }
</script>

<%@ include file="footer.jsp" %>