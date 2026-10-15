<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<style>
  .galeri-header {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 35px 30px;
    border-radius: 12px;
    text-align: center;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.25);
  }
  .galeri-header h2 { color: #fff; margin-bottom: 8px; font-size: 28px; }
  .galeri-header p { opacity: 0.9; }

  /* Filter kategori */
  .filter-bar {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    justify-content: center;
    margin-bottom: 25px;
  }
  .filter-btn {
    padding: 9px 20px;
    border: 2px solid #e3f2fd;
    background: #fff;
    color: #1976d2;
    border-radius: 25px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
    font-family: inherit;
  }
  .filter-btn:hover {
    background: #e3f2fd;
    border-color: #1976d2;
  }
  .filter-btn.aktif {
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    border-color: #0d47a1;
    box-shadow: 0 4px 12px rgba(13, 71, 161, 0.3);
  }

  /* Grid galeri */
  .gallery {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 18px;
  }
  .gallery-item {
    position: relative;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    cursor: pointer;
    transition: all 0.4s ease;
    background: #000;
    aspect-ratio: 4 / 3;
  }
  .gallery-item:hover {
    transform: translateY(-6px);
    box-shadow: 0 15px 30px rgba(25, 118, 210, 0.3);
  }
  .gallery-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s ease;
    display: block;
  }
  .gallery-item:hover img {
    transform: scale(1.1);
  }
  .gallery-overlay {
    position: absolute;
    bottom: 0; left: 0; right: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.85) 0%, rgba(0,0,0,0) 100%);
    color: #fff;
    padding: 25px 15px 15px;
    transform: translateY(100%);
    transition: transform 0.4s ease;
  }
  .gallery-item:hover .gallery-overlay {
    transform: translateY(0);
  }
  .gallery-overlay .judul {
    font-weight: bold;
    font-size: 15px;
    margin-bottom: 4px;
  }
  .gallery-overlay .kategori {
    font-size: 12px;
    opacity: 0.85;
    display: inline-block;
    background: rgba(25, 118, 210, 0.9);
    padding: 2px 10px;
    border-radius: 10px;
  }
  .gallery-zoom {
    position: absolute;
    top: 15px;
    right: 15px;
    width: 38px;
    height: 38px;
    background: rgba(255,255,255,0.95);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transform: scale(0.6);
    transition: all 0.3s ease;
    box-shadow: 0 4px 12px rgba(0,0,0,0.2);
  }
  .gallery-item:hover .gallery-zoom {
    opacity: 1;
    transform: scale(1);
  }
  .gallery-zoom svg {
    width: 18px;
    height: 18px;
  }

  /* Lightbox modal */
  .lightbox {
    display: none;
    position: fixed;
    top: 0; left: 0;
    width: 100%; height: 100%;
    background: rgba(0,0,0,0.95);
    z-index: 99999;
    align-items: center;
    justify-content: center;
    padding: 20px;
  }
  .lightbox.aktif { display: flex; }
  .lightbox-img-wrap {
    max-width: 90vw;
    max-height: 85vh;
    position: relative;
    animation: zoomIn 0.35s ease;
  }
  @keyframes zoomIn {
    from { transform: scale(0.85); opacity: 0; }
    to { transform: scale(1); opacity: 1; }
  }
  .lightbox-img-wrap img {
    max-width: 90vw;
    max-height: 75vh;
    border-radius: 10px;
    display: block;
    box-shadow: 0 20px 60px rgba(0,0,0,0.5);
  }
  .lightbox-caption {
    color: #fff;
    text-align: center;
    margin-top: 15px;
    font-size: 15px;
  }
  .lightbox-caption .judul {
    font-weight: bold;
    margin-bottom: 4px;
  }
  .lightbox-caption .counter {
    font-size: 13px;
    opacity: 0.7;
  }
  .lightbox-close {
    position: absolute;
    top: -55px;
    right: 0;
    width: 42px;
    height: 42px;
    background: rgba(255,255,255,0.15);
    border: none;
    border-radius: 50%;
    color: #fff;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: 0.3s;
  }
  .lightbox-close:hover {
    background: rgba(255,255,255,0.3);
    transform: rotate(90deg);
  }
  .lightbox-close svg {
    width: 20px;
    height: 20px;
  }
  .lightbox-nav {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    width: 50px;
    height: 50px;
    background: rgba(255,255,255,0.15);
    border: none;
    border-radius: 50%;
    color: #fff;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: 0.3s;
  }
  .lightbox-nav:hover {
    background: rgba(255,255,255,0.3);
    transform: translateY(-50%) scale(1.1);
  }
  .lightbox-nav.prev { left: -70px; }
  .lightbox-nav.next { right: -70px; }
  .lightbox-nav svg {
    width: 22px;
    height: 22px;
  }
  @media(max-width: 900px){
    .lightbox-nav.prev { left: 10px; }
    .lightbox-nav.next { right: 10px; }
  }

  /* Statistik kecil */
  .galeri-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 15px;
    margin-bottom: 25px;
  }
  .galeri-stat {
    background: #fff;
    padding: 18px;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.06);
    display: flex;
    align-items: center;
    gap: 12px;
    border-left: 4px solid #1976d2;
  }
  .galeri-stat .ikon {
    width: 45px;
    height: 45px;
    background: #e3f2fd;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
  }
  .galeri-stat .ikon svg {
    width: 22px;
    height: 22px;
  }
  .galeri-stat .isi .angka {
    font-size: 18px;
    font-weight: bold;
    color: #0d47a1;
  }
  .galeri-stat .isi .label {
    font-size: 12px;
    color: #666;
  }
