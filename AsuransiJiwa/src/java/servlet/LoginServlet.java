package servlet;

import koneksi.Koneksi;
import koneksi.PasswordUtil;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("u");
        String password = request.getParameter("p");
        if (username == null || password == null) {
            response.sendRedirect("login.jsp?err=1");
            return;
        }
        try (Connection connection = Koneksi.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                 "SELECT username, password, role FROM users WHERE username = ?")) {
            statement.setString(1, username.trim());
            try (ResultSet result = statement.executeQuery()) {
                if (result.next() && PasswordUtil.matches(password, result.getString("password"))) {
                    HttpSession oldSession = request.getSession(false);
                    if (oldSession != null) oldSession.invalidate();
                    HttpSession session = request.getSession(true);
                    session.setAttribute("user", result.getString("username"));
                    String role = result.getString("role");
                    session.setAttribute("role", role);
                    response.sendRedirect("admin".equalsIgnoreCase(role) ? "dashboard.jsp" : "index.jsp");
                    return;
                }
            }
            response.sendRedirect("login.jsp?err=1");
        } catch (Exception exception) {
            log("Gagal login", exception);
            response.sendRedirect("login.jsp?err=server");
        }
    }
}
