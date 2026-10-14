<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<style>
  .sim-hero {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 40px;
    border-radius: 15px;
    text-align: center;
    margin-bottom: 30px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.25);
  }
  .sim-hero h2 { color: #fff; font-size: 30px; margin-bottom: 10px; }
  .sim-hero p { opacity: 0.95; font-size: 16px; }

  .sim-wrapper {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 25px;
    margin-bottom: 30px;
  }
  @media(max-width: 900px){
    .sim-wrapper { grid-template-columns: 1fr; }
  }

  .sim-card {
    background: #fff;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
  }
  .sim-card h3 {
    color: #0d47a1;
    margin-bottom: 20px;
    font-size: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
    padding-bottom: 15px;
    border-bottom: 2px solid #e3f2fd;
  }
  .sim-card h3 svg {
    width: 24px;
    height: 24px;
  }

  .form-group {
    margin-bottom: 18px;
  }
  .form-group label {
    display: block;
    color: #333;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 14px;
  }
  .form-group input,
  .form-group select {
    width: 100%;
    padding: 13px 15px;
    border: 2px solid #e3f2fd;
    border-radius: 10px;
    font-size: 14px;
    font-family: inherit;
    outline: none;
    transition: 0.3s;
    background: #fafcff;
  }
  .form-group input:focus,
  .form-group select:focus {
    border-color: #1976d2;
    background: #fff;
    box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
  }

  .btn-hitung {
    width: 100%;
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 15px;
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
    margin-top: 10px;
  }
  .btn-hitung:hover {
    background: #0d47a1;
    box-shadow: 0 6px 20px rgba(13, 71, 161, 0.4);
    transform: translateY(-2px);
  }
  .btn-hitung svg {
    width: 18px;
    height: 18px;
  }

  /* Hasil panel */
  .hasil-panel {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.3);
    min-height: 400px;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  .hasil-panel h3 {
    color: #fff;
    margin-bottom: 20px;
    font-size: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .hasil-panel h3 svg {
    width: 24px;
    height: 24px;
  }

  .hasil-kosong {
    text-align: center;
    padding: 40px 20px;
    opacity: 0.85;
  }
  .hasil-kosong svg {
    width: 80px;
    height: 80px;
    margin-bottom: 15px;
    opacity: 0.5;
  }
  .hasil-kosong p {
    font-size: 15px;
    line-height: 1.6;
  }

  .hasil-total {
    background: rgba(255,255,255,0.15);
    padding: 25px;
    border-radius: 12px;
    text-align: center;
    margin-bottom: 20px;
    border: 2px solid rgba(255,255,255,0.3);
  }
  .hasil-total .label {
    font-size: 13px;
    opacity: 0.9;
    margin-bottom: 8px;
    text-transform: uppercase;
    letter-spacing: 1px;
  }
  .hasil-total .angka {
    font-size: 38px;
    font-weight: bold;
    color: #ffd54f;
    line-height: 1;
  }
  .hasil-total .periode {
    font-size: 13px;
    opacity: 0.9;
    margin-top: 5px;
  }

  .hasil-detail {
    background: rgba(255,255,255,0.1);
    padding: 15px;
    border-radius: 10px;
    margin-bottom: 15px;
  }
  .hasil-detail .row {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    font-size: 14px;
    border-bottom: 1px dashed rgba(255,255,255,0.2);
  }
  .hasil-detail .row:last-child { border-bottom: none; }
  .hasil-detail .row .label { opacity: 0.9; }
  .hasil-detail .row .nilai { font-weight: bold; }

  .hasil-bulanan {
    background: rgba(255, 213, 79, 0.2);
    border: 1px solid #ffd54f;
    padding: 12px 15px;
    border-radius: 10px;
    margin-bottom: 15px;
    text-align: center;
  }
  .hasil-bulanan .label { font-size: 12px; opacity: 0.9; }
  .hasil-bulanan .angka {
    font-size: 22px;
    font-weight: bold;
    color: #ffd54f;
  }

  .btn-konsul {
    background: #ffd54f;
    color: #0d47a1;
    padding: 12px 20px;
    border-radius: 25px;
    text-decoration: none;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
    transition: 0.3s;
    font-size: 14px;
  }
  .btn-konsul:hover {
    background: #fff;
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0,0,0,0.2);
  }
  .btn-konsul svg {
    width: 16px;
    height: 16px;
  }

  .info-tambahan {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }
  .info-box {
    background: #fff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
    border-left: 4px solid #1976d2;
    display: flex;
    gap: 12px;
    align-items: flex-start;
  }
  .info-box .ikon {
    width: 40px;
    height: 40px;
    background: #e3f2fd;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
  .info-box .ikon svg {
    width: 20px;
    height: 20px;
  }
  .info-box .isi h4 {
    color: #0d47a1;
    font-size: 14px;
    margin-bottom: 4px;
  }
  .info-box .isi p {
    color: #666;
    font-size: 13px;
    line-height: 1.5;
  }
</style>

<!-- ============ HERO ============ -->
<div class="container">
  <div class="sim-hero">
    <h2>Simulasi Premi Asuransi</h2>
    <p>Hitung estimasi premi sesuai usia dan produk pilihan Anda</p>
  </div>
</div>

<!-- ============ INFO TAMBAHAN ============ -->
<div class="container">
  <div class="info-tambahan">
    <div class="info-box">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
        </svg>
      </div>
      <div class="isi">
        <h4>Proses Cepat</h4>
        <p>Hasil simulasi keluar dalam hitungan detik</p>
      </div>
    </div>
    <div class="info-box">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
          <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
        </svg>
      </div>
      <div class="isi">
        <h4>Akurat & Aman</h4>
        <p>Perhitungan berdasarkan standar industri asuransi</p>
      </div>
    </div>
    <div class="info-box">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <circle cx="12" cy="12" r="6"></circle>
          <circle cx="12" cy="12" r="2"></circle>
        </svg>
      </div>
      <div class="isi">
        <h4>Tanpa Biaya</h4>
        <p>Simulasi gratis, tanpa komitmen apapun</p>
      </div>
    </div>
  </div>
</div>

<!-- ============ FORM SIMULASI ============ -->
<div class="container">
  <div class="sim-wrapper">

    <!-- FORM INPUT -->
    <div class="sim-card">
      <h3>
        <svg viewBox="0 0 24 24" fill="none" stroke="#0d47a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="4" y="2" width="16" height="20" rx="2"></rect>
          <line x1="8" y1="6" x2="16" y2="6"></line>
          <line x1="8" y1="10" x2="16" y2="10"></line>
          <line x1="8" y1="14" x2="12" y2="14"></line>
        </svg>
        Isi Data Simulasi
      </h3>

      <form onsubmit="event.preventDefault();hitung()">
        <div class="form-group">
          <label>Nama Produk</label>
          <input type="text" id="produk" 
                 value="<%= request.getParameter("produk") != null ? request.getParameter("produk") : "Asuransi Sejahtera" %>"
                 placeholder="Contoh: Asuransi Sejahtera">
        </div>

        <div class="form-group">
          <label>Usia Anda (tahun)</label>
          <input type="number" id="u" required min="17" max="70" 
                 placeholder="Contoh: 30">
        </div>

        <div class="form-group">
          <label>Premi Dasar (Rp/tahun)</label>
          <input type="number" id="p" required min="100000"
                 value="<%= request.getParameter("premi") != null ? request.getParameter("premi") : "500000" %>"
                 placeholder="Contoh: 500000">
        </div>

        <button type="submit" class="btn-hitung">
          <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="4" y="2" width="16" height="20" rx="2"></rect>
            <line x1="8" y1="6" x2="16" y2="6"></line>
            <line x1="8" y1="10" x2="16" y2="10"></line>
          </svg>
          Hitung Premi
        </button>
      </form>
    </div>

    <!-- HASIL -->
    <div class="hasil-panel" id="hasilPanel">
      <h3>
        <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="20" x2="18" y2="10"></line>
          <line x1="12" y1="20" x2="12" y2="4"></line>
          <line x1="6" y1="20" x2="6" y2="14"></line>
        </svg>
        Hasil Simulasi
      </h3>

      <div class="hasil-kosong" id="hasilKosong">
        <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="8" x2="12" y2="12"></line>
          <line x1="12" y1="16" x2="12.01" y2="16"></line>
        </svg>
        <p><b>Belum ada hasil</b></p>
        <p>Isi form di samping dan klik <b>Hitung Premi</b> untuk melihat estimasi premi Anda.</p>
      </div>

      <div id="hasilIsi" style="display:none"></div>
    </div>

  </div>
</div>

<script>
function hitung(){
  var u = +document.getElementById('u').value;
  var p = +document.getElementById('p').value;
  var produk = document.getElementById('produk').value || 'Asuransi Jiwa';

  // Validasi
  if(u < 17 || u > 70){
    alert('Usia harus antara 17-70 tahun!');
    return;
  }
  if(p < 100000){
    alert('Premi dasar minimal Rp 100.000!');
    return;
  }

  // Faktor usia bertingkat
  var faktor = 1.0;
  var kategori = 'Standar';
  if(u <= 25){ faktor = 0.9; kategori = 'Muda (diskon 10%)'; }
  else if(u <= 40){ faktor = 1.0; kategori = 'Dewasa (normal)'; }
  else if(u <= 55){ faktor = 1.2; kategori = 'Menengah (+20%)'; }
  else { faktor = 1.5; kategori = 'Senior (+50%)'; }

  var total = Math.round(p * faktor);
  var totalBulanan = Math.round(total / 12);
  var selisih = total - p;

  // Tampilkan
  document.getElementById('hasilKosong').style.display = 'none';
  document.getElementById('hasilIsi').style.display = 'block';

  document.getElementById('hasilIsi').innerHTML =
    '<div class="hasil-total">' +
      '<div class="label">Total Premi Tahunan</div>' +
      '<div class="angka">Rp ' + total.toLocaleString('id-ID') + '</div>' +
      '<div class="periode">untuk produk <b>' + produk + '</b></div>' +
    '</div>' +
    '<div class="hasil-bulanan">' +
      '<div class="label">Atau setara</div>' +
      '<div class="angka">Rp ' + totalBulanan.toLocaleString('id-ID') + ' /bulan</div>' +
    '</div>' +
    '<div class="hasil-detail">' +
      '<div class="row"><span class="label">Premi Dasar</span><span class="nilai">Rp ' + p.toLocaleString('id-ID') + '</span></div>' +
      '<div class="row"><span class="label">Kategori Usia</span><span class="nilai">' + kategori + '</span></div>' +
      '<div class="row"><span class="label">Faktor Usia</span><span class="nilai">' + faktor + 'x</span></div>' +
      '<div class="row"><span class="label">Selisih</span><span class="nilai">Rp ' + selisih.toLocaleString('id-ID') + '</span></div>' +
      '<div class="row"><span class="label">Usia Anda</span><span class="nilai">' + u + ' tahun</span></div>' +
    '</div>' +
    '<a href="kontak.jsp" class="btn-konsul">' +
      '<svg viewBox="0 0 24 24" fill="none" stroke="#0d47a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">' +
        '<path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>' +
      '</svg>' +
      'Konsultasi dengan Agen' +
    '</a>';
}
</script>

<%@ include file="footer.jsp" %>