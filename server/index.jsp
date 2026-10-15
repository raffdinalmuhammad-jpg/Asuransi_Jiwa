<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<style>
  .hero {
    background: linear-gradient(135deg, #0d47a1 0%, #1976d2 50%, #42a5f5 100%);
    color: #fff;
    padding: 60px 40px;
    border-radius: 15px;
    text-align: center;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(13, 71, 161, 0.3);
  }
  .hero h1 {
    font-size: 38px;
    color: #fff;
    margin-bottom: 15px;
  }
  .hero p {
    font-size: 18px;
    opacity: 0.95;
    margin-bottom: 25px;
  }
  .hero .btn-hero {
    background: #ffd54f;
    color: #0d47a1;
    padding: 14px 32px;
    border-radius: 30px;
    font-weight: bold;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    margin: 5px;
    font-size: 15px;
    transition: 0.3s;
  }
  .hero .btn-hero:hover {
    background: #fff;
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
  }
  .hero .btn-hero svg {
    width: 16px;
    height: 16px;
  }
  .hero .btn-outline {
    background: transparent;
    border: 2px solid #fff;
    color: #fff;
  }
  .hero .btn-outline:hover {
    background: #fff;
    color: #0d47a1;
  }
  .hero .btn-outline svg {
    stroke: #fff;
  }
  .hero .btn-outline:hover svg {
    stroke: #0d47a1;
  }

  .stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 20px;
    margin: 30px 0;
  }
  .stat-box {
    background: #fff;
    padding: 25px 15px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border-bottom: 4px solid #1976d2;
    transition: 0.3s;
  }
  .stat-box:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(25, 118, 210, 0.2);
  }
  .stat-box .angka {
    font-size: 32px;
    font-weight: bold;
    color: #0d47a1;
  }
  .stat-box .label {
    font-size: 14px;
    color: #666;
    margin-top: 5px;
  }

  .section-title {
    text-align: center;
    font-size: 26px;
    color: #0d47a1;
    margin: 40px 0 15px;
  }
  .section-sub {
    text-align: center;
    color: #666;
    margin-bottom: 25px;
  }

  .fitur-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
  }
  .fitur-card {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
    text-align: center;
    transition: 0.3s;
    border-top: 3px solid #1976d2;
  }
  .fitur-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(25, 118, 210, 0.2);
  }
  .fitur-card .ikon {
    width: 60px;
    height: 60px;
    margin: 0 auto 12px;
    background: #e3f2fd;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .fitur-card .ikon svg {
    width: 30px;
    height: 30px;
  }
  .fitur-card h3 {
    color: #0d47a1;
    font-size: 17px;
    margin-bottom: 8px;
  }
  .fitur-card p {
    color: #666;
    font-size: 14px;
  }

  .produk-highlight {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 20px;
  }
  .produk-card {
    background: linear-gradient(135deg, #fff, #f0f4f8);
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border-left: 5px solid #1976d2;
    transition: 0.3s;
  }
  .produk-card:hover {
    border-left-color: #ffd54f;
    transform: translateX(5px);
  }
  .produk-card h3 {
    color: #0d47a1;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
    gap: 8px;
  }
  .produk-card h3 svg {
    width: 20px;
    height: 20px;
    flex-shrink: 0;
  }
  .produk-card .harga {
    font-size: 22px;
    font-weight: bold;
    color: #1976d2;
    margin: 10px 0;
  }
  .produk-card .manfaat {
    color: #555;
    font-size: 14px;
  }

  .testimoni-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
    margin-top: 20px;
  }
  .testimoni-card {
    background: #fff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
    position: relative;
  }
  .testimoni-card .quote-icon {
    position: absolute;
    top: 15px;
    left: 20px;
    opacity: 0.15;
  }
  .testimoni-card .quote-icon svg {
    width: 45px;
    height: 45px;
  }
  .testimoni-card p {
    color: #555;
    font-style: italic;
    margin: 30px 0 15px;
    position: relative;
    z-index: 1;
  }
  .testimoni-card .nama {
    font-weight: bold;
    color: #0d47a1;
  }
  .testimoni-card .rating {
    color: #ffc107;
    font-size: 14px;
    letter-spacing: 2px;
  }

  .cta-bawah {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 40px;
    border-radius: 15px;
    text-align: center;
    margin: 40px 0 20px;
  }
  .cta-bawah h2 {
    color: #fff;
    margin-bottom: 15px;
  }
  .cta-bawah a {
    background: #ffd54f;
    color: #0d47a1;
    padding: 12px 30px;
    border-radius: 25px;
    text-decoration: none;
    font-weight: bold;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    margin-top: 10px;
    margin-left: 5px;
    transition: 0.3s;
  }
  .cta-bawah a:hover {
    background: #fff;
    transform: scale(1.05);
  }
  .cta-bawah a svg {
    width: 16px;
    height: 16px;
  }
  .cta-bawah a.btn-outline-cta {
    background: transparent;
    border: 2px solid #fff;
    color: #fff;
  }
  .cta-bawah a.btn-outline-cta:hover {
    background: #fff;
    color: #0d47a1;
  }
  .cta-bawah a.btn-outline-cta svg {
    stroke: #fff;
  }
  .cta-bawah a.btn-outline-cta:hover svg {
    stroke: #0d47a1;
  }

  /* Tombol utama halaman */
  .btn-lihat-semua {
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 12px 30px;
    border-radius: 25px;
    text-decoration: none;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: 0.3s;
  }
  .btn-lihat-semua:hover {
    background: #0d47a1;
    box-shadow: 0 6px 20px rgba(13, 71, 161, 0.4);
    transform: translateY(-2px);
  }
  .btn-lihat-semua svg {
    width: 16px;
    height: 16px;
  }