</style>

<!-- ============ HEADER ============ -->
<div class="container">
  <div class="galeri-header">
    <h2>Galeri Kegiatan</h2>
    <p>Dokumentasi momen & kegiatan Asuransi Jiwa Sejahtera</p>
  </div>
</div>

<!-- ============ STATISTIK ============ -->
<div class="container">
  <div class="galeri-stats">
    <div class="galeri-stat">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
          <circle cx="8.5" cy="8.5" r="1.5"></circle>
          <polyline points="21 15 16 10 5 21"></polyline>
        </svg>
      </div>
      <div class="isi">
        <div class="angka">12</div>
        <div class="label">Total Foto</div>
      </div>
    </div>
    <div class="galeri-stat">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path>
          <line x1="7" y1="7" x2="7.01" y2="7"></line>
        </svg>
      </div>
      <div class="isi">
        <div class="angka">4</div>
        <div class="label">Kategori</div>
      </div>
    </div>
    <div class="galeri-stat">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
          <circle cx="12" cy="12" r="3"></circle>
        </svg>
      </div>
      <div class="isi">
        <div class="angka">2024</div>
        <div class="label">Tahun Terbaru</div>
      </div>
    </div>
    <div class="galeri-stat">
      <div class="ikon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
          <circle cx="9" cy="7" r="4"></circle>
          <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
          <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
        </svg>
      </div>
      <div class="isi">
        <div class="angka">500+</div>
        <div class="label">Peserta Total</div>
      </div>
    </div>
  </div>
</div>

<!-- ============ FILTER KATEGORI ============ -->
<div class="container">
  <div class="filter-bar">
    <button class="filter-btn aktif" onclick="filterKategori('semua', this)">Semua</button>
    <button class="filter-btn" onclick="filterKategori('seminar', this)">Seminar</button>
    <button class="filter-btn" onclick="filterKategori('sosial', this)">Sosial</button>
    <button class="filter-btn" onclick="filterKategori('penghargaan', this)">Penghargaan</button>
    <button class="filter-btn" onclick="filterKategori('klaim', this)">Klaim</button>
  </div>
</div>

<!-- ============ GRID GALERI ============ -->
<div class="container">
  <div class="gallery" id="galleryGrid">
  <%
    // Data galeri: {url, judul, kategori}
    String[][] galeri = {
      {"https://picsum.photos/seed/asuransi1/800/600", "Seminar Nasional Asuransi 2024", "seminar"},
      {"https://picsum.photos/seed/asuransi2/800/600", "Bakti Sosial Panti Asuhan", "sosial"},
      {"https://picsum.photos/seed/asuransi3/800/600", "Penghargaan Best Insurance 2024", "penghargaan"},
      {"https://picsum.photos/seed/asuransi4/800/600", "Pelatihan Agen Baru Batch 15", "seminar"},
      {"https://picsum.photos/seed/asuransi5/800/600", "Penyerahan Klaim Nasabah", "klaim"},
      {"https://picsum.photos/seed/asuransi6/800/600", "Donor Darah Karyawan", "sosial"},
      {"https://picsum.photos/seed/asuransi7/800/600", "Workshop Financial Planning", "seminar"},
      {"https://picsum.photos/seed/asuransi8/800/600", "Gathering Nasabah Premium", "sosial"},
      {"https://picsum.photos/seed/asuransi9/800/600", "Sertifikasi Agen Profesional", "penghargaan"},
      {"https://picsum.photos/seed/asuransi10/800/600", "Klaim Cepat 3 Hari Kerja", "klaim"},
      {"https://picsum.photos/seed/asuransi11/800/600", "CSR Pendidikan Anak Yatim", "sosial"},
      {"https://picsum.photos/seed/asuransi12/800/600", "Launching Produk Baru 2024", "seminar"}
    };

    for(int i = 0; i < galeri.length; i++){
      String url = galeri[i][0];
      String judul = galeri[i][1];
      String kategori = galeri[i][2];

      // Label kategori untuk display
      String labelKat = kategori.substring(0,1).toUpperCase() + kategori.substring(1);
  %>
    <div class="gallery-item" data-kategori="<%=kategori%>"
         onclick="bukaLightbox(<%=i%>)">
      <img src="<%=url%>" alt="<%=judul%>" loading="lazy">
      <div class="gallery-zoom">
        <svg viewBox="0 0 24 24" fill="none" stroke="#1976d2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="11" cy="11" r="8"></circle>
          <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
          <line x1="11" y1="8" x2="11" y2="14"></line>
          <line x1="8" y1="11" x2="14" y2="11"></line>
        </svg>
      </div>
      <div class="gallery-overlay">
        <div class="judul"><%=judul%></div>
        <span class="kategori"><%=labelKat%></span>
      </div>
    </div>
  <%
    }
  %>
  </div>
