# Asuransi Jiwa — Paket GitHub Pages + proyek JSP asli

## GitHub Pages
Upload **isi folder ZIP** ke root repository (index.html harus di root), lalu Settings > Pages > Deploy from branch > main > /(root).
Halaman utama `index.html`, login demo `login.html`, dan dashboard demo `dashboard.html`.
Akun preview: `demo` / `demo` (BUKAN autentikasi nyata). Preview tidak membaca/menulis database.

## Proyek asli
Folder `AsuransiJiwa/` menyimpan file JSP, Servlet, WEB-INF, library, menu dan struktur NetBeans asli. SQL asli juga disertakan sebagai `database_asuransi_jiwa_asli.sql`, ditambah file database yang sudah ada di ZIP.
Jalankan JSP + MySQL di Tomcat untuk fitur login nyata dan CRUD.

## Keamanan
**PENTING:** Jangan unggah dump SQL berisi data pribadi, akun, password, atau file konfigurasi rahasia ke repository publik. Gunakan repository PRIVATE untuk menyimpan sumber asli; untuk GitHub Pages publik, publikasikan hanya file HTML/CSS/JS preview. GitHub Pages tidak menjalankan JSP/Java/MySQL.
