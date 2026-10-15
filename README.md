# Asuransi Jiwa Sejahtera

Repository ini berisi dua bagian:

- `index.html` + `assets/` = preview statis yang bisa dijalankan langsung melalui GitHub Pages.
- `server/` = project JSP + Servlet + MySQL asli, dipertahankan untuk dijalankan dengan Tomcat/NetBeans.
- `database/asuransi_jiwa.sql` = database asli.

## Preview GitHub Pages

1. Upload **isi folder repository ini** ke repository GitHub (bukan file ZIP sebagai satu file).
2. Buka **Settings → Pages**.
3. Pada **Build and deployment**, pilih **Deploy from a branch**.
4. Pilih branch `main` dan folder `/ (root)`, lalu Save.
5. Tunggu GitHub Pages selesai deploy, kemudian buka URL Pages yang diberikan GitHub.

Preview mendukung login/register demo dengan localStorage. Login demo awal: `admin` / `admin`.

## Menjalankan versi asli

Gunakan folder `server/` dengan Apache Tomcat/NetBeans dan import `database/asuransi_jiwa.sql` ke MariaDB/MySQL.
