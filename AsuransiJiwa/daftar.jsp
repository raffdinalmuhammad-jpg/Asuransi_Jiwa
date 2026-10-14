<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*,koneksi.Koneksi,koneksi.PasswordUtil" %>
<%
request.setCharacterEncoding("UTF-8");
String error = null;
if ("POST".equalsIgnoreCase(request.getMethod())) {
    String username = request.getParameter("username") == null ? "" : request.getParameter("username").trim();
    String password = request.getParameter("password") == null ? "" : request.getParameter("password");
    String confirmation = request.getParameter("konfirmasi") == null ? "" : request.getParameter("konfirmasi");
    if (!username.matches("[A-Za-z0-9_]{3,50}")) {
        error = "Username harus 3–50 karakter, hanya huruf, angka, atau garis bawah.";
    } else if (password.length() < 8 || password.length() > 128) {
        error = "Password harus memiliki 8–128 karakter.";
    } else if (!password.equals(confirmation)) {
        error = "Konfirmasi password tidak cocok.";
    } else {
        try (Connection connection = Koneksi.getConnection()) {
            try (PreparedStatement check = connection.prepareStatement("SELECT id FROM users WHERE username = ?")) {
                check.setString(1, username);
                try (ResultSet result = check.executeQuery()) {
                    if (result.next()) error = "Username sudah digunakan. Pilih username lain.";
                }
            }
            if (error == null) {
                try (PreparedStatement insert = connection.prepareStatement(
                        "INSERT INTO users (username, password, role) VALUES (?, ?, ?)")) {
                    insert.setString(1, username);
                    insert.setString(2, PasswordUtil.hash(password));
                    insert.setString(3, "user");
                    insert.executeUpdate();
                    response.sendRedirect("login.jsp?success=registered");
                    return;
                }
            }
        } catch (SQLIntegrityConstraintViolationException duplicate) {
            error = "Username sudah digunakan. Pilih username lain.";
        } catch (Exception exception) {
            application.log("Gagal membuat akun", exception);
            error = "Pendaftaran gagal. Periksa koneksi database dan pembaruan tabel users.";
        }
    }
}
%>
<%@ include file="header.jsp" %>
<style>
  .register-wrapper{display:flex;justify-content:center;align-items:center;min-height:70vh;padding:30px 16px}
  .register-box{width:100%;max-width:460px;background:white;border-radius:18px;overflow:hidden;box-shadow:0 15px 40px rgba(13,71,161,.15)}
  .register-head{background:linear-gradient(135deg,#0d47a1,#1976d2);padding:30px;color:#fff;text-align:center}
  .register-head h2{color:white;margin:0 0 7px}.register-head p{margin:0;font-size:14px}
  .register-body{padding:30px}.register-group{margin-bottom:18px}
  .register-group label{display:block;font-size:13px;font-weight:600;color:#0d47a1;margin-bottom:7px}
  .register-group input{width:100%;box-sizing:border-box;padding:13px;border:2px solid #e3f2fd;border-radius:10px;background:#fafcff;font-size:14px}
  .register-group input:focus{outline:none;border-color:#1976d2}
  .register-help{font-size:12px;color:#666;margin-top:5px;display:block}
  .register-btn{width:100%;padding:14px;border:0;border-radius:25px;background:linear-gradient(90deg,#1976d2,#0d47a1);color:white;font-size:15px;font-weight:600;cursor:pointer}
  .register-btn:hover{background:#0d47a1}.register-error{padding:12px 15px;border-left:4px solid #f44336;background:#ffebee;color:#c62828;border-radius:9px;margin-bottom:18px;font-size:14px}
  .register-links{text-align:center;margin-top:20px;font-size:14px}.register-links a{color:#1976d2;font-weight:600;text-decoration:none}
</style>
<div class="register-wrapper"><div class="register-box">
  <div class="register-head"><h2>Daftar Akun Baru</h2><p>Sistem Penjualan Asuransi Jiwa</p></div>
  <div class="register-body">
    <% if (error != null) { %><div class="register-error"><%= error %></div><% } %>
    <form method="post" action="daftar.jsp">
      <div class="register-group"><label for="username">Username</label>
        <input id="username" name="username" type="text" minlength="3" maxlength="50" pattern="[A-Za-z0-9_]{3,50}" required autocomplete="username" placeholder="Buat username">
        <span class="register-help">Minimal 3 karakter, tanpa spasi.</span></div>
      <div class="register-group"><label for="password">Password</label>
        <input id="password" name="password" type="password" minlength="8" maxlength="128" required autocomplete="new-password" placeholder="Buat password">
        <span class="register-help">Minimal 8 karakter.</span></div>
      <div class="register-group"><label for="konfirmasi">Konfirmasi Password</label>
        <input id="konfirmasi" name="konfirmasi" type="password" minlength="8" maxlength="128" required autocomplete="new-password" placeholder="Ulangi password"></div>
      <button type="submit" class="register-btn">Daftar Sekarang</button>
    </form>
    <div class="register-links">Sudah punya akun? <a href="login.jsp">Masuk di sini</a><br><br><a href="index.jsp">&larr; Kembali ke Beranda</a></div>
  </div>
</div></div>
<%@ include file="footer.jsp" %>
