<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Asuransi Jiwa</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="navbar">
  <div><b>Asuransi Jiwa Sejahtera</b></div>
  <div>
    <a href="index.jsp">Home</a>
    <a href="produk.jsp">Produk</a>
    <a href="nasabah.jsp">Nasabah</a>
    <a href="polis.jsp">Polis</a>
    <a href="pembayaran.jsp">Pembayaran</a>
    <a href="klaim.jsp">Klaim</a>
    <a href="gallery.jsp">Gallery</a>
    <a href="tentang.jsp">Tentang</a>
    <a href="kontak.jsp">Kontak</a>
    <% if(session.getAttribute("user")!=null){ %>
      <% if ("admin".equalsIgnoreCase((String)session.getAttribute("role"))) { %><a href="dashboard.jsp">Dashboard</a><% } %>
      <a href="logout.jsp">Logout</a>
    <% } else { %>
      <a href="login.jsp">Login</a>
    <% } %>
  </div>
</div>