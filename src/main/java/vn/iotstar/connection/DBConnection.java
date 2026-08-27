package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ShoppingDB";
    private final String portNumber = "1433";
    private final String userID = "sa"; 
    private final String password = "Ngobavan@11021997"; 

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber 
                   + ";databaseName=" + dbName + ";encrypt=false;trustServerCertificate=true;";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    public static void main(String[] args) {
        try {
            System.out.println("Đang thử kết nối...");
            Connection conn = new DBConnection().getConnection();
            System.out.println("==> KẾT NỐI THÀNH CÔNG: " + conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}