</div>

<!-- ============ LIGHTBOX MODAL ============ -->
<div class="lightbox" id="lightbox" onclick="if(event.target===this)tutupLightbox()">
  <div class="lightbox-img-wrap">
    <button class="lightbox-close" onclick="tutupLightbox()" title="Tutup">
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <line x1="18" y1="6" x2="6" y2="18"></line>
        <line x1="6" y1="6" x2="18" y2="18"></line>
      </svg>
    </button>

    <button class="lightbox-nav prev" onclick="navLightbox(-1)" title="Sebelumnya">
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="15 18 9 12 15 6"></polyline>
      </svg>
    </button>

    <img id="lightboxImg" src="" alt="">

    <button class="lightbox-nav next" onclick="navLightbox(1)" title="Selanjutnya">
      <svg viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="9 18 15 12 9 6"></polyline>
      </svg>
    </button>

    <div class="lightbox-caption">
      <div class="judul" id="lightboxJudul">-</div>
      <div class="counter" id="lightboxCounter">- / -</div>
    </div>
  </div>
</div>

<script>
  // Data galeri (paralel dengan JSP loop)
  var dataGaleri = [
    <%
      for(int i = 0; i < galeri.length; i++){
        out.print("{\"url\":\"" + galeri[i][0] + "\",\"judul\":\"" + galeri[i][1].replace("\"","\\\"") + "\"}");
        if(i < galeri.length - 1) out.print(",");
      }
    %>
  ];

  var indexAktif = 0;

  function bukaLightbox(i){
    indexAktif = i;
    tampilkanLightbox();
    document.getElementById('lightbox').classList.add('aktif');
    document.body.style.overflow = 'hidden';
  }

  function tutupLightbox(){
    document.getElementById('lightbox').classList.remove('aktif');
    document.body.style.overflow = '';
  }

  function navLightbox(arah){
    indexAktif += arah;
    if(indexAktif < 0) indexAktif = dataGaleri.length - 1;
    if(indexAktif >= dataGaleri.length) indexAktif = 0;
    tampilkanLightbox();
  }

  function tampilkanLightbox(){
    var item = dataGaleri[indexAktif];
    document.getElementById('lightboxImg').src = item.url;
    document.getElementById('lightboxJudul').innerText = item.judul;
    document.getElementById('lightboxCounter').innerText = (indexAktif+1) + ' / ' + dataGaleri.length;
  }

  // Navigasi keyboard
  document.addEventListener('keydown', function(e){
    if(!document.getElementById('lightbox').classList.contains('aktif')) return;
    if(e.key === 'Escape') tutupLightbox();
    if(e.key === 'ArrowLeft') navLightbox(-1);
    if(e.key === 'ArrowRight') navLightbox(1);
  });

  // Filter kategori
  function filterKategori(kat, btn){
    // Update tombol aktif
    document.querySelectorAll('.filter-btn').forEach(function(b){
      b.classList.remove('aktif');
    });
    btn.classList.add('aktif');

    // Filter item
    document.querySelectorAll('.gallery-item').forEach(function(item){
      var itemKat = item.getAttribute('data-kategori');
      if(kat === 'semua' || itemKat === kat){
        item.style.display = '';
        item.style.animation = 'zoomIn 0.3s ease';
      } else {
        item.style.display = 'none';
      }
    });
  }
</script>

<%@ include file="footer.jsp" %>