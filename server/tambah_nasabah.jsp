<%@ include file="header.jsp" %>

<style>
  .form-header {
    background: linear-gradient(135deg, #0d47a1, #1976d2);
    color: #fff;
    padding: 30px;
    border-radius: 12px;
    text-align: center;
    margin-bottom: 25px;
    box-shadow: 0 8px 25px rgba(13, 71, 161, 0.25);
  }
  .form-header h2 { color: #fff; margin-bottom: 8px; }
  .form-header p { opacity: 0.9; }

  .form-card {
    background: #fff;
    padding: 35px;
    border-radius: 14px;
    box-shadow: 0 6px 25px rgba(0,0,0,0.08);
    max-width: 700px;
    margin: 0 auto;
  }

  .form-group {
    margin-bottom: 20px;
  }
  .form-group label {
    display: block;
    color: #0d47a1;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 14px;
  }
  .form-group label .wajib {
    color: #e53935;
  }
  .form-group input,
  .form-group textarea {
    width: 100%;
    padding: 13px 16px;
    border: 2px solid #e3f2fd;
    border-radius: 10px;
    font-size: 14px;
    font-family: inherit;
    outline: none;
    transition: 0.3s;
    background: #fafcff;
  }
  .form-group input:focus,
  .form-group textarea:focus {
    border-color: #1976d2;
    background: #fff;
    box-shadow: 0 0 0 3px rgba(25, 118, 210, 0.1);
  }
  .form-group textarea {
    resize: vertical;
    min-height: 80px;
  }

  .form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
  }
  @media(max-width:600px){
    .form-row { grid-template-columns: 1fr; }
  }

  .form-aksi {
    display: flex;
    gap: 12px;
    margin-top: 25px;
  }
  .btn-simpan {
    flex: 2;
    background: linear-gradient(90deg, #1976d2, #0d47a1);
    color: #fff;
    padding: 14px;
    border: none;
    border-radius: 25px;
    font-size: 15px;
    font-weight: 600;
    cursor: pointer;
    transition: 0.3s;
  }
  .btn-simpan:hover {
    background: #0d47a1;
    box-shadow: 0 6px 15px rgba(13, 71, 161, 0.4);
    transform: translateY(-2px);
  }
  .btn-batal {
    flex: 1;
    background: #f5f5f5;
    color: #666;
    padding: 14px;
    border-radius: 25px;
    text-decoration: none;
    font-size: 15px;
    font-weight: 600;
    text-align: center;
    transition: 0.3s;
  }
  .btn-batal:hover {
    background: #eeeeee;
    color: #333;
  }

  .alert-error {
    background: #ffebee;
    color: #c62828;
    padding: 15px;
    border-radius: 10px;
    border-left: 5px solid #f44336;
    margin-bottom: 20px;
    font-size: 14px;
  }
  .info-box {
    background: linear-gradient(135deg, #e3f2fd, #f0f7ff);
    padding: 15px 20px;
    border-radius: 10px;
    border-left: 4px solid #1976d2;
    margin-bottom: 25px;
    font-size: 13px;
    color: #0d47a1;
  }
</style>

<!-- ============ HEADER ============ -->
<div class="container">
  <div class="form-header">
    <h2>➕ Tambah Nasabah Baru</h2>
    <p>Lengkapi data nasabah di bawah ini</p>
  </div>

  <%
    String err = request.getParameter("err");
    if(err != null){
  %>
    <div class="alert-error">
      ❌ <b>Gagal menambahkan nasabah.</b>
      <% if("db".equals(err)){ %>Terjadi error pada database.<% } %>
      <% if("kosong".equals(err)){ %>Data wajib belum lengkap.<% } %>
    </div>
  <%
    }
  %>

  <div class="info-box">
    💡 <b>Info:</b> Field dengan tanda <span style="color:#e53935">*</span> wajib diisi.
  </div>

  <!-- ============ FORM ============ -->
  <div class="form-card">
    <form action="simpan_nasabah.jsp" method="post" onsubmit="return validasi()">

      <div class="form-group">
        <label>Nama Lengkap <span class="wajib">*</span></label>
        <input type="text" name="nama" id="nama" required
               placeholder="Contoh: Budi Santoso" maxlength="100">
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>No. Telepon <span class="wajib">*</span></label>
          <input type="text" name="telepon" id="telepon" required
                 placeholder="0812-xxxx-xxxx" maxlength="20">
        </div>
        <div class="form-group">
          <label>Email <span class="wajib">*</span></label>
          <input type="email" name="email" id="email" required
                 placeholder="email@contoh.com" maxlength="100">
        </div>
      </div>

      <div class="form-group">
        <label>Alamat Lengkap <span class="wajib">*</span></label>
        <textarea name="alamat" id="alamat" required
                  placeholder="Contoh: Jl. Merdeka No.1, Jakarta Pusat"></textarea>
      </div>

      <div class="form-aksi">
        <a href="nasabah.jsp" class="btn-batal">← Batal</a>
        <button type="submit" class="btn-simpan">💾 Simpan Nasabah</button>
      </div>
    </form>
  </div>
</div>

<script>
function validasi(){
  var nama = document.getElementById('nama').value.trim();
  var telepon = document.getElementById('telepon').value.trim();
  var email = document.getElementById('email').value.trim();
  var alamat = document.getElementById('alamat').value.trim();

  if(nama.length < 3){
    alert('Nama minimal 3 karakter!');
    return false;
  }
  if(telepon.length < 8){
    alert('Nomor telepon minimal 8 digit!');
    return false;
  }
  if(!email.includes('@') || !email.includes('.')){
    alert('Format email tidak valid!');
    return false;
  }
  if(alamat.length < 5){
    alert('Alamat minimal 5 karakter!');
    return false;
  }
  return true;
}
</script>

<%@ include file="footer.jsp" %>