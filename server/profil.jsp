<%@ include file="header.jsp" %>
<div class="container"><h2>Profil Saya</h2>
<p>Username: <%=session.getAttribute("user")%></p>
<p>Role: Admin</p></div>
<%@ include file="footer.jsp" %>