</style>

<!-- ============ HERO ============ -->
<div class="container">
  <div class="hero">
    <h1>Asuransi Jiwa Sejahtera</h1>
    <p>Perlindungan terbaik untuk keluarga tercinta Anda.<br>Premi terjangkau, klaim cepat, agen profesional.</p>
    <a href="produk.jsp" class="btn-hero">
      <svg viewBox="0 0 24 24" fill="none" stroke="#0d47a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
        <polyline points="14 2 14 8 20 8"></polyline>
        <line x1="16" y1="13" x2="8" y2="13"></line>
        <line x1="16" y1="17" x2="8" y2="17"></line>
      </svg>
      Lihat Produk
    </a>
    <a href="simulasi.jsp" class="btn-hero btn-outline">
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <line x1="12" y1="1" x2="12" y2="23"></line>
        <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
      </svg>
      Hitung Premi
    </a>
  </div>
</div>

<!-- ============ STATISTIK ============ -->
<div class="container">
  <div class="stats">
    <div class="stat-box">
      <div class="angka">50K+</div>
      <div class="label">Nasabah Aktif</div>
    </div>
    <div class="stat-box">
      <div class="angka">99%</div>
      <div class="label">Klaim Disetujui</div>
    </div>
    <div class="stat-box">
      <div class="angka">18</div>
      <div class="label">Tahun Pengalaman</div>
    </div>
    <div class="stat-box">
      <div class="angka">4.9</div>
      <div class="label">Rating Kepuasan</div>
    </div>
  </div>
</div>

<!-- ============ VISI & MISI ============ -->
<div class="container">
  <h2 class="section-title">Visi & Misi Kami</h2>
  <p class="section-sub">Komitmen kami untuk perlindungan keluarga Indonesia</p>

  <div class="fitur-grid">
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <circle cx="12" cy="12" r="6"></circle>
          <circle cx="12" cy="12" r="2"></circle>
        </svg>
      </div>
      <h3>Visi</h3>
      <p>Menjadi perusahaan asuransi jiwa terpercaya #1 di Indonesia dengan pelayanan prima.</p>
    </div>
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M4.5 16.5c-1.5 1.26-2 5-2 5s3.74-.5 5-2c.71-.84.7-2.13-.09-2.91a2.18 2.18 0 0 0-2.91-.09z"></path>
          <path d="M12 15l-3-3a22 22 0 0 1 2-3.95A12.88 12.88 0 0 1 22 2c0 2.72-.78 7.5-6 11a22.35 22.35 0 0 1-4 2z"></path>
          <path d="M9 12H4s.55-3.03 2-4c1.62-1.08 5 0 5 0"></path>
          <path d="M12 15v5s3.03-.55 4-2c1.08-1.62 0-5 0-5"></path>
        </svg>
      </div>
      <h3>Misi</h3>
      <p>Memberikan perlindungan menyeluruh dengan premi terjangkau untuk semua kalangan.</p>
    </div>
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
        </svg>
      </div>
      <h3>Nilai</h3>
      <p>Integritas, profesionalisme, dan kepuasan nasabah adalah prioritas utama kami.</p>
    </div>
  </div>
</div>

<!-- ============ FITUR UNGGULAN ============ -->
<div class="container">
  <h2 class="section-title">Mengapa Memilih Kami?</h2>
  <p class="section-sub">Keunggulan yang membuat kami dipercaya jutaan keluarga</p>

  <div class="fitur-grid">
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
        </svg>
      </div>
      <h3>Klaim Cepat</h3>
      <p>Proses klaim hanya 3 hari kerja setelah dokumen lengkap.</p>
    </div>
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="12" y1="1" x2="12" y2="23"></line>
          <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
        </svg>
      </div>
      <h3>Premi Murah</h3>
      <p>Mulai dari Rp 500.000/tahun dengan manfaat hingga ratusan juta.</p>
    </div>
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
          <circle cx="12" cy="7" r="4"></circle>
        </svg>
      </div>
      <h3>Agen Profesional</h3>
      <p>Ratusan agen bersertifikat siap membantu di 34 provinsi.</p>
    </div>
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
          <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
        </svg>
      </div>
      <h3>Aman & Terpercaya</h3>
      <p>Terdaftar & diawasi OJK, dana nasabah dijamin aman.</p>
    </div>
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect>
          <line x1="12" y1="18" x2="12.01" y2="18"></line>
        </svg>
      </div>
      <h3>Layanan Digital</h3>
      <p>Kelola polis, bayar premi, dan klaim online 24/7.</p>
    </div>
    <div class="fitur-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 12 20 22 4 22 4 12"></polyline>
          <rect x="2" y="7" width="20" height="5"></rect>
          <line x1="12" y1="22" x2="12" y2="7"></line>
          <path d="M12 7H7.5a2.5 2.5 0 0 1 0-5C11 2 12 7 12 7z"></path>
          <path d="M12 7h4.5a2.5 2.5 0 0 0 0-5C13 2 12 7 12 7z"></path>
        </svg>
      </div>
      <h3>Bonus Menarik</h3>
      <p>Cashback, diskon premi, dan hadiah untuk nasabah setia.</p>
    </div>
  </div>
