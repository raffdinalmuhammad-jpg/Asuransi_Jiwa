# AsuransiJiwa — JSP + MySQL dan GitHub Pages Preview

## Isi ZIP
- `AsuransiJiwa/`: kode sumber JSP/Java asli dan pembaruan koneksi database.
- `AsuransiJiwa/database/asuransi_jiwa_import.sql`: SQL untuk **database baru/kosong**, termasuk data contoh nasabah dan username yang tidak duplikat.
- `AsuransiJiwa/database/asuransi_jiwa_asli.sql`: SQL asli yang dikirim pengguna, tidak diubah.
- `github-preview/`: preview interaktif HTML mandiri untuk GitHub Pages. **Bukan aplikasi backend sungguhan.**

## Preview GitHub Pages
1. Buat repository GitHub, upload **isi ZIP** (folder `github-preview` dan `AsuransiJiwa` beserta README).
2. Buka **Settings → Pages → Build and deployment → Deploy from a branch**.
3. Pilih branch `main`, folder `/docs` tidak tersedia dalam paket ini; agar Pages berjalan langsung, pindahkan `github-preview/index.html` dan `.nojekyll` ke root repository, lalu pilih `/ (root)`.
4. Tunggu deployment dan buka URL Pages yang ditampilkan GitHub.

Alternatif: salin isi `github-preview/` ke folder `docs/` pada repository lalu pilih `/docs` pada Pages.

## Menjalankan aplikasi JSP sebenarnya
1. Jalankan MySQL melalui XAMPP. Buat database kosong `asuransi_jiwa` di phpMyAdmin.
2. Import `AsuransiJiwa/database/asuransi_jiwa_import.sql` **hanya pada database kosong**. Jangan impor ulang ke database berisi data.
3. Gunakan NetBeans dengan Apache Tomcat yang kompatibel dengan `javax.servlet` (contoh Tomcat 9) dan JDK yang sesuai.
4. Import proyek sebagai web application, atur source `AsuransiJiwa/src/java`, web root `AsuransiJiwa`, dan library JDBC dari `WEB-INF/lib`.
5. Koneksi default: `localhost:3306`, database `asuransi_jiwa`, user `root`, password kosong (XAMPP lokal). Dapat diganti melalui environment variables `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`.
6. Buka `http://localhost:8080/AsuransiJiwa/` (sesuaikan context path server).

**Catatan keamanan:** Dump awal menyimpan password demo sebagai plaintext dan beberapa halaman JSP menggunakan SQL langsung. Paket ini tidak diaudit menyeluruh dan tidak boleh dipakai untuk data pelanggan nyata atau dipublikasikan sebagai backend produksi. Ganti kredensial, periksa otorisasi dan seluruh query sebelum deployment. Login contoh `admin/admin` hanya untuk lingkungan lokal demo. Jangan unggah data pribadi asli atau kredensial produksi ke GitHub.

## Batasan
Preview GitHub Pages mensimulasikan navigasi, daftar data, tambah data lokal dan kalkulasi sederhana; tidak menggunakan MySQL, tidak mengirim formulir ke server, dan tidak menggantikan backend JSP. Proyek JSP masih perlu pengujian end-to-end pada NetBeans/Tomcat/MySQL.
