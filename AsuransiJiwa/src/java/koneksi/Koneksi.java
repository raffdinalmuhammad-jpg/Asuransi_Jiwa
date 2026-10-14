package koneksi;
import java.sql.*;
public class Koneksi {
    public static Connection getConnection() throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        return DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/asuransi_jiwa","root","");
    }
}