<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<style>
  .tentang-hero {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 50px 30px;
    border-radius: 15px;
    text-align: center;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(13, 71, 161, 0.3);
  }
  .tentang-hero h2 {
    color: #fff;
    font-size: 34px;
    margin-bottom: 12px;
  }
  .tentang-hero p {
    opacity: 0.95;
    font-size: 16px;
    max-width: 700px;
    margin: 0 auto;
    line-height: 1.6;
  }

  .stat-tentang {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
  }
  .stat-tentang-card {
    background: #fff;
    padding: 25px 20px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border-bottom: 4px solid #1976d2;
    transition: 0.3s;
  }
  .stat-tentang-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 25px rgba(25, 118, 210, 0.2);
  }
  .stat-tentang-card .ikon {
    width: 60px;
    height: 60px;
    background: #e3f2fd;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 12px;
  }
  .stat-tentang-card .ikon svg {
    width: 28px;
    height: 28px;
  }
  .stat-tentang-card .angka {
    font-size: 30px;
    font-weight: bold;
    color: #0d47a1;
    line-height: 1;
  }
  .stat-tentang-card .label {
    font-size: 13px;
    color: #666;
    margin-top: 6px;
  }

  .section-title-tentang {
    text-align: center;
    color: #0d47a1;
    font-size: 26px;
    margin: 40px 0 10px;
  }
  .section-sub-tentang {
    text-align: center;
    color: #666;
    margin-bottom: 30px;
  }

  /* Timeline Sejarah */
  .timeline {
    position: relative;
    max-width: 900px;
    margin: 0 auto;
    padding: 20px 0;
  }
  .timeline::before {
    content: "";
    position: absolute;
    left: 50%;
    top: 0; bottom: 0;
    width: 3px;
    background: linear-gradient(180deg, #1976d2, #42a5f5);
    transform: translateX(-50%);
  }
  .timeline-item {
    display: flex;
    justify-content: flex-end;
    padding-right: 50%;
    margin-bottom: 30px;
    position: relative;
  }
  .timeline-item:nth-child(even) {
    justify-content: flex-start;
    padding-right: 0;
    padding-left: 50%;
  }
  .timeline-content {
    background: #fff;
    padding: 20px 25px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    max-width: 380px;
    margin: 0 30px;
    border-left: 4px solid #1976d2;
    position: relative;
  }
  .timeline-item:nth-child(even) .timeline-content {
    border-left: none;
    border-right: 4px solid #1976d2;
  }
  .timeline-content .tahun {
    color: #1976d2;
    font-weight: bold;
    font-size: 18px;
    margin-bottom: 5px;
  }
  .timeline-content h4 {
    color: #0d47a1;
    margin-bottom: 8px;
    font-size: 16px;
  }
  .timeline-content p {
    color: #555;
    font-size: 13px;
    line-height: 1.6;
  }
  .timeline-dot {
    position: absolute;
    left: 50%;
    top: 20px;
    width: 20px;
    height: 20px;
    background: #1976d2;
    border: 4px solid #fff;
    border-radius: 50%;
    transform: translateX(-50%);
    box-shadow: 0 0 0 3px #1976d2;
    z-index: 2;
  }
  @media(max-width: 768px){
    .timeline::before { left: 20px; }
    .timeline-item,
    .timeline-item:nth-child(even) {
      justify-content: flex-start;
      padding-left: 50px;
      padding-right: 0;
    }
    .timeline-content {
      max-width: 100%;
      margin: 0;
    }
    .timeline-content,
    .timeline-item:nth-child(even) .timeline-content {
      border-left: 4px solid #1976d2;
      border-right: none;
    }
    .timeline-dot { left: 20px; }
  }

  /* Visi Misi */
  .visi-misi-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 25px;
    margin-bottom: 40px;
  }
  @media(max-width: 768px){
    .visi-misi-grid { grid-template-columns: 1fr; }
  }
  .visi-misi-card {
    background: #fff;
    padding: 30px;
    border-radius: 15px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border-top: 5px solid #1976d2;
    transition: 0.3s;
  }
  .visi-misi-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 25px rgba(25, 118, 210, 0.2);
  }
  .visi-misi-card .ikon {
    width: 60px;
    height: 60px;
    background: linear-gradient(135deg, #1976d2, #0d47a1);
    border-radius: 15px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 15px;
  }
  .visi-misi-card .ikon svg {
    width: 30px;
    height: 30px;
  }
  .visi-misi-card h3 {
    color: #0d47a1;
    font-size: 22px;
    margin-bottom: 12px;
  }
  .visi-misi-card p {
    color: #555;
    line-height: 1.7;
    font-size: 14px;
  }

  /* Nilai Perusahaan */
  .nilai-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
  }
  .nilai-card {
    background: #fff;
    padding: 25px 20px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
    transition: 0.3s;
    border-top: 3px solid #1976d2;
  }
  .nilai-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(25, 118, 210, 0.2);
  }
  .nilai-card .ikon {
    width: 55px;
    height: 55px;
    background: #e3f2fd;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 12px;
  }
  .nilai-card .ikon svg {
    width: 26px;
    height: 26px;
  }
  .nilai-card h4 {
    color: #0d47a1;
    font-size: 16px;
    margin-bottom: 8px;
  }
  .nilai-card p {
    color: #666;
    font-size: 13px;
    line-height: 1.5;
  }

  /* Tim Manajemen */
  .tim-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
  }
  .tim-card {
    background: #fff;
    padding: 25px 20px;
    border-radius: 12px;
    text-align: center;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    transition: 0.3s;
  }
  .tim-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 25px rgba(25, 118, 210, 0.2);
  }
  .tim-avatar {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    background: linear-gradient(135deg, #1976d2, #0d47a1);
    color: #fff;
    font-size: 30px;
    font-weight: bold;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 15px;
    box-shadow: 0 6px 15px rgba(25, 118, 210, 0.3);
    letter-spacing: 1px;
  }
  .tim-card h4 {
    color: #0d47a1;
    font-size: 17px;
    margin-bottom: 5px;
  }
  .tim-card .jabatan {
    color: #1976d2;
    font-size: 13px;
    font-weight: 600;
    margin-bottom: 10px;
  }
  .tim-card p {
    color: #666;
    font-size: 12px;
    line-height: 1.5;
  }

  /* Penghargaan */
  .penghargaan-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 20px;
    margin-bottom: 40px;
  }
  .penghargaan-card {
    background: linear-gradient(135deg, #fff, #f0f7ff);
    padding: 25px 20px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
    border-left: 5px solid #ffd54f;
    display: flex;
    gap: 15px;
    align-items: flex-start;
  }
  .penghargaan-card .ikon {
    width: 50px;
    height: 50px;
    background: #fff3e0;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
  .penghargaan-card .ikon svg {
    width: 26px;
    height: 26px;
  }
  .penghargaan-card h4 {
    color: #0d47a1;
    font-size: 15px;
    margin-bottom: 5px;
  }
  .penghargaan-card .tahun {
    color: #e65100;
    font-weight: bold;
    font-size: 12px;
    margin-bottom: 5px;
  }
  .penghargaan-card p {
    color: #666;
    font-size: 12px;
    line-height: 1.5;
  }

  /* CTA */
  .cta-tentang {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 45px 30px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 10px 30px rgba(13, 71, 161, 0.3);
  }
  .cta-tentang h2 {
    color: #fff;
    margin-bottom: 12px;
    font-size: 26px;
  }
  .cta-tentang p {
    opacity: 0.95;
    margin-bottom: 22px;
    font-size: 15px;
  }
  .cta-tentang a {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: #ffd54f;
    color: #0d47a1;
    padding: 14px 32px;
    border-radius: 30px;
    text-decoration: none;
    font-weight: bold;
    margin: 5px;
    transition: 0.3s;
  }
  .cta-tentang a:hover {
    background: #fff;
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
  }
  .cta-tentang a svg {
    width: 16px;
    height: 16px;
  }
  .cta-tentang a.outline {
    background: transparent;
    border: 2px solid #fff;
    color: #fff;
  }
  .cta-tentang a.outline:hover {
    background: #fff;
    color: #0d47a1;
  }
</style>

<!-- ============ HERO ============ -->
<div class="container">
  <div class="tentang-hero">
    <h2>Tentang Asuransi Jiwa Sejahtera</h2>
    <p>Berdiri sejak 2005, kami telah dipercaya jutaan nasabah di seluruh Indonesia untuk melindungi masa depan keluarga tercinta.</p>
  </div>
</div>

<!-- ============ STATISTIK ============ -->
<div class="container">
  <div class="stat-tentang">

    <div class="stat-tentang-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect>
          <line x1="16" y1="2" x2="16" y2="6"></line>
          <line x1="8" y1="2" x2="8" y2="6"></line>
          <line x1="3" y1="10" x2="21" y2="10"></line>
        </svg>
      </div>
      <div class="angka">2005</div>
      <div class="label">Tahun Berdiri</div>
    </div>

    <div class="stat-tentang-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
          <circle cx="9" cy="7" r="4"></circle>
          <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
          <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
        </svg>
      </div>
      <div class="angka">50K+</div>
      <div class="label">Nasabah Aktif</div>
    </div>

    <div class="stat-tentang-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
          <circle cx="12" cy="7" r="4"></circle>
        </svg>
      </div>
      <div class="angka">500+</div>
      <div class="label">Agen Profesional</div>
    </div>

    <div class="stat-tentang-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path>
          <circle cx="12" cy="10" r="3"></circle>
        </svg>
      </div>
      <div class="angka">34</div>
      <div class="label">Kantor Cabang</div>
    </div>

  </div>
</div>

<!-- ============ SEJARAH ============ -->
<div class="container">
  <h2 class="section-title-tentang">Perjalanan Kami</h2>
  <p class="section-sub-tentang">Momen penting dalam sejarah perusahaan</p>

  <div class="timeline">

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <div class="tahun">2005</div>
        <h4>Pendirian Perusahaan</h4>
        <p>Asuransi Jiwa Sejahtera didirikan di Jakarta dengan visi melindungi keluarga Indonesia.</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <div class="tahun">2010</div>
        <h4>Ekspansi Nasional</h4>
        <p>Membuka 10 kantor cabang pertama di kota-kota besar Indonesia.</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <div class="tahun">2015</div>
        <h4>Sertifikasi OJK</h4>
        <p>Resmi terdaftar dan diawasi oleh Otoritas Jasa Keuangan (OJK).</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <div class="tahun">2020</div>
        <h4>Transformasi Digital</h4>
        <p>Meluncurkan layanan digital untuk klaim & pembayaran premi online 24/7.</p>
      </div>
    </div>

    <div class="timeline-item">
      <div class="timeline-dot"></div>
      <div class="timeline-content">
        <div class="tahun">2024</div>
        <h4>50.000+ Nasabah</h4>
        <p>Mencapai tonggak 50.000 nasabah aktif dengan 99% klaim disetujui.</p>
      </div>
    </div>

  </div>
</div>

<!-- ============ VISI MISI ============ -->
<div class="container">
  <h2 class="section-title-tentang">Visi & Misi</h2>
  <p class="section-sub-tentang">Komitmen kami untuk keluarga Indonesia</p>

  <div class="visi-misi-grid">

    <div class="visi-misi-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="12" r="10"></circle>
          <circle cx="12" cy="12" r="6"></circle>
          <circle cx="12" cy="12" r="2"></circle>
        </svg>
      </div>
      <h3>Visi Kami</h3>
      <p>Menjadi perusahaan asuransi jiwa terpercaya nomor 1 di Indonesia dengan pelayanan prima, teknologi modern, dan kepercayaan nasabah sebagai prioritas utama.</p>
    </div>

    <div class="visi-misi-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M4.5 16.5c-1.5 1.26-2 5-2 5s3.74-.5 5-2c.71-.84.7-2.13-.09-2.91a2.18 2.18 0 0 0-2.91-.09z"></path>
          <path d="M12 15l-3-3a22 22 0 0 1 2-3.95A12.88 12.88 0 0 1 22 2c0 2.72-.78 7.5-6 11a22.35 22.35 0 0 1-4 2z"></path>
          <path d="M9 12H4s.55-3.03 2-4c1.62-1.08 5 0 5 0"></path>
          <path d="M12 15v5s3.03-.55 4-2c1.08-1.62 0-5 0-5"></path>
        </svg>
      </div>
      <h3>Misi Kami</h3>
      <p>Memberikan perlindungan menyeluruh dengan premi terjangkau untuk semua kalangan, mengedepankan kecepatan klaim, dan memberikan edukasi keuangan kepada masyarakat Indonesia.</p>
    </div>

  </div>
</div>

<!-- ============ NILAI PERUSAHAAN ============ -->
<div class="container">
  <h2 class="section-title-tentang">Nilai-Nilai Kami</h2>
  <p class="section-sub-tentang">Prinsip yang menjadi fondasi perusahaan</p>

  <div class="nilai-grid">

    <div class="nilai-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
        </svg>
      </div>
      <h4>Integritas</h4>
      <p>Jujur, transparan, dan dapat dipercaya dalam setiap tindakan.</p>
    </div>

    <div class="nilai-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
        </svg>
      </div>
      <h4>Profesionalisme</h4>
      <p>Kompeten, disiplin, dan terus belajar untuk hasil terbaik.</p>
    </div>

    <div class="nilai-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
        </svg>
      </div>
      <h4>Kepedulian</h4>
      <p>Mendengarkan dan memahami kebutuhan setiap nasabah.</p>
    </div>

    <div class="nilai-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon>
        </svg>
      </div>
      <h4>Inovasi</h4>
      <p>Berani berkreasi dan adaptif terhadap perubahan zaman.</p>
    </div>

    <div class="nilai-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
          <circle cx="8.5" cy="7" r="4"></circle>
          <line x1="20" y1="8" x2="20" y2="14"></line>
          <line x1="23" y1="11" x2="17" y2="11"></line>
        </svg>
      </div>
      <h4>Kolaborasi</h4>
      <p>Bekerja sama sebagai tim untuk mencapai tujuan bersama.</p>
    </div>

  </div>
</div>

<!-- ============ TIM MANAJEMEN ============ -->
<div class="container">
  <h2 class="section-title-tentang">Tim Manajemen</h2>
  <p class="section-sub-tentang">Dipimpin oleh profesional berpengalaman</p>

  <div class="tim-grid">

    <div class="tim-card">
      <div class="tim-avatar">BS</div>
      <h4>Budi Santoso</h4>
      <div class="jabatan">Direktur Utama</div>
      <p>20+ tahun pengalaman di industri asuransi Indonesia.</p>
    </div>

    <div class="tim-card">
      <div class="tim-avatar">SA</div>
      <h4>Siti Aminah</h4>
      <div class="jabatan">Direktur Operasional</div>
      <p>Ahli dalam manajemen klaim & pelayanan nasabah.</p>
    </div>

    <div class="tim-card">
      <div class="tim-avatar">AW</div>
      <h4>Andi Wijaya</h4>
      <div class="jabatan">Direktur Keuangan</div>
      <p>Spesialis dalam pengelolaan risiko dan investasi.</p>
    </div>

    <div class="tim-card">
      <div class="tim-avatar">DL</div>
      <h4>Dewi Lestari</h4>
      <div class="jabatan">Direktur Pemasaran</div>
      <p>Membangun jaringan agen di 34 provinsi.</p>
    </div>

  </div>
</div>

<!-- ============ PENGHARGAAN ============ -->
<div class="container">
  <h2 class="section-title-tentang">Penghargaan</h2>
  <p class="section-sub-tentang">Pengakuan atas dedikasi kami</p>

  <div class="penghargaan-grid">

    <div class="penghargaan-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#e65100" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="8" r="6"></circle>
          <path d="M15.477 12.89 17 22l-5-3-5 3 1.523-9.11"></path>
        </svg>
      </div>
      <div>
        <h4>Best Insurance Award</h4>
        <div class="tahun">2024</div>
        <p>Penghargaan asuransi terbaik kategori pelayanan.</p>
      </div>
    </div>

    <div class="penghargaan-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#e65100" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="8" r="6"></circle>
          <path d="M15.477 12.89 17 22l-5-3-5 3 1.523-9.11"></path>
        </svg>
      </div>
      <div>
        <h4>Top Brand Award</h4>
        <div class="tahun">2023</div>
        <p>Merek asuransi paling diminati konsumen Indonesia.</p>
      </div>
    </div>

    <div class="penghargaan-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#e65100" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="8" r="6"></circle>
          <path d="M15.477 12.89 17 22l-5-3-5 3 1.523-9.11"></path>
        </svg>
      </div>
      <div>
        <h4>Indonesia Digital Award</h4>
        <div class="tahun">2023</div>
        <p>Inovasi digital terbaik di industri asuransi.</p>
      </div>
    </div>

    <div class="penghargaan-card">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#e65100" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="12" cy="8" r="6"></circle>
          <path d="M15.477 12.89 17 22l-5-3-5 3 1.523-9.11"></path>
        </svg>
      </div>
      <div>
        <h4>OJK Compliance Award</h4>
        <div class="tahun">2022</div>
        <p>Kepatuhan regulator terbaik kategori asuransi jiwa.</p>
      </div>
    </div>

  </div>
</div>

<!-- ============ CTA ============ -->
<div class="container">
  <div class="cta-tentang">
    <h2>Bergabung Bersama Kami</h2>
    <p>Jadilah bagian dari keluarga besar Asuransi Jiwa Sejahtera</p>
    <a href="kontak.jsp">
      <svg viewBox="0 0 24 24" fill="none" stroke="#0d47a1" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
      </svg>
      Hubungi Kami
    </a>
    <a href="karir.jsp" class="outline">
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="2" y="7" width="20" height="14" rx="2" ry="2"></rect>
        <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
      </svg>
      Lihat Karir
    </a>
  </div>
</div>

<%@ include file="footer.jsp" %>