</div>

<!-- ============ PRODUK UNGGULAN (DINAMIS) ============ -->
<div class="container">
  <h2 class="section-title">Produk Unggulan</h2>
  <p class="section-sub">Pilihan terbaik dari kami</p>

  <div class="produk-highlight">
  <%
    try {
      Class.forName("com.mysql.jdbc.Driver");
      Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/asuransi_jiwa", "root", "");
      ResultSet rs = c.createStatement().executeQuery(
        "SELECT nama, premi, manfaat FROM produk LIMIT 3");
      while(rs.next()){
  %>
    <div class="produk-card">
      <h3>
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
        </svg>
        <%=rs.getString("nama")%>
      </h3>
      <div class="harga">Rp <%=String.format("%,d", rs.getInt("premi"))%>/tahun</div>
      <div class="manfaat"><%=rs.getString("manfaat")%></div>
    </div>
  <%
      }
      c.close();
    } catch(Exception e) {
  %>
    <div class="produk-card">
      <h3>
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
        </svg>
        Asuransi Sejahtera
      </h3>
      <div class="harga">Rp 500.000/tahun</div>
      <div class="manfaat">Santunan hingga 100 juta</div>
    </div>
    <div class="produk-card">
      <h3>
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
        </svg>
        Asuransi Premium
      </h3>
      <div class="harga">Rp 1.000.000/tahun</div>
      <div class="manfaat">Santunan hingga 500 juta</div>
    </div>
    <div class="produk-card">
      <h3>
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
        </svg>
        Asuransi Keluarga
      </h3>
      <div class="harga">Rp 750.000/tahun</div>
      <div class="manfaat">Santunan hingga 250 juta</div>
    </div>
  <%
    }
  %>
  </div>

  <div style="text-align:center;margin-top:25px">
    <a href="produk.jsp" class="btn-lihat-semua">
      Lihat Semua Produk
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <line x1="5" y1="12" x2="19" y2="12"></line>
        <polyline points="12 5 19 12 12 19"></polyline>
      </svg>
    </a>
  </div>
</div>

<!-- ============ TESTIMONI ============ -->
<div class="container">
  <h2 class="section-title">Kata Mereka</h2>
  <p class="section-sub">Testimoni dari nasabah setia kami</p>

  <div class="testimoni-grid">
    <div class="testimoni-card">
      <div class="quote-icon">
        <svg viewBox="0 0 24 24" fill="#1976d2">
          <path d="M6 17h3l2-4V7H5v6h3zm8 0h3l2-4V7h-6v6h3z"/>
        </svg>
      </div>
      <p>Pelayanan cepat dan ramah! Klaim saya cair dalam 3 hari tanpa ribet.</p>
      <div class="nama">Andi Pratama</div>
      <div class="rating">★★★★★</div>
    </div>
    <div class="testimoni-card">
      <div class="quote-icon">
        <svg viewBox="0 0 24 24" fill="#1976d2">
          <path d="M6 17h3l2-4V7H5v6h3zm8 0h3l2-4V7h-6v6h3z"/>
        </svg>
      </div>
      <p>Premi terjangkau, cocok untuk keluarga muda seperti kami. Recommended!</p>
      <div class="nama">Rina Wulandari</div>
      <div class="rating">★★★★★</div>
    </div>
    <div class="testimoni-card">
      <div class="quote-icon">
        <svg viewBox="0 0 24 24" fill="#1976d2">
          <path d="M6 17h3l2-4V7H5v6h3zm8 0h3l2-4V7h-6v6h3z"/>
        </svg>
      </div>
      <p>Agennya profesional dan sabar menjelaskan. Terima kasih Asuransi Jiwa Sejahtera.</p>
      <div class="nama">Budi Hartono</div>
      <div class="rating">★★★★★</div>
    </div>
  </div>
</div>

<!-- ============ CTA ============ -->
<div class="container">
  <div class="cta-bawah">
    <h2>Siap Lindungi Keluarga Anda?</h2>
    <p>Konsultasi gratis dengan agen kami sekarang juga!</p>
    <a href="kontak.jsp">
      <svg viewBox="0 0 24 24" fill="none" stroke="#0d47a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
      </svg>
      Hubungi Kami
    </a>
    <a href="simulasi.jsp" class="btn-outline-cta">
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <line x1="12" y1="1" x2="12" y2="23"></line>
        <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
      </svg>
      Simulasi Premi
    </a>
  </div>
</div>

<%@ include file="footer.jsp" %>