<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<style>
  .login-wrapper {
    display: flex;
    align-items: center;
    justify-content: center;
    min-height: 65vh;
    padding: 20px 0;
  }
  .login-box {
    background: #fff;
    border-radius: 18px;
    box-shadow: 0 15px 40px rgba(13, 71, 161, 0.15);
    overflow: hidden;
    max-width: 420px;
    width: 100%;
    animation: fadeIn 0.5s ease;
  }
  @keyframes fadeIn {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
  }
  @keyframes shake {
    0%, 100% { transform: translateX(0); }
    20%, 60% { transform: translateX(-10px); }
    40%, 80% { transform: translateX(10px); }
  }
  .login-box.shake {
    animation: shake 0.5s;
  }

  .login-head {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 35px 30px 30px;
    text-align: center;
    position: relative;
  }
  .login-head::after {
    content: "";
    position: absolute;
    bottom: -1px; left: 0;
    width: 100%; height: 20px;
    background: #fff;
    border-radius: 20px 20px 0 0;
  }
  .login-icon {
    width: 70px;
    height: 70px;
    background: rgba(255,255,255,0.2);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 28px;
    font-weight: bold;
    letter-spacing: 1px;
    margin: 0 auto 15px;
    border: 2px solid rgba(255,255,255,0.35);
    color: #fff;
  }
  .login-head h2 {
    color: #fff;
    margin-bottom: 5px;
    font-size: 24px;
  }
  .login-head p {
    font-size: 14px;
    opacity: 0.9;
  }

  .login-body {
    padding: 30px;
  }

  .alert-error {
    background: #ffebee;
    color: #c62828;
    padding: 12px 15px;
    border-radius: 10px;
    border-left: 4px solid #f44336;
    margin-bottom: 20px;
    font-size: 14px;
  }
  .alert-sukses {
    background: #e8f5e9;
    color: #2e7d32;
    padding: 12px 15px;
    border-radius: 10px;
    border-left: 4px solid #4caf50;
    margin-bottom: 20px;
    font-size: 14px;
  }

  .form-group {
    margin-bottom: 18px;
  }
  .form-group label {
    display: block;
    color: #0d47a1;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 13px;
  }
  .input-wrap {
    position: relative;
  }
  .input-wrap input {
    width: 100%;
    padding: 13px 45px 13px 15px;
    border: 2px solid #e3f2fd;
    border-radius: 10px;
    font-size: 14px;
    font-family: inherit;
    outline: none;
    transition: 0.3s;
    background: #fafcff;
  }
  .input-wrap input:focus {
    border-color: #1976d2;
    background: #fff;
    box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
  }
  .input-wrap .toggle-pass {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    background: #e3f2fd;
    border: none;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    padding: 6px 10px;
    border-radius: 15px;
    color: #1976d2;
    transition: 0.3s;
  }
  .input-wrap .toggle-pass:hover {
    background: #bbdefb;
  }

  .btn-login {
    width: 100%;
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 14px;
    border: none;
    border-radius: 25px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
    margin-top: 10px;
    letter-spacing: 0.5px;
  }
  .btn-login:hover {
    background: #0d47a1;
    box-shadow: 0 6px 20px rgba(13, 71, 161, 0.4);
    transform: translateY(-2px);
  }
  .btn-login:active {
    transform: translateY(0);
  }

  .info-demo {
    background: linear-gradient(135deg, #e3f2fd, #f0f7ff);
    padding: 15px;
    border-radius: 10px;
    border-left: 4px solid #1976d2;
    margin-top: 20px;
    font-size: 13px;
    color: #0d47a1;
    line-height: 1.6;
  }
  .info-demo b { color: #0d47a1; }
  .info-demo code {
    background: #fff;
    padding: 2px 8px;
    border-radius: 5px;
    font-family: 'Courier New', monospace;
    color: #1976d2;
    font-weight: bold;
  }

  .login-footer-links {
    text-align: center;
    margin-top: 20px;
    font-size: 13px;
    color: #666;
  }
  .login-footer-links a {
    color: #1976d2;
    text-decoration: none;
    font-weight: 600;
  }
  .login-footer-links a:hover {
    text-decoration: underline;
  }

  .divider {
    display: flex;
    align-items: center;
    margin: 20px 0;
    color: #999;
    font-size: 12px;
  }
  .divider::before, .divider::after {
    content: "";
    flex: 1;
    height: 1px;
    background: #eee;
  }
  .divider span { padding: 0 12px; }
</style>

<div class="login-wrapper">
  <div class="login-box" id="loginBox">

    <!-- HEADER -->
    <div class="login-head">
      <div class="login-icon">AKUN</div>
      <h2>Masuk Akun</h2>
      <p>Sistem Penjualan Asuransi Jiwa</p>
    </div>

    <!-- BODY -->
    <div class="login-body">

      <%
        if(request.getParameter("err") != null){
      %>
        <div class="alert-error">
          <b>Login gagal!</b> Periksa username dan password, atau coba lagi nanti.
        </div>
      <%
        }
        if("registered".equals(request.getParameter("success"))){ %>
        <div class="alert-sukses"><b>Pendaftaran berhasil!</b> Silakan masuk menggunakan akun baru Anda.</div>
      <% }
        if(request.getParameter("logout") != null){
      %>
        <div class="alert-sukses">
          <b>Logout berhasil.</b> Sampai jumpa!
        </div>
      <%
        }
      %>

      <form action="LoginServlet" method="post" onsubmit="return validasi()">

        <!-- USERNAME -->
        <div class="form-group">
          <label>Username</label>
          <div class="input-wrap">
            <input type="text" name="u" id="u" required
                   placeholder="Masukkan username" autocomplete="username">
          </div>
        </div>

        <!-- PASSWORD -->
        <div class="form-group">
          <label>Password</label>
          <div class="input-wrap">
            <input type="password" name="p" id="p" required
                   placeholder="Masukkan password" autocomplete="current-password">
            <button type="button" class="toggle-pass" onclick="togglePass()" id="btnToggle">
              LIHAT
            </button>
          </div>
        </div>

        <!-- SUBMIT -->
        <button class="btn-login" type="submit">Masuk Sekarang</button>

      </form>

      <div class="login-footer-links" style="margin-top:18px">
        Belum punya akun? <a href="daftar.jsp">Daftar Akun Sekarang</a>
      </div>

      <!-- INFO DEMO -->
      <div class="info-demo">
        <b>Info Login Demo:</b><br>
        Username: <code>admin</code> &nbsp;|&nbsp; Password: <code>admin</code>
      </div>

      <!-- LINK BAWAH -->
      <div class="login-footer-links">
        <a href="#">Lupa Password?</a> &nbsp;&middot;&nbsp;
        <a href="kontak.jsp">Bantuan</a>
      </div>

      <div class="divider"><span>atau</span></div>

      <div style="text-align:center">
        <a href="index.jsp" style="color:#1976d2;text-decoration:none;font-size:14px;font-weight:600">
          &larr; Kembali ke Beranda
        </a>
      </div>

    </div>
  </div>
</div>

<script>
  function togglePass(){
    var input = document.getElementById('p');
    var btn = document.getElementById('btnToggle');
    if(input.type === 'password'){
      input.type = 'text';
      btn.innerText = 'SEMBUNYI';
    } else {
      input.type = 'password';
      btn.innerText = 'LIHAT';
    }
  }

  function validasi(){
    var u = document.getElementById('u').value.trim();
    var p = document.getElementById('p').value.trim();
    if(u.length < 3){
      alert('Username minimal 3 karakter!');
      return false;
    }
    if(p.length < 3){
      alert('Password minimal 3 karakter!');
      return false;
    }
    return true;
  }

  // Animasi shake kalau ada error
  <% if(request.getParameter("err") != null){ %>
    window.addEventListener('DOMContentLoaded', function(){
      document.getElementById('loginBox').classList.add('shake');
      setTimeout(function(){
        document.getElementById('loginBox').classList.remove('shake');
      }, 600);
    });
  <% } %>

  // Fokus ke input pertama
  window.addEventListener('DOMContentLoaded', function(){
    document.getElementById('u').focus();
  });
</script>

<%@ include file="footer.jsp" %>