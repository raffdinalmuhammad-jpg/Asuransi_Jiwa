<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*, java.text.*, java.util.Locale" %>

<style>
  .klaim-header {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.25);
  }
  .klaim-header h2 { color: #fff; margin-bottom: 8px; font-size: 26px; }
  .klaim-header p { opacity: 0.9; }

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
    width: 55px; height: 55px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
  .stat-card .ikon svg {
    width: 28px;
    height: 28px;
  }
  .stat-card .isi .angka {
    font-size: 20px;
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
    min-width: 220px;
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
  .toolbar input, .toolbar select {
    padding: 12px 18px;
    border: 2px solid #e3f2fd;
    border-radius: 25px;
    font-size: 14px;
    outline: none;
    transition: 0.3s;
    background: #fff;
    width: 100%;
  }
  .toolbar input { padding-left: 45px; }
  .toolbar input:focus, .toolbar select:focus {
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
    display: flex;
    align-items: center;
    gap: 8px;
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
  table { width: 100%; border-collapse: collapse; }
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
  tbody tr { transition: 0.2s; }
  tbody tr:hover { background: #f5f9ff; }

  .no-polis {
    font-family: 'Courier New', monospace;
    font-weight: bold;
    color: #1976d2;
    background: #e3f2fd;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 12px;
  }
  .harga {
    color: #1976d2;
    font-weight: bold;
  }
  .badge {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 5px 12px;
    border-radius: 15px;
    font-size: 12px;
    font-weight: 600;
  }
  .badge svg {
    width: 12px;
    height: 12px;
  }
  .badge-disetujui {
    background: #e8f5e9;
    color: #2e7d32;
  }
  .badge-diproses {
    background: #fff3e0;
    color: #e65100;
  }
  .badge-ditolak {
    background: #ffebee;
    color: #c62828;
  }
  .badge-default {
    background: #e0f7fa;
    color: #00695c;
  }
  .btn-detail {
    background: #e3f2fd;
    color: #1976d2;
    padding: 6px 14px;
    border: none;
    border-radius: 15px;
    font-size: 12px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
    display: inline-flex;
    align-items: center;
    gap: 5px;
  }
  .btn-detail:hover { background: #bbdefb; }
  .btn-detail svg {
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
    padding: 20px;
  }
  .modal.aktif { display: flex; }
  .modal-box {
    background: #fff;
    padding: 30px;
    border-radius: 15px;
    max-width: 500px;
    width: 100%;
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
  <div class="klaim-header">
    <h2>Data Klaim Asuransi</h2>
    <p>Daftar klaim yang diajukan oleh nasabah</p>
  </div>
</div>

<%
  // ====== STATISTIK ======
  int totalKlaim = 0;
  int klaimDisetujui = 0;
  int klaimDiproses = 0;
  int klaimDitolak = 0;
  long totalNilai = 0;

  try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection(
      "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");

    ResultSet r1 = c.createStatement().executeQuery("SELECT COUNT(*) FROM klaim");
    if(r1.next()) totalKlaim = r1.getInt(1);

    ResultSet r2 = c.createStatement().executeQuery(
      "SELECT COUNT(*) FROM klaim WHERE status='Disetujui'");
    if(r2.next()) klaimDisetujui = r2.getInt(1);

    ResultSet r3 = c.createStatement().executeQuery(
      "SELECT COUNT(*) FROM klaim WHERE status='Diproses'");
    if(r3.next()) klaimDiproses = r3.getInt(1);

    ResultSet r4 = c.createStatement().executeQuery(
      "SELECT COUNT(*) FROM klaim WHERE status='Ditolak'");
    if(r4.next()) klaimDitolak = r4.getInt(1);

    ResultSet r5 = c.createStatement().executeQuery(
      "SELECT IFNULL(SUM(jumlah),0) FROM klaim");
    if(r5.next()) totalNilai = r5.getLong(1);

    c.close();
  } catch(Exception e) { /* diamkan */ }
%>

<!-- ============ STATISTIK ============ -->
<div class="container">
  <div class="stat-grid">

    <!-- Total Klaim -->
    <div class="stat-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
          <polyline points="14 2 14 8 20 8"></polyline>
          <line x1="16" y1="13" x2="8" y2="13"></line>
          <line x1="16" y1="17" x2="8" y2="17"></line>
        </svg>
      </div>
      <div class="isi">
        <div class="angka"><%=totalKlaim%></div>
        <div class="label">Total Klaim</div>
      </div>
    </div>

    <!-- Disetujui -->
    <div class="stat-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#2e7d32" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
      </div>
      <div class="isi">
        <div class="angka"><%=klaimDisetujui%></div>
        <div class="label">Disetujui</div>
      </div>
    </div>

    <!-- Diproses -->
    <div class="stat-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#e65100" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <polyline points="12 6 12 12 16 14"></polyline>
        </svg>
      </div>
      <div class="isi">
        <div class="angka"><%=klaimDiproses%></div>
        <div class="label">Diproses</div>
      </div>
    </div>

    <!-- Ditolak -->
    <div class="stat-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#c62828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="15" y1="9" x2="9" y2="15"></line>
          <line x1="9" y1="9" x2="15" y2="15"></line>
        </svg>
      </div>
      <div class="isi">
        <div class="angka"><%=klaimDitolak%></div>
        <div class="label">Ditolak</div>
      </div>
    </div>

  </div>
</div>

<!-- ============ TOOLBAR ============ -->
<div class="container">
  <div class="toolbar">
    <div class="input-wrap">
      <svg viewBox="0 0 24 24" fill="none" stroke="#999" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="11" cy="11" r="8"></circle>
        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
      </svg>
      <input type="text" id="cari" placeholder="Cari no. polis / nama nasabah..." onkeyup="filterTabel()">
    </div>
    <select id="filterStatus" onchange="filterTabel()">
      <option value="">Semua Status</option>
      <option value="disetujui">Disetujui</option>
      <option value="diproses">Diproses</option>
      <option value="ditolak">Ditolak</option>
    </select>
    <a href="tambah_klaim.jsp" class="btn-tambah">
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="3" stroke-linecap="round">
        <line x1="12" y1="5" x2="12" y2="19"></line>
        <line x1="5" y1="12" x2="19" y2="12"></line>
      </svg>
      Ajukan Klaim
    </a>
  </div>

  <!-- ============ TABEL ============ -->
  <div class="tabel-wrap">
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>No. Polis</th>
          <th>Nasabah</th>
          <th>Jumlah Klaim</th>
          <th>Status</th>
          <th>Tanggal</th>
          <th>Aksi</th>
        </tr>
      </thead>
      <tbody id="tabelBody">
      <%
        boolean adaData = false;
        SimpleDateFormat inputFmt = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat outputFmt = new SimpleDateFormat("dd MMM yyyy", new Locale("id","ID"));

        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection c = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");

          String sql = "SELECT k.id, k.jumlah, k.status, k.tanggal, " +
                       "COALESCE(k.keterangan,'-') AS keterangan, " +
                       "COALESCE(p.no_polis,'-') AS no_polis, " +
                       "COALESCE(n.nama,'-') AS nama_nasabah " +
                       "FROM klaim k " +
                       "LEFT JOIN polis p ON k.polis_id = p.id " +
                       "LEFT JOIN nasabah n ON p.nasabah_id = n.id " +
                       "ORDER BY k.tanggal DESC";

          ResultSet rs = c.createStatement().executeQuery(sql);
          while(rs.next()){
            adaData = true;
            int id = rs.getInt("id");
            long jumlah = rs.getLong("jumlah");
            String status = rs.getString("status");
            String tgl = rs.getString("tanggal");
            String keterangan = rs.getString("keterangan");
            String noPolis = rs.getString("no_polis");
            String namaNasabah = rs.getString("nama_nasabah");

            // Format tanggal Indonesia
            String tglFormatted = tgl;
            try {
              if(tgl != null && tgl.length() >= 10){
                java.util.Date d = inputFmt.parse(tgl.substring(0,10));
                tglFormatted = outputFmt.format(d);
              }
            } catch(Exception ex){ /* diamkan */ }

            // Badge class & SVG icon
            String badgeClass = "badge-default";
            String svgIcon = "";
            if("Disetujui".equalsIgnoreCase(status)){
              badgeClass = "badge-disetujui";
              svgIcon = "<svg viewBox='0 0 24 24' fill='none' stroke='#2e7d32' stroke-width='3' stroke-linecap='round' stroke-linejoin='round'><polyline points='20 6 9 17 4 12'></polyline></svg>";
            } else if("Diproses".equalsIgnoreCase(status)){
              badgeClass = "badge-diproses";
              svgIcon = "<svg viewBox='0 0 24 24' fill='none' stroke='#e65100' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><circle cx='12' cy='12' r='10'></circle><polyline points='12 6 12 12 16 14'></polyline></svg>";
            } else if("Ditolak".equalsIgnoreCase(status)){
              badgeClass = "badge-ditolak";
              svgIcon = "<svg viewBox='0 0 24 24' fill='none' stroke='#c62828' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><circle cx='12' cy='12' r='10'></circle><line x1='15' y1='9' x2='9' y2='15'></line><line x1='9' y1='9' x2='15' y2='15'></line></svg>";
            } else {
              svgIcon = "<svg viewBox='0 0 24 24' fill='none' stroke='#00695c' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><circle cx='12' cy='12' r='10'></circle><line x1='12' y1='8' x2='12' y2='12'></line><line x1='12' y1='16' x2='12.01' y2='16'></line></svg>";
            }

            String nasabahJs = namaNasabah.replace("'", "\\'").replace("\"", "\\\"");
            String ketJs = keterangan.replace("'", "\\'").replace("\"", "\\\"");
      %>
        <tr data-nama="<%=noPolis.toLowerCase()%> <%=namaNasabah.toLowerCase()%>" data-status="<%=status.toLowerCase()%>">
          <td><b>#<%=id%></b></td>
          <td><span class="no-polis"><%=noPolis%></span></td>
          <td><b><%=namaNasabah%></b></td>
          <td class="harga">Rp <%=String.format("%,d", jumlah)%></td>
          <td><span class="badge <%=badgeClass%>"><%=svgIcon%> <%=status%></span></td>
          <td><%=tglFormatted%></td>
          <td>
            <button class="btn-detail" onclick="bukaModal('<%=noPolis%>','<%=nasabahJs%>','<%=jumlah%>','<%=status%>','<%=tglFormatted%>','<%=ketJs%>')">
              <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                <circle cx="12" cy="12" r="3"></circle>
              </svg>
              Detail
            </button>
          </td>
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
            <h3>Belum Ada Data Klaim</h3>
            <p>Klik tombol "Ajukan Klaim" untuk mengajukan klaim baru.</p>
          </td>
        </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</div>

<!-- ============ MODAL DETAIL ============ -->
<div class="modal" id="modalDetail">
  <div class="modal-box">
    <h3>Detail Klaim</h3>
    <div class="row"><strong>No. Polis</strong> <span id="mNo">-</span></div>
    <div class="row"><strong>Nasabah</strong> <span id="mNasabah">-</span></div>
    <div class="row"><strong>Jumlah Klaim</strong> <span id="mJumlah">-</span></div>
    <div class="row"><strong>Status</strong> <span id="mStatus">-</span></div>
    <div class="row"><strong>Tanggal</strong> <span id="mTanggal">-</span></div>
    <div class="row"><strong>Keterangan</strong> <span id="mKet">-</span></div>
    <button class="btn-tutup" onclick="tutupModal()">Tutup</button>
  </div>
</div>

<script>
function filterTabel(){
  var input = document.getElementById('cari').value.toLowerCase();
  var status = document.getElementById('filterStatus').value.toLowerCase();
  var rows = document.querySelectorAll('#tabelBody tr');

  rows.forEach(function(row){
    var txt = row.getAttribute('data-nama') || '';
    var st = row.getAttribute('data-status') || '';
    var cocokNama = txt.includes(input);
    var cocokStatus = status === '' || st === status;
    row.style.display = (cocokNama && cocokStatus) ? '' : 'none';
  });
}

function bukaModal(no, nasabah, jumlah, status, tanggal, ket){
  document.getElementById('mNo').innerText = no;
  document.getElementById('mNasabah').innerText = nasabah;
  document.getElementById('mJumlah').innerText = 'Rp ' + parseInt(jumlah).toLocaleString('id-ID');
  document.getElementById('mStatus').innerText = status;
  document.getElementById('mTanggal').innerText = tanggal;
  document.getElementById('mKet').innerText = ket;
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