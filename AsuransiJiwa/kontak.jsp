<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<style>
  .kontak-hero {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 40px;
    border-radius: 15px;
    text-align: center;
    margin-bottom: 30px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.25);
  }
  .kontak-hero h2 {
    color: #fff;
    font-size: 30px;
    margin-bottom: 10px;
  }
  .kontak-hero p {
    opacity: 0.95;
    font-size: 16px;
  }

  .info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }
  .info-card {
    background: #fff;
    padding: 25px 20px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border-top: 4px solid #1976d2;
    transition: 0.3s;
  }
  .info-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(25, 118, 210, 0.2);
  }
  .info-card .ikon {
    width: 60px;
    height: 60px;
    background: #e3f2fd;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 12px;
  }
  .info-card .ikon svg {
    width: 28px;
    height: 28px;
  }
  .info-card h3 {
    color: #0d47a1;
    font-size: 16px;
    margin-bottom: 8px;
  }
  .info-card p {
    color: #555;
    font-size: 14px;
    line-height: 1.6;
  }

  .kontak-wrapper {
    display: grid;
    grid-template-columns: 1.2fr 1fr;
    gap: 25px;
    margin-bottom: 30px;
  }
  @media(max-width: 768px){
    .kontak-wrapper { grid-template-columns: 1fr; }
  }

  .form-kontak {
    background: #fff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
  }
  .form-kontak h3 {
    color: #0d47a1;
    margin-bottom: 20px;
    font-size: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .form-kontak h3 svg {
    width: 22px;
    height: 22px;
  }
  .form-group {
    margin-bottom: 15px;
  }
  .form-group label {
    display: block;
    color: #333;
    font-weight: 600;
    margin-bottom: 6px;
    font-size: 14px;
  }
  .form-group input,
  .form-group textarea {
    width: 100%;
    padding: 12px 15px;
    border: 2px solid #e3f2fd;
    border-radius: 8px;
    font-size: 14px;
    font-family: inherit;
    outline: none;
    transition: 0.3s;
  }
  .form-group input:focus,
  .form-group textarea:focus {
    border-color: #1976d2;
    box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
  }
  .form-group textarea {
    resize: vertical;
    min-height: 120px;
  }
  .btn-kirim {
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 14px 30px;
    border: none;
    border-radius: 25px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    width: 100%;
    transition: 0.3s;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
  }
  .btn-kirim:hover {
    background: #0d47a1;
    box-shadow: 0 4px 15px rgba(13, 71, 161, 0.4);
  }
  .btn-kirim svg {
    width: 16px;
    height: 16px;
  }
  .alert-sukses {
    background: #e8f5e9;
    color: #2e7d32;
    padding: 15px;
    border-radius: 8px;
    border-left: 5px solid #4caf50;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .alert-sukses svg {
    width: 20px;
    height: 20px;
    flex-shrink: 0;
  }
  .alert-error {
    background: #ffebee;
    color: #c62828;
    padding: 15px;
    border-radius: 8px;
    border-left: 5px solid #f44336;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
  }
  .alert-error svg {
    width: 20px;
    height: 20px;
    flex-shrink: 0;
  }

  .peta-box {
    background: #fff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    margin-bottom: 20px;
  }
  .peta-box h3 {
    color: #0d47a1;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 8px;
  }
  .peta-box h3 svg {
    width: 20px;
    height: 20px;
  }
  .peta-box iframe {
    width: 100%;
    height: 250px;
    border: 0;
    border-radius: 8px;
  }

  .jam-ops {
    background: linear-gradient(135deg, #e3f2fd, #fff);
    padding: 20px;
    border-radius: 12px;
    border-left: 5px solid #1976d2;
  }
  .jam-ops h3 {
    color: #0d47a1;
    margin-bottom: 12px;
    font-size: 16px;
    display: flex;
    align-items: center;
    gap: 8px;
  }
  .jam-ops h3 svg {
    width: 18px;
    height: 18px;
  }
  .jam-ops .row {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    border-bottom: 1px dashed #ccc;
    font-size: 14px;
  }
  .jam-ops .row:last-child { border-bottom: none; }
  .jam-ops .row span:last-child { color: #1976d2; font-weight: 600; }

  .sosmed {
    display: flex;
    gap: 12px;
    margin-top: 20px;
    justify-content: center;
  }
  .sosmed a {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    background: #1976d2;
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    transition: 0.3s;
  }
  .sosmed a:hover {
    background: #0d47a1;
    transform: translateY(-5px) scale(1.1);
  }
  .sosmed a svg {
    width: 20px;
    height: 20px;
  }
</style>

<!-- ============ HERO ============ -->
<div class="container">
  <div class="kontak-hero">
    <h2>Hubungi Kami</h2>
    <p>Kami siap membantu Anda 24/7. Jangan ragu untuk menghubungi kami!</p>
  </div>
</div>

<!-- ============ INFO CEPAT ============ -->
<div class="container">
  <div class="info-grid">

    <!-- Alamat -->
    <div class="info-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
          <circle cx="12" cy="10" r="3"></circle>
        </svg>
      </div>
      <h3>Alamat Kantor</h3>
      <p>Jl. Merdeka No.1<br>Jakarta Pusat, 10110</p>
    </div>

    <!-- Telepon -->
    <div class="info-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
        </svg>
      </div>
      <h3>Telepon</h3>
      <p>021-1234567<br>0812-3456-7890 (WA)</p>
    </div>

    <!-- Email -->
    <div class="info-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
          <polyline points="22,6 12,13 2,6"></polyline>
        </svg>
      </div>
      <h3>Email</h3>
      <p>info@asuransijiwa.co.id<br>cs@asuransijiwa.co.id</p>
    </div>

    <!-- Jam Operasional -->
    <div class="info-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <polyline points="12 6 12 12 16 14"></polyline>
        </svg>
      </div>
      <h3>Jam Operasional</h3>
      <p>Senin-Jumat: 08.00-17.00<br>Sabtu: 08.00-12.00</p>
    </div>

  </div>
</div>

<!-- ============ FORM + PETA ============ -->
<div class="container">
  <div class="kontak-wrapper">

    <!-- FORM KONTAK -->
    <div class="form-kontak">
      <h3>
        <svg viewBox="0 0 24 24" fill="none" stroke="#0d47a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
          <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
        </svg>
        Kirim Pesan
      </h3>

      <%
        String status = request.getParameter("status");
        if("sukses".equals(status)){
      %>
        <div class="alert-sukses">
          <svg viewBox="0 0 24 24" fill="none" stroke="#2e7d32" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="20 6 9 17 4 12"></polyline>
          </svg>
          <div><b>Terima kasih!</b> Pesan Anda berhasil terkirim.</div>
        </div>
      <%
        } else if("gagal".equals(status)){
      %>
        <div class="alert-error">
          <svg viewBox="0 0 24 24" fill="none" stroke="#c62828" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="15" y1="9" x2="9" y2="15"></line>
            <line x1="9" y1="9" x2="15" y2="15"></line>
          </svg>
          <div><b>Gagal mengirim pesan.</b> Silakan coba lagi.</div>
        </div>
      <%
        }
      %>

      <form action="simpan_pesan.jsp" method="post" onsubmit="return validasiForm()">
        <div class="form-group">
          <label>Nama Lengkap *</label>
          <input type="text" name="nama" id="nama" required placeholder="Contoh: Budi Santoso">
        </div>
        <div class="form-group">
          <label>Email *</label>
          <input type="email" name="email" id="email" required placeholder="email@contoh.com">
        </div>
        <div class="form-group">
          <label>No. Telepon</label>
          <input type="text" name="telepon" id="telepon" placeholder="0812-xxxx-xxxx">
        </div>
        <div class="form-group">
          <label>Subjek</label>
          <input type="text" name="subjek" id="subjek" placeholder="Contoh: Tanya premi">
        </div>
        <div class="form-group">
          <label>Pesan *</label>
          <textarea name="pesan" id="pesan" required placeholder="Tulis pesan Anda di sini..."></textarea>
        </div>
        <button type="submit" class="btn-kirim">
          <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="22" y1="2" x2="11" y2="13"></line>
            <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
          </svg>
          Kirim Pesan
        </button>
      </form>
    </div>

    <!-- PETA & JAM OPS -->
    <div>
      <div class="peta-box">
        <h3>
          <svg viewBox="0 0 24 24" fill="none" stroke="#0d47a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6"></polygon>
            <line x1="8" y1="2" x2="8" y2="18"></line>
            <line x1="16" y1="6" x2="16" y2="22"></line>
          </svg>
          Lokasi Kami
        </h3>
        <iframe 
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.5!2d106.827!3d-6.175!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zNsKwMTAnMzAuMCJTIDEwNsKwNDknMzcuMiJF!5e0!3m2!1sen!2sid!4v1234567890"
          allowfullscreen="" loading="lazy">
        </iframe>
      </div>

      <div class="jam-ops">
        <h3>
          <svg viewBox="0 0 24 24" fill="none" stroke="#0d47a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="12" cy="12" r="10"></circle>
            <polyline points="12 6 12 12 16 14"></polyline>
          </svg>
          Jam Layanan
        </h3>
        <div class="row"><span>Senin</span><span>08.00 - 17.00</span></div>
        <div class="row"><span>Selasa</span><span>08.00 - 17.00</span></div>
        <div class="row"><span>Rabu</span><span>08.00 - 17.00</span></div>
        <div class="row"><span>Kamis</span><span>08.00 - 17.00</span></div>
        <div class="row"><span>Jumat</span><span>08.00 - 17.00</span></div>
        <div class="row"><span>Sabtu</span><span>08.00 - 12.00</span></div>
        <div class="row"><span>Minggu</span><span style="color:#c62828">Tutup</span></div>
      </div>

      <div class="sosmed">
        <a href="#" title="Facebook">
          <svg viewBox="0 0 24 24" fill="#fff">
            <path d="M9 8h-3v4h3v12h5v-12h3.642l.358-4h-4v-1.667c0-.955.192-1.333 1.115-1.333h2.885v-5h-3.808c-3.596 0-5.192 1.583-5.192 4.615v3.385z"/>
          </svg>
        </a>
        <a href="#" title="Instagram">
          <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
            <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
            <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
          </svg>
        </a>
        <a href="#" title="WhatsApp">
          <svg viewBox="0 0 24 24" fill="#fff">
            <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 0 1-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 0 1-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 0 1 2.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0 0 12.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 0 0 5.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 0 0-3.48-8.413Z"/>
          </svg>
        </a>
        <a href="#" title="Email">
          <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
            <polyline points="22,6 12,13 2,6"></polyline>
          </svg>
        </a>
      </div>
    </div>

  </div>
</div>

<script>
function validasiForm(){
  var nama = document.getElementById('nama').value.trim();
  var email = document.getElementById('email').value.trim();
  var pesan = document.getElementById('pesan').value.trim();

  if(nama.length < 3){
    alert('Nama minimal 3 karakter!');
    return false;
  }
  if(!email.includes('@') || !email.includes('.')){
    alert('Email tidak valid!');
    return false;
  }
  if(pesan.length < 10){
    alert('Pesan minimal 10 karakter!');
    return false;
  }
  return true;
}
</script>

<%@ include file="footer.jsp" %>