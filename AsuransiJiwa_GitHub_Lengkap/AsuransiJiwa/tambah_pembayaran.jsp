<%@ include file="header.jsp" %>
<%@ page import="java.sql.*" %>

<div class="container">
  <h2>➕ Tambah Pembayaran</h2>

  <%
    String sukses = request.getParameter("sukses");
    if("1".equals(sukses)){
  %>
    <div style="background:#e8f5e9;color:#2e7d32;padding:15px;border-radius:8px;border-left:5px solid #4caf50;margin-bottom:20px">
      ✅ Pembayaran berhasil disimpan!
    </div>
  <%
    }
  %>

  <form action="simpan_pembayaran.jsp" method="post" class="card">
    <p>Polis ID: <input type="number" name="polis_id" required style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc"></p>
    <p>Jumlah (Rp): <input type="number" name="jumlah" required style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc"></p>
    <p>Tanggal: <input type="date" name="tanggal" required style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc"></p>
    <p>Metode: 
      <select name="metode" style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc">
        <option>Transfer</option>
        <option>Tunai</option>
        <option>Virtual Account</option>
      </select>
    </p>
    <p>Status: 
      <select name="status" style="padding:10px;width:100%;border-radius:8px;border:1px solid #ccc">
        <option>Lunas</option>
        <option>Pending</option>
      </select>
    </p>
    <button class="btn" type="submit">💾 Simpan</button>
  </form>
</div>

<%@ include file="footer.jsp